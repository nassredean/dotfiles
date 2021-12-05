-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Bootstrap packer if it does not exist
local fn = vim.fn
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({"git", "clone", "https://github.com/wbthomason/packer.nvim", install_path})
    vim.cmd "packadd packer.nvim"
end

-- Run PackerCopmile on save of plugins.lua
vim.cmd(
    [[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerCompile
  augroup end
]]
)

return require("packer").startup(
    function()
        -- Packer can manage itself
        use "wbthomason/packer.nvim"

        -- File explorer
        use {
            "nvim-telescope/telescope.nvim",
            requires = {{"nvim-lua/plenary.nvim"}},
            config = function()
                local actions = require "telescope.actions"

                require("telescope").setup(
                    {
                        defaults = {
                            -- path_display = {"smart"},
                            file_ignore_patterns = {
                                "node_modules",
                                "mocks/",
                                "tmp",
                                ".cache",
                                ".git",
                                ".DS_Store",
                                "package-lock.json",
                                "^.+%.swp",
                                "^.+%.bak",
                                "^.+%.pyc",
                                "^.+%.jar",
                                "^.+%.o$",
                                "^.+%.obj",
                                "^.+%.otf",
                                "^.+%.eot",
                                "^.+%.ttf$",
                                "^.+%.woff"
                            }
                        },
                        pickers = {
                            buffers = {
                                mappings = {
                                    i = {
                                        ["<c-q>"] = actions.delete_buffer + actions.move_to_top
                                    }
                                }
                            }
                        }
                    }
                )
            end
        }

        -- Git
        use "tpope/vim-fugitive"

        -- Terminal in git
        use "kassio/neoterm"

        -- Better formatting
        use "sbdchd/neoformat"

        -- Indentation guides
        use "lukas-reineke/indent-blankline.nvim"

        -- Dashboard
        use {
            "glepnir/dashboard-nvim",
            config = function()
                vim.g.indentLine_fileTypeExclude = {"dashboard"}
                vim.g.dashboard_custom_header = {
                    "            ",
                    "    ╓╓╓╓    ",
                    "   ┌╨╨╨╨┐   ",
                    "   │    ├┐  ",
                    "   │$ $ └│  ",
                    "   │ <  └┘  ",
                    "   │    │   ",
                    "   │┼─┼ │   ",
                    "   │    │   ",
                    "   └──┘ │   ",
                    "     │  │   ",
                    "     │  │   "
                }
                vim.g.dashboard_default_executive = "telescope"
                vim.g.dashboard_custom_footer = {
                    "λ mind is software λ"
                }
                vim.g.dashboard_custom_shortcut = {
                    last_session = "leader sl",
                    find_history = "leader fh",
                    find_file = " leader t",
                    new_file = "leader cn",
                    change_colorscheme = "          ",
                    find_word = " leader a",
                    book_marks = "          "
                }
            end
        }

        -- File explorer
        use {
            "kyazdani42/nvim-tree.lua",
            -- optional icons
            requires = {"kyazdani42/nvim-web-devicons", opt = true},
            config = function()
                require "nvim-tree".setup {
                    filters = {custom = {".git", "node_modules", ".cache", ".DS_Store"}}
                }
            end
        }

        -- Scroll
        use {
            "karb94/neoscroll.nvim",
            config = function()
                require("neoscroll.config").set_mappings(
                    {
                        ["<C-u>"] = {"scroll", {"-vim.wo.scroll", "true", "250"}},
                        ["<C-d>"] = {"scroll", {"vim.wo.scroll", "true", "250"}},
                        ["<C-y>"] = {"scroll", {"-0.10", "false", "100"}},
                        ["<C-e>"] = {"scroll", {"0.10", "false", "100"}}
                    }
                )
                require("neoscroll").setup()
            end
        }

        -- Better commenting
        use {
            "terrortylor/nvim-comment",
            config = function()
                require("nvim_comment").setup(
                    {
                        comment_empty = false,
                        create_mappings = true,
                        line_mapping = "<leader>cl",
                        operator_mapping = "<leader>c"
                    }
                )
            end
        }

        -- File explorer
        use {
            "nvim-treesitter/nvim-treesitter",
            run = ":TSUpdate",
            config = function()
                require("nvim-treesitter.configs").setup(
                    {
                        ensure_installed = {
                            "c",
                            "javascript",
                            "typescript",
                            "go",
                            "ruby",
                            "python",
                            "bash",
                            "lua",
                            "vim"
                        }, -- one of "all", "maintained" (parsers with maintainers), or a list of languages
                        ignore_install = {}, -- List of parsers to ignore installing
                        highlight = {
                            enable = true, -- false will disable the whole extension
                            -- disable = { },  -- list of language that will be disabled
                            -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
                            -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
                            -- Using this option may slow down your editor, and you may see some duplicate highlights.
                            -- Instead of true it can also be a list of languages
                            additional_vim_regex_highlighting = false
                        }
                    }
                )
            end
        }

        -- Statusline
        use {
            "glepnir/galaxyline.nvim",
            branch = "main",
            -- your statusline
            config = function()
                require "statusline"
            end,
            -- optional icons
            requires = {"kyazdani42/nvim-web-devicons", opt = true}
        }

        -- Better bufferline
        use {
            "akinsho/bufferline.nvim",
            requires = {"kyazdani42/nvim-web-devicons", opt = true},
            config = function()
                require("bufferline").setup {
                    options = {
                        diagnostics = "nvim_lsp",
                        diagnostics_indicator = function(count, level, diagnostics_dict, context)
                            local icon = level:match("error") and " " or " "
                            return " " .. icon .. count
                        end,
                        numbers = "ordinal",
                        offsets = {
                            filetype = "NvimTree",
                            text = function()
                                return vim.fn.getcwd()
                            end,
                            highlight = "Directory",
                            text_align = "left"
                        }
                    }
                }
            end
        }

        -- Focus mode
        use {
            "Pocco81/TrueZen.nvim",
            config = function()
                local true_zen = require("true-zen")

                true_zen.setup(
                    {
                        ui = {},
                        integrations = {
                            galaxyline = true,
                            nvim_bufferline = true
                        }
                    }
                )
            end
        }

        -- Color scheme plugins
        use "nassredean/space-nvim"

        -- Colorize hex codes
        use {
            "norcalli/nvim-colorizer.lua",
            config = function()
                require("colorizer").setup()
            end
        }

        -- LSP
        use {
            "neovim/nvim-lspconfig"
        }
        use {
            "kabouzeid/nvim-lspinstall",
            requires = {{"neovim/nvim-lspconfig"}, {"hrsh7th/cmp-nvim-lsp"}},
            config = function()
                -- Integrate lspconfig with lspinstall, cmp
                local function setup_servers()
                    require "lspinstall".setup()
                    local servers = require "lspinstall".installed_servers()
                    table.insert(servers, "gdscript")
                    for _, server in pairs(servers) do
                        require "lspconfig"[server].setup {
                            capabilities = require("cmp_nvim_lsp").update_capabilities(
                                vim.lsp.protocol.make_client_capabilities()
                            ),
                            debounce_text_changes = 150,
                            on_attach = function(client, bufnr)
                                local function buf_set_keymap(...)
                                    vim.api.nvim_buf_set_keymap(bufnr, ...)
                                end
                                local function buf_set_option(...)
                                    vim.api.nvim_buf_set_option(bufnr, ...)
                                end

                                -- Enable completion triggered by <c-x><c-o>
                                buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")

                                -- Mappings.
                                local opts = {noremap = true, silent = true}

                                -- See `:help vim.lsp.*` for documentation on any of the below functions
                                buf_set_keymap("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
                                buf_set_keymap("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
                                buf_set_keymap("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
                                buf_set_keymap("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
                                buf_set_keymap("n", "rn", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
                                buf_set_keymap("n", "ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
                                buf_set_keymap("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
                                buf_set_keymap(
                                    "n",
                                    "<space>e",
                                    "<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>",
                                    opts
                                )
                                buf_set_keymap("n", "gb", "<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>", opts)
                                buf_set_keymap("n", "gn", "<cmd>lua vim.lsp.diagnostic.goto_next()<CR>", opts)
                                -- buf_set_keymap("n", "<space>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
                            end
                        }
                    end
                end

                setup_servers()

                -- Automatically reload after `:LspInstall <server>` so we don't have to restart neovim
                require "lspinstall".post_install_hook = function()
                    setup_servers() -- reload installed servers
                    vim.cmd("bufdo e") -- this triggers the FileType autocmd that starts the server
                end
            end
        }

        -- LSP completion
        use {
            "hrsh7th/cmp-nvim-lsp",
            requires = {{"neovim/nvim-lspconfig"}}
        }
        use {
            "hrsh7th/cmp-buffer",
            requires = {{"neovim/nvim-lspconfig"}}
        }

        use {"L3MON4D3/LuaSnip"}
        use {
            "saadparwaiz1/cmp_luasnip",
            requires = {"neovim/nvim-lspconfig", "L3MON4D3/LuaSnip"}
        }
        use {
            "hrsh7th/nvim-cmp",
            requires = {
                {"neovim/nvim-lspconfig"},
                {"hrsh7th/cmp-buffer"},
                {"hrsh7th/cmp-nvim-lsp"},
                {"L3MON4D3/LuaSnip"}
            },
            config = function()
                local cmp = require "cmp"

                cmp.setup(
                    {
                        snippet = {
                            expand = function(args)
                                require "luasnip".lsp_expand(args.body)
                            end
                        },
                        mapping = {
                            ["<Tab>"] = cmp.mapping.select_next_item({behavior = cmp.SelectBehavior.Insert}),
                            ["<S-Tab>"] = cmp.mapping.select_prev_item({behavior = cmp.SelectBehavior.Insert}),
                            ["<C-e>"] = cmp.mapping.close(),
                            ["<C-f>"] = cmp.mapping.confirm {
                                behavior = cmp.ConfirmBehavior.Replace,
                                select = true
                            }
                        },
                        sources = {
                            {name = "luasnip"},
                            {name = "nvim_lsp"},
                            {name = "buffer"}
                        }
                    }
                )
            end
        }

        -- LSP completion pictograms
        use {
            "onsails/lspkind-nvim",
            requires = {{"neovim/nvim-lspconfig"}, {"neovim/nvim-cmp"}},
            config = function()
                local cmp = require "cmp"
                local lspkind = require("lspkind")
                cmp.setup {
                    formatting = {
                        format = lspkind.cmp_format({with_text = false, maxwidth = 50})
                    }
                }
            end
        }

        -- Autopairs
        use "windwp/nvim-autopairs"

        -- Language support
        use "fatih/vim-go"
        use "iloginow/vim-stylus"
        use "yuezk/vim-js"
        use "maxmellon/vim-jsx-pretty"
        use "leafgarland/typescript-vim"
        use "tikhomirov/vim-glsl"
        use "elzr/vim-json"
        use "tomlion/vim-solidity"
        use "habamax/vim-godot"
    end
)
