-- This file can be loaded by calling `lua require('plugins')` from your init.vim
-- Bootstrap packer
local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  fn.system({'git', 'clone', 'https://github.com/wbthomason/packer.nvim', install_path})
  vim.cmd 'packadd packer.nvim'
end

vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerCompile
  augroup end
]])

return require('packer').startup(function()
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  use {
    'nvim-telescope/telescope.nvim',
    requires = { {'nvim-lua/plenary.nvim'} }
  }

  -- Git
  use 'tpope/vim-fugitive'
  
  -- Distraction free writing
  use 'junegunn/goyo.vim'

  -- Terminal in git
  use 'kassio/neoterm'

  -- File explorer
  use {
    'kyazdani42/nvim-tree.lua',
    -- optional icons
    requires = {'kyazdani42/nvim-web-devicons', opt = true}
  }

  -- Indentation guides
  use "lukas-reineke/indent-blankline.nvim"

  -- Scroll
  use {
    'karb94/neoscroll.nvim',
    config = function() require('neoscroll').setup() end
  }

  -- Dark powered asynchronous completion
  use 'Shougo/ddc.vim'
  use 'vim-denops/denops.vim'
  -- Deno is required for denops. It is installed as follows:
  -- curl -fsSL https://deno.land/x/install/install.sh | sh
  -- Install your ddc sources
  use 'Shougo/ddc-around'
  -- Install your ddc filters
  use 'Shougo/ddc-matcher_head'
  use 'Shougo/ddc-sorter_rank'


  -- Statusline
  use {
  'glepnir/galaxyline.nvim',
    branch = 'main',
    -- your statusline
    config = function() require'statusline' end,
    -- optional icons
    requires = {'kyazdani42/nvim-web-devicons', opt = true}
  }

  -- Better bufferline
  use {'akinsho/bufferline.nvim', requires = 'kyazdani42/nvim-web-devicons'}

  -- Color scheme plugins
  use 'nassredean/space-nvim'

  -- Colorize hex codes
  use { 
    'norcalli/nvim-colorizer.lua',
    config = function() require('colorizer').setup() end
  }

  -- Language support
  use 'yuezk/vim-js'
  use 'maxmellon/vim-jsx-pretty'
  use 'leafgarland/typescript-vim'
  use 'tikhomirov/vim-glsl'
  use 'elzr/vim-json'
  use 'tomlion/vim-solidity'
  use { 'fatih/vim-go', run = ':GoUpdateBinaries' }
end)
