local lazy_plugins_path = (vim.fn.stdpath('data') .. '/lazy')
local lazy_path = (lazy_plugins_path .. '/lazy.nvim')
local icons = require("icons")

if not vim.loop.fs_stat(lazy_path) then
	vim.fn.system({
		'git',
		'clone',
		'--filter=blob:none',
		'https://github.com/folke/lazy.nvim.git',
		'--branch=stable',
		lazy_path,
	})
else
end

do
end

vim.opt.rtp:prepend(lazy_path)

plugins = {
	'folke/lazy.nvim',

	'kyazdani42/nvim-web-devicons',

	-- LSP
	{
		'neovim/nvim-lspconfig',
		config = function()
			require('plugins.lspconfig')
		end,
	},

  -- Treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function ()
      local configs = require("nvim-treesitter.configs")

      configs.setup({
          ensure_installed = {
            "bash",
            "c",
            "csv",
            "dockerfile",
            "diff",
            "fish",
            "git_config",
            "git_rebase",
            "gitattributes",
            "gitignore",
            "glsl",
            "html",
            "javascript",
            "jq",
            "json",
            "lua",
            "python",
            "query",
            "regex",
            "ruby",
            "rust",
            "sql",
            "swift",
            "typescript",
            "vim",
            "vimdoc",
          },
          sync_install = false,
          highlight = { enable = true },
          indent = { enable = true },
        })
    end
 },

	-- Telescope
	{
		'nvim-telescope/telescope.nvim',
		dependencies = {
			 'nvim-lua/plenary.nvim',
		},
	},

  {
    'projekt0n/github-nvim-theme',
    name = 'github-theme',
    lazy = false, -- make sure we load this during startup if it is your main colorscheme
    priority = 1000, -- make sure to load this before all the other start plugins
    config = function()
      require('github-theme').setup({
        -- ...
      })

      vim.cmd('colorscheme github_light_default')
    end,
  },

	-- Nvim Tree
	{
		'kyazdani42/nvim-tree.lua',
		config = function()
			require('plugins.tree')
		end,
  },

	-- Git
	{ 'lewis6991/gitsigns.nvim', opts = {} },

	-- Better bufferline
  {
    'akinsho/bufferline.nvim',
    version = "*",
    dependencies = {
      'projekt0n/github-nvim-theme',
      'nvim-tree/nvim-web-devicons'
    },
    config = function()
      require('plugins.bufferline')
    end,
  },

  {
      'numToStr/Comment.nvim',
      opts = {
          -- add any options here
      }
  }
}

require('lazy').setup(plugins, { ui = { border = 'rounded' } })
