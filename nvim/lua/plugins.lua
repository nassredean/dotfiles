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
            requires = {{"nvim-lua/plenary.nvim"}}
        }

        -- Git
        use "tpope/vim-fugitive"

        -- Terminal in git
        use "kassio/neoterm"

        -- Better formatting
        use "sbdchd/neoformat"

        -- Dashboard
        use "glepnir/dashboard-nvim"

        -- File explorer
        use {
            "kyazdani42/nvim-tree.lua",
            -- optional icons
            requires = {"kyazdani42/nvim-web-devicons", opt = true}
        }

        -- Indentation guides
        use "lukas-reineke/indent-blankline.nvim"

        -- Scroll
        use {
            "karb94/neoscroll.nvim",
            config = function()
                require("neoscroll.config").set_mappings(
                    {
                        ["<C-u>"] = {"scroll", {"-vim.wo.scroll", "true", "250"}},
                        ["<C-d>"] = {"scroll", {"vim.wo.scroll", "true", "250"}},
                        ["<C-b>"] = {"scroll", {"-vim.api.nvim_win_get_height(0)", "true", "450"}},
                        ["<C-f>"] = {"scroll", {"vim.api.nvim_win_get_height(0)", "true", "450"}},
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

        -- Dark powered asynchronous completion
        use "Shougo/ddc.vim"
        use "vim-denops/denops.vim"
        -- Deno is required for denops. It is installed as follows:
        -- curl -fsSL https://deno.land/x/install/install.sh | sh
        -- Install your ddc sources
        use "Shougo/ddc-around"
        -- Install your ddc filters
        use "Shougo/ddc-matcher_head"
        use "Shougo/ddc-sorter_rank"

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
                        ui = {
                            bottom = {
                                laststatus = 0,
                                ruler = false,
                                showmode = false,
                                showcmd = false,
                                cmdheight = 1
                            },
                            top = {
                                showtabline = 0
                            },
                            left = {
                                number = false,
                                relativenumber = false,
                                signcolumn = "no"
                            }
                        },
                        modes = {
                            ataraxis = {
                                left_padding = 100,
                                right_padding = 100,
                                top_padding = 1,
                                bottom_padding = 1,
                                ideal_writing_area_width = {0},
                                auto_padding = true,
                                keep_default_fold_fillchars = true,
                                custom_bg = {"none", ""},
                                bg_configuration = true,
                                quit = "untoggle",
                                ignore_floating_windows = true,
                                affected_higroups = {
                                    NonText = true,
                                    FoldColumn = true,
                                    ColorColumn = true,
                                    VertSplit = true,
                                    StatusLine = true,
                                    StatusLineNC = true,
                                    SignColumn = true
                                }
                            },
                            focus = {
                                margin_of_error = 5,
                                focus_method = "experimental"
                            }
                        },
                        integrations = {
                            vim_gitgutter = false,
                            galaxyline = true,
                            tmux = false,
                            gitsigns = false,
                            nvim_bufferline = true,
                            limelight = false,
                            twilight = false,
                            vim_airline = false,
                            vim_powerline = false,
                            vim_signify = false,
                            express_line = false,
                            lualine = false,
                            lightline = false,
                            feline = false
                        },
                        misc = {
                            on_off_commands = false,
                            ui_elements_commands = false,
                            cursor_by_mode = false
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
            "neovim/nvim-lspconfig",
            requires = {{"kabouzeid/nvim-lspinstall", opt = true}, {"onsails/lspkind-nvim", opt = true}}
        }
        use {
            "kabouzeid/nvim-lspinstall",
            config = function()
                -- Integrate lspconfig with lspinstall
                local function setup_servers()
                    require "lspinstall".setup()
                    local servers = require "lspinstall".installed_servers()
                    for _, server in pairs(servers) do
                        require "lspconfig"[server].setup {}
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

        -- LSP completion pictograms
        use {
            "onsails/lspkind-nvim",
            config = function()
                require("lspkind").init(
                    {
                        -- enables text annotations
                        --
                        -- default: true
                        with_text = true,
                        -- default symbol map
                        -- can be either 'default' (requires nerd-fonts font) or
                        -- 'codicons' for codicon preset (requires vscode-codicons font)
                        --
                        -- default: 'default'
                        preset = "codicons",
                        -- override preset symbols
                        --
                        -- default: {}
                        symbol_map = {
                            Text = "",
                            Method = "",
                            Function = "",
                            Constructor = "",
                            Field = "ﰠ",
                            Variable = "",
                            Class = "ﴯ",
                            Interface = "",
                            Module = "",
                            Property = "ﰠ",
                            Unit = "塞",
                            Value = "",
                            Enum = "",
                            Keyword = "",
                            Snippet = "",
                            Color = "",
                            File = "",
                            Reference = "",
                            Folder = "",
                            EnumMember = "",
                            Constant = "",
                            Struct = "פּ",
                            Event = "",
                            Operator = "",
                            TypeParameter = ""
                        }
                    }
                )
            end
        }

        -- Language support
        use "yuezk/vim-js"
        use "maxmellon/vim-jsx-pretty"
        use "leafgarland/typescript-vim"
        use "tikhomirov/vim-glsl"
        use "elzr/vim-json"
        use "tomlion/vim-solidity"
        use {"fatih/vim-go", run = ":GoUpdateBinaries"}
    end
)
