" packer must be installed with:
"git clone https://github.com/wbthomason/packer.nvim\
" ~/.local/share/nvim/site/pack/packer/start/packer.nvim
lua require('plugins')

" Customize ddc global settings
" Use around source.
" https://github.com/Shougo/ddc-around
call ddc#custom#patch_global('sources', ['around'])

" Use matcher_head and sorter_rank.
" https://github.com/Shougo/ddc-matcher_head
" https://github.com/Shougo/ddc-sorter_rank
call ddc#custom#patch_global('sourceOptions', {
      \ '_': {
      \   'matchers': ['matcher_head'],
      \   'sorters': ['sorter_rank']},
      \ })

" Change source options
call ddc#custom#patch_global('sourceOptions', {
      \ 'around': {'mark': 'A'},
      \ })
call ddc#custom#patch_global('sourceParams', {
      \ 'around': {'maxSize': 500},
      \ })

" <TAB>: completion.
inoremap <silent><expr> <TAB>
\ pumvisible() ? '<C-n>' :
\ (col('.') <= 1 <Bar><Bar> getline('.')[col('.') - 2] =~# '\s') ?
\ '<TAB>' : ddc#manual_complete()

" <S-TAB>: completion back.
inoremap <expr><S-TAB>  pumvisible() ? '<C-p>' : '<C-h>'

" enable ddc completion
call ddc#enable()

" Dashboard configuration
let g:dashboard_default_executive ='telescope'

" Use full 24-bit colors as defined by your vim theme
set termguicolors
" Set vim theme
colorscheme space-nvim

" Return to last edit position when opening files
autocmd BufReadPost *
     \ if line("'\"") > 0 && line("'\"") <= line("$") |
     \   exe "normal! g`\"" |
     \ endif

filetype plugin on
filetype indent on

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

map <ScrollWheelDown> <C-E>
map <ScrollWheelUp> <C-Y>

nnoremap <leader>cp :let @*=expand("%")<CR>
nnoremap <silent><leader>g :Git blame<cr>
nnoremap <silent><leader>x :Tnew<cr>
nnoremap <silent><leader>f :TZMinimalist<cr>
nnoremap <silent><leader>o :Neoformat<cr>
" nnoremap <leader>v :<C-V>
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
" Close all buffers except this one with leader bo
map <leader>bo :%bd\|e#<cr>
map <leader>bd :bd<cr>

" Telescope mappings
nnoremap <leader>t <cmd> lua require('telescope.builtin').find_files()<cr>
nnoremap <leader>a <cmd>lua require('telescope.builtin').live_grep()<cr>
nnoremap <leader>b <cmd>lua require('telescope.builtin').buffers()<cr>
" nnoremap <leader>fh <cmd>lua require('telescope.builtin').help_tags()<cr>

" NvimTree mappings
nnoremap <silent><C-n> :NvimTreeToggle<CR>
nnoremap <silent><leader>r :NvimTreeRefresh<CR>
nnoremap <silent><leader>n :NvimTreeFindFile<CR>

" Leader vimrc opens init.vim
map <leader>vimrc :tabe ~/.config/nvim/init.vim<cr>

" When init.vim is saved, source it
autocmd bufwritepost init.vim source $MYVIMRC

set ai
set backspace=eol,start,indent
set clipboard+=unnamedplus
set colorcolumn=121
set encoding=utf8
set expandtab
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
set smarttab
set t_Co=256
set tabstop=2
set termguicolors
set viminfo^=%
set whichwrap+=<,>,h,l
set wildignore+=*.swp,*.bak,*.pyc,*.class,*.jar,*.gif,*.png,*.jpg
set wildignore=*.o,*.obj,*.otf,*.eot,*.ttf,*.woff,*.svg,tmp,node_modules
set wildmenu
set wrap

syntax enable
