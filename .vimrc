" Use full 24-bit colors as defined by your vim theme
set termguicolors
filetype plugin on

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

nnoremap <silent><leader>v :vsp<CR>
nnoremap <silent><leader>x :sp<CR>
nnoremap <Space> :

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
