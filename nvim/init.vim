lua require('plugins')

" Use full 24-bit colors as defined by your vim theme
set termguicolors
" Set vim theme
colorscheme space-nvim
filetype plugin on
" filetype indent on

" Map leader to comma
let g:mapleader = ","
let mapleader = ","

" Map control keys for window navigation
map <C-h> <C-W>h
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-l> <C-W>l

" Navigate according to displayed lines
map j gj
map k gk

nnoremap <leader>cp :let @*=expand("%")<CR>
nnoremap <silent><leader>g :Git blame<CR>
nnoremap <silent><leader>f :TZFocus<CR>
nnoremap <silent><leader>o :Neoformat<CR>
nnoremap <silent><leader>v :vsp<CR>
nnoremap <silent><leader>x :sp<CR>
nnoremap <Space> :

" BufferLine mappings
nnoremap <S-TAB> :BufferLineCyclePrev<CR>
nnoremap <TAB> :BufferLineCycleNext<CR>

" Telescope mappings
" nnoremap <leader>t <cmd> lua require('telescope.builtin').find_files()<CR>
" nnoremap <leader>a <cmd>lua require('telescope.builtin').live_grep()<CR>
nnoremap <leader>b <cmd>lua require('telescope.builtin').buffers()<CR>
" nnoremap <leader>fh <cmd>lua require('telescope.builtin').help_tags()<CR>

" NvimTree mappings
nnoremap <silent><C-n> :NvimTreeToggle<CR>
nnoremap <silent><leader>r :NvimTreeRefresh<CR>
nnoremap <silent><leader>n :NvimTreeFindFile<CR>

" Dasbhoard mappings
nnoremap <leader>ss :<C-u>SessionSave<CR>
nnoremap <leader>sl :<C-u>SessionLoad<CR>
nnoremap <silent> <leader>fh :DashboardFindHistory<CR>
nnoremap <silent> <leader>t :DashboardFindFile<CR>
nnoremap <silent> <leader>a :DashboardFindWord<CR>
" nnoremap <silent> <leader>fb :DashboardJumpMark<CR>
nnoremap <silent> <leader>cn :DashboardNewFile<CR>

set ai
set backspace=eol,start,indent
set clipboard+=unnamedplus
set colorcolumn=121
set encoding=utf8
set ffs=unix,dos,mac
set incsearch
set history=2000
set hlsearch
set ignorecase
set incsearch
set laststatus=2
set lazyredraw
set mat=2
set mouse=a
set nobackup
set noerrorbells visualbell t_vb=
set noswapfile
set nowb
set number
set shiftwidth=2
set showmatch
set si
set smartcase
set t_Co=256
set shiftwidth=2
set tabstop=2
set termguicolors
set whichwrap+=<,>,h,l
set wildignore+=*.swp,*.bak,*.pyc,*.class,*.jar,*.gif,*.png,*.jpg,*.o,*.obj,*.otf,*.eot,*.ttf,*.woff,*.svg,tmp,node_modules,.DS_Store,.cache,.git
set wildmenu
set wrap
set completeopt=menu,menuone,noselect
set switchbuf=uselast
set hidden

syntax enable

augroup vimSessions
  autocmd!
  au VimLeave * SessionSave
augroup END

augroup quickfix
  autocmd!
  au FileType qf wincmd J
augroup END

lua require('neoscroll').setup()
