local options = {
  clipboard      = "unnamed,unnamedplus",   --- Copy-paste between vim and everything else
  cmdheight      = 2,                       --- Give more space for displaying messages
  completeopt    = "menu,menuone,noselect", --- Better autocompletion
  cursorline     = true,                    --- Highlight of current line
  emoji          = false,                   --- Fix emoji display
  expandtab      = true,                    --- Use spaces instead of tabs
  foldlevelstart = 99,                      --- Expand all folds by default
  foldtext       = "CustomFold()",          --- Emit custom function for foldtext
  ignorecase     = true,                    --- Needed for smartcase
  laststatus     = 3,                       --- Have a global statusline at the bottom instead of one for each window
  lazyredraw     = true,                    --- Makes macros faster & prevent errors in complicated mappings
  mouse          = "a",                     --- Enable mouse
  number         = true,                    --- Shows current line number
  pumheight      = 10,                      --- Max num of items in completion menu
  relativenumber = true,                    --- Enables relative number
  scrolloff      = 8,                       --- Always keep space when scrolling to bottom/top edge
  shiftwidth     = 2,                       --- Change a number of space characeters inseted for indentation
  showtabline    = 2,                       --- Always show tabs
  smartcase      = true,                    --- Uses case in search
  smartindent    = true,                    --- Makes indenting smart
  smarttab       = true,                    --- Makes tabbing smarter will realize you have 2 vs 4
  softtabstop    = 2,                       --- Insert 2 spaces for a tab
  splitright     = true,                    --- Vertical splits will automatically be to the right
  swapfile       = false,                   --- Swap not needed
  tabstop        = 2,                       --- Insert 2 spaces for a tab
  termguicolors  = true,                    --- Correct terminal colors
  timeoutlen     = 300,                     --- Faster completion
  undofile       = true,                    --- Sets undo to file
  updatetime     = 100,                     --- Faster completion
  viminfo        = "'1000",                 --- Increase the size of file history
  wrap           = false,                   --- Display long lines as just one line
  writebackup    = false,                   --- Not needed

  -- Neovim defaults
  autoindent     = true,                    --- Good auto indent
  backspace      = "indent,eol,start",      --- Making sure backspace works
  backup         = false,                   --- Recommended by coc
  conceallevel   = 0,                       --- Show `` in markdown files
  encoding       = "utf-8",                 --- The encoding displayed
  errorbells     = false,                   --- Disables sound effect for errors
  fileencoding   = "utf-8",                 --- The encoding written to file
  incsearch      = true,                    --- Start searching before pressing enter
  showmode       = false,                   --- Don't show things like -- INSERT -- anymore
  backupcopy     = "yes",
}

local globals = {
  mapleader                   = ',',        --- Map leader key to SPC
}

vim.opt.shortmess:append('c');
vim.opt.formatoptions:remove('c');
vim.opt.formatoptions:remove('r');
vim.opt.formatoptions:remove('o');

for k, v in pairs(options) do
  vim.opt[k] = v
end

for k, v in pairs(globals) do
  vim.g[k] = v
end
