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

" Godot config
let g:godot_executable = '/Applications/Godot.app'

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
nnoremap <silent><leader>x :Tnew<CR>
nnoremap <silent><leader>f :TZFocus<CR>
nnoremap <silent><leader>o :Neoformat<CR>
nnoremap <silent><leader>v :vsp<CR>
nnoremap <silent><leader>x :sp<CR>
nnoremap <silent><leader>el :BufferLineCloseLeft<cr>
nnoremap <silent><leader>er :BufferLineCloseRight<cr>
nnoremap <Space> :

" BufferLine mappings
nnoremap <S-TAB> :BufferLineCyclePrev<CR>
nnoremap <TAB> :BufferLineCycleNext<CR>
nnoremap <silent><leader>1 <Cmd>BufferLineGoToBuffer 1<CR>
nnoremap <silent><leader>2 <Cmd>BufferLineGoToBuffer 2<CR>
nnoremap <silent><leader>3 <Cmd>BufferLineGoToBuffer 3<CR>
nnoremap <silent><leader>4 <Cmd>BufferLineGoToBuffer 4<CR>
nnoremap <silent><leader>5 <Cmd>BufferLineGoToBuffer 5<CR>
nnoremap <silent><leader>6 <Cmd>BufferLineGoToBuffer 6<CR>
nnoremap <silent><leader>7 <Cmd>BufferLineGoToBuffer 7<CR>
nnoremap <silent><leader>8 <Cmd>BufferLineGoToBuffer 8<CR>
nnoremap <silent><leader>9 <Cmd>BufferLineGoToBuffer 9<CR>

" Telescope mappings
nnoremap <leader>t <cmd> lua require('telescope.builtin').find_files()<CR>
nnoremap <leader>a <cmd>lua require('telescope.builtin').live_grep()<CR>
nnoremap <leader>b <cmd>lua require('telescope.builtin').buffers()<CR>
" nnoremap <leader>fh <cmd>lua require('telescope.builtin').help_tags()<CR>

" NvimTree mappings
nnoremap <silent><C-n> :NvimTreeToggle<CR>
nnoremap <silent><leader>r :NvimTreeRefresh<CR>
nnoremap <silent><leader>n :NvimTreeFindFile<CR>

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
set expandtab
set shiftwidth=2
set tabstop=2
set softtabstop=2
set termguicolors
set whichwrap+=<,>,h,l
set wildignore+=*.swp,*.bak,*.pyc,*.class,*.jar,*.gif,*.png,*.jpg,*.o,*.obj,*.otf,*.eot,*.ttf,*.woff,*.svg,tmp,node_modules,.DS_Store,.cache,.git
set wildmenu
set wrap
set completeopt=menu,menuone,noselect

syntax enable
