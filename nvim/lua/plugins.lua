local lazy_plugins_path = (vim.fn.stdpath('data') .. '/lazy')
local lazy_path = (lazy_plugins_path .. '/lazy.nvim')

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

	-- Telescope
	{
		'nvim-telescope/telescope.nvim',
		dependencies = {
			{ 'nvim-lua/plenary.nvim' },
		},
		config = function()
			require('plugins.telescope')
		end,
	},

	-- Colorscheme
	{
		'folke/tokyonight.nvim',
		config = function()
			vim.cmd([[colorscheme tokyonight]])
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
		config = function()
			require('plugins.bufferline')
		end,
	},

	-- Status line
	{
		'ecosse3/galaxyline.nvim',
		config = function()
			require('plugins.galaxyline')
		end,
	},
}

require('lazy').setup(plugins, { ui = { border = 'rounded' } })
