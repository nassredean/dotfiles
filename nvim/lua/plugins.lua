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

            use {"nathom/filetype.nvim"}
            use {"kyazdani42/nvim-web-devicons"}

            -- LSP
            use {
                "neovim/nvim-lspconfig",
                config = "require('plugins.lspconfig')"
            }

            -- Language Specific
            use { "https://github.com/ziglang/zig.vim" }

            -- Telescope
            use {
                "nvim-telescope/telescope.nvim",
                requires = {
                    {"nvim-lua/popup.nvim"},
                    {"nvim-lua/plenary.nvim"}
                },
                config = "require('plugins.telescope')"
            }

            -- Colorscheme
            use {"folke/tokyonight.nvim"}

            -- UI
            use {
                "stevearc/dressing.nvim",
                requires = "MunifTanjim/nui.nvim",
                config = "require('plugins.dressing')"
            }
            use {"nvim-lua/popup.nvim"}
            use {"rcarriga/nvim-notify"}

            -- Nvim Tree
            use {"kyazdani42/nvim-tree.lua", config = "require('plugins.tree')"}

            -- Git
            use "tpope/vim-fugitive"

            -- Indentation guides
            use {"lukas-reineke/indent-blankline.nvim", config = "require('plugins.indent')"}

            -- Better bufferline
            use {
                "akinsho/bufferline.nvim",
                requires = {"kyazdani42/nvim-web-devicons"},
                config = "require('plugins.bufferline')"
            }

            -- Status line
            use {"ecosse3/galaxyline.nvim", config = "require('plugins.galaxyline')"}

            -- Bootstrap packer if needed
            if packer_bootstrap then
                require("packer").sync()
            end
        end
    }
)
