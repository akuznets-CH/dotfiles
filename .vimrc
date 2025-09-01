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
nnoremap <leader>h <C-w>h
nnoremap <leader>j <C-w>j
nnoremap <leader>k <C-w>k
nnoremap <leader>l <C-w>l

" Autocommands
" Sync clipboard with system
au VimEnter * set clipboard=unnamedplus

" Packages
" Disable search highlighting automatically
packadd! nohlsearch
