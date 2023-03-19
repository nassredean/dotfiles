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
            use {
                "neovim/nvim-lspconfig",
                after = "cmp-nvim-lsp",
                requires = "hrsh7th/cmp-nvim-lsp",
                config = "require('plugins.lspconfig')"
            }

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
                "jose-elias-alvarez/typescript.nvim",
                after = "nvim-treesitter"
            }
            use {
                "lvimuser/lsp-inlayhints.nvim",
                config = function()
                    require("lsp-inlayhints").setup()
                end
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
            use {"ecosse3/galaxyline.nvim", config = "require('plugins.galaxyline')"}

            -- Language support
            use "tikhomirov/vim-glsl"
            use "tomlion/vim-solidity"

            if packer_bootstrap then
                require("packer").sync()
            end
        end
    }
)
