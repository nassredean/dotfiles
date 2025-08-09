local options = {
  clipboard      = "unnamed,unnamedplus",   --- Copy-paste between vim and everything else
  completeopt    = "menu,menuone,noselect", --- Better autocompletion
  cursorline     = true,                    --- Highlight of current line
  emoji          = false,                   --- Fix emoji display
  foldlevelstart = 99,                      --- Expand all folds by default
  laststatus     = 3,                       --- Have a global statusline at the bottom instead of one for each window
  lazyredraw     = true,                    --- Makes macros faster & prevent errors in complicated mappings
  mouse          = "a",                     --- Enable mouse
  number         = true,                    --- Shows current line number
  pumheight      = 10,                      --- Max num of items in completion menu
  relativenumber = true,                    --- Enables relative number
  scrolloff      = 8,                       --- Always keep space when scrolling to bottom/top edge
  showtabline    = 2,                       --- Always show tabs
  ignorecase     = true,                    --- Needed for smartcase
  smartcase      = true,                    --- Uses case in search
  splitright     = true,                    --- Vertical splits will automatically be to the right
  expandtab      = true,                    --- Use spaces instead of tabs
  -- smartindent    = true,                    --- Provides simple automatic indentation, primarily for code-like files. 
  -- smarttab       = true,                    --- Smarter alignment when writing code: tabs respect indentation rules when at the start of the line. On by default.
  -- autoindent     = true,                    --- Copies the indent from the previous line when you press Enter. On by default
  -- softtabstop    = 2,                       --- Controls how many spaces a Tab key press inserts in Insert mode
  -- tabstop        = 2,                       --- Controls how many spaces a literal tab character (\t) displays as
  -- shiftwidth     = 2,                       --- Controls how many spaces are inserted when indenting
  timeoutlen     = 300,                     --- How long (in milliseconds) Neovim waits after a key sequence for the next key to complete a mapped sequence. 
  updatetime     = 100,                     --- How long (in milliseconds) Neovim waits after you stop typing or moving cursor before triggering CursorHold event
  undofile       = true,                    --- Sets undo to file
  wrap           = false,                   --- Display long lines as just one line
  swapfile       = false,                   --- Swap not needed
  writebackup    = false,                   --- Not needed
}

vim.opt.shortmess:append('c');
vim.opt.formatoptions:remove('c');
vim.opt.formatoptions:remove('r');
vim.opt.formatoptions:remove('o');

local globals = {
  mapleader = ',',
}

for k, v in pairs(options) do
  vim.opt[k] = v
end

for k, v in pairs(globals) do
  vim.g[k] = v
end
