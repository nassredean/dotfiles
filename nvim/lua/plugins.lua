local fn = vim.fn
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
local packer_bootstrap = nil

if fn.empty(fn.glob(install_path)) > 0 then
    packer_bootstrap =
        fn.system(
        {
            "git",
            "clone",
            "--depth",
            "1",
            "https://github.com/wbthomason/packer.nvim",
            install_path
        }
    )
end

return require("packer").startup(
    {
        function(use)
            -- Packer can manage itself
            use "wbthomason/packer.nvim"

            -- Needed to load first
            use {"nathom/filetype.nvim"}
            use {"nvim-lua/plenary.nvim"}
            use {"kyazdani42/nvim-web-devicons"}
            use {
                "glepnir/dashboard-nvim",
                config = "require('plugins.dashboard')"
            }

            -- Themes
            use {"folke/tokyonight.nvim"}

            -- Treesitter
            use {
                "nvim-treesitter/nvim-treesitter",
                config = "require('plugins.treesitter')"
            }
            use {
                "nvim-treesitter/nvim-treesitter-textobjects",
                after = {"nvim-treesitter"}
            }
            use {
                "RRethy/nvim-treesitter-textsubjects",
                after = {"nvim-treesitter"}
            }
            use {
                "m-demare/hlargs.nvim",
                config = function()
                    require("hlargs").setup()
                end
            }

            -- Telescope
            use {
                "nvim-telescope/telescope.nvim",
                requires = {
                    {"nvim-lua/popup.nvim"},
                    {"nvim-lua/plenary.nvim"}
                },
                config = "require('plugins.telescope')"
            }

            -- LSP
            use {"neovim/nvim-lspconfig"}

            -- LSP Cmp
            use {
                "hrsh7th/nvim-cmp",
                event = "InsertEnter",
                config = "require('plugins.cmp')"
            }
            use {
                "hrsh7th/cmp-nvim-lua",
                after = "nvim-cmp"
            }
            use {
                "hrsh7th/cmp-nvim-lsp",
                after = "cmp-nvim-lua"
            }
            use {
                "hrsh7th/cmp-buffer",
                after = "cmp-nvim-lsp"
            }
            use {
                "hrsh7th/cmp-path",
                after = "cmp-buffer"
            }
            use {
                "hrsh7th/cmp-cmdline",
                after = "cmp-path"
            }
            use {
                "hrsh7th/cmp-calc",
                after = "cmp-cmdline"
            }

            -- LSP Addons
            use {
                "williamboman/nvim-lsp-installer",
                after = "cmp-nvim-lsp",
                requires = "hrsh7th/cmp-nvim-lsp",
                config = function()
                    require("nvim-lsp-installer").setup {
                        -- A list of servers to automatically install if they're not already installed
                        ensure_installed = {
                            "bashls",
                            "cssls",
                            "eslint",
                            "graphql",
                            "html",
                            "jsonls",
                            "sumneko_lua",
                            "tailwindcss",
                            "tsserver",
                            "vetur",
                            "vuels"
                        },
                        -- Whether servers that are set up (via lspconfig) should be automatically installed if they're not already installed
                        automatic_installation = true
                    }
                    local lspconfig = require("lspconfig")

                    local handlers = {
                        ["textDocument/hover"] = vim.lsp.with(
                            vim.lsp.handlers.hover,
                            {
                                border = "rounded"
                            }
                        ),
                        ["textDocument/signatureHelp"] = vim.lsp.with(
                            vim.lsp.handlers.signature_help,
                            {
                                border = "rounded"
                            }
                        )
                    }

                    local function on_attach(client, bufnr)
                        -- set up buffer keymaps, etc.
                    end

                    local on_ts_attach = function(client, bufnr)
                        client.server_capabilities.document_formatting = false
                        client.server_capabilities.document_range_formatting = false

                        local function buf_set_option(...)
                            vim.api.nvim_buf_set_option(bufnr, ...)
                        end

                        buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")
                    end

                    local capabilities = vim.lsp.protocol.make_client_capabilities()
                    local cmp_nvim_lsp_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
                    if cmp_nvim_lsp_ok then
                        capabilities = cmp_nvim_lsp.update_capabilities(vim.lsp.protocol.make_client_capabilities())

                        lspconfig.eslint.setup {
                            capabilities = capabilities,
                            handlers = handlers,
                            on_attach = require("lsp.servers.eslint").on_attach,
                            settings = require("lsp.servers.eslint").settings
                        }

                        lspconfig.jsonls.setup {
                            capabilities = capabilities,
                            handlers = handlers,
                            on_attach = on_attach,
                            settings = require("lsp.servers.jsonls").settings
                        }

                        lspconfig.sumneko_lua.setup {
                            handlers = handlers,
                            on_attach = on_attach,
                            settings = require("lsp.servers.sumneko_lua").settings
                        }

                        local tscapabilities =
                            require("cmp_nvim_lsp").update_capabilities(vim.lsp.protocol.make_client_capabilities())
                        tscapabilities.textDocument.completion.completionItem.snippetSupport = true
                        tscapabilities.textDocument.completion.completionItem.preselectSupport = true
                        tscapabilities.textDocument.completion.completionItem.insertReplaceSupport = true
                        tscapabilities.textDocument.completion.completionItem.labelDetailsSupport = true
                        tscapabilities.textDocument.completion.completionItem.deprecatedSupport = true
                        tscapabilities.textDocument.completion.completionItem.commitCharactersSupport = true
                        tscapabilities.textDocument.completion.completionItem.tagSupport = {
                            valueSet = {1}
                        }
                        tscapabilities.textDocument.completion.completionItem.resolveSupport = {
                            properties = {"documentation", "detail", "additionalTextEdits"}
                        }
                        tscapabilities.textDocument.codeAction = {
                            dynamicRegistration = false,
                            codeActionLiteralSupport = {
                                codeActionKind = {
                                    valueSet = {
                                        "",
                                        "quickfix",
                                        "refactor",
                                        "refactor.extract",
                                        "refactor.inline",
                                        "refactor.rewrite",
                                        "source",
                                        "source.organizeImports"
                                    }
                                }
                            }
                        }

                        -- It enables tsserver automatically so no need to call lspconfig.tsserver.setup
                        require("typescript").setup(
                            {
                                disable_commands = false, -- prevent the plugin from creating Vim commands
                                disable_formatting = false, -- disable tsserver's formatting capabilities
                                debug = false, -- enable debug logging for commands
                                -- LSP Config options
                                server = {
                                    capabilities = tscapabilities,
                                    handlers = handlers,
                                    on_attach = on_ts_attach
                                }
                            }
                        )

                        for _, server in ipairs {"bashls", "cssls", "html"} do
                            lspconfig[server].setup {
                                on_attach = on_attach,
                                capabilities = capabilities,
                                handlers = handlers
                            }
                        end
                    end
                end
            }
            use {
                "stevearc/dressing.nvim",
                requires = "MunifTanjim/nui.nvim",
                config = "require('plugins.dressing')"
            }
            use {"onsails/lspkind-nvim"}
            use {
                "folke/lsp-trouble.nvim",
                config = "require('plugins.trouble')"
            }
            use {"nvim-lua/popup.nvim"}
            use {
                "SmiteshP/nvim-gps",
                config = "require('plugins.gps')",
                after = "nvim-treesitter"
            }
            use {
                "jose-elias-alvarez/typescript.nvim",
                after = "nvim-treesitter"
            }

            use {"rcarriga/nvim-notify"}

            -- Nvim Tree / Rooter
            use {"kyazdani42/nvim-tree.lua", config = "require('plugins.tree')"}
            use {
                "airblade/vim-rooter",
                setup = function()
                    vim.g.rooter_patterns = {".git", "package.json", "_darcs", ".bzr", ".svn", "Makefile"}
                end
            }

            -- Git
            use "tpope/vim-fugitive"

            -- Better formatting
            use "sbdchd/neoformat"

            -- Indentation guides
            use {"lukas-reineke/indent-blankline.nvim", config = "require('plugins.indent')"}

            -- Better commenting
            use {"terrortylor/nvim-comment", config = "require('plugins.comment')"}

            -- Better bufferline
            use {
                "akinsho/bufferline.nvim",
                requires = {"kyazdani42/nvim-web-devicons"},
                config = "require('plugins.bufferline')"
            }

            -- Colorize hex codes
            use {"norcalli/nvim-colorizer.lua", config = "require('plugins.colorizer')"}

            -- Autopairs
            use {
                "windwp/nvim-autopairs",
                after = {"nvim-treesitter", "nvim-cmp"},
                config = "require('plugins.autopairs')"
            }

            -- General
            use {"tpope/vim-surround"}
            use {"tpope/vim-repeat"}
            use "tpope/vim-sleuth"
            use {"ecosse3/galaxyline.nvim", after = "nvim-gps", config = "require('plugins.galaxyline')"}

            -- Language support
            use "tikhomirov/vim-glsl"
            use "tomlion/vim-solidity"

            if packer_bootstrap then
                require("packer").sync()
            end
        end
    }
)
