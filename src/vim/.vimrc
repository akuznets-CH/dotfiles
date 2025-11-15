" Leader keys
let mapleader = ' '
let maplocalleader = '\'

" Options
set number
set relativenumber
set ignorecase
set smartcase
set cursorline
set scrolloff=10
set list
set confirm
set tabstop=4
set shiftwidth=4
set expandtab
set softtabstop=4

" Keymappings
" Exit terminal mode with Esc
tnoremap <Esc> <C-\><C-n>
" Navigate between windows
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
vnoremap <leader>y "+y
nnoremap <leader>p "+p
vnoremap <leader>p "+p
