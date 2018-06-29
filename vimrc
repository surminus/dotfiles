set nocompatible              " be iMproved, required
filetype off                  " required

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'Shougo/neocomplete'
Plugin 'VundleVim/Vundle.vim'
Plugin 'altercation/vim-colors-solarized'
Plugin 'fatih/vim-go'
Plugin 'godlygeek/tabular'
Plugin 'hashivim/vim-terraform'
Plugin 'jiangmiao/auto-pairs'
Plugin 'kien/ctrlp.vim'
Plugin 'rodjek/vim-puppet'
Plugin 'tpope/vim-endwise'
Plugin 'tpope/vim-surround'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on

autocmd FileType text,markdown let b:vcm_tab_complete = 'dict'

autocmd Filetype go set autoindent noexpandtab tabstop=4 shiftwidth=4

" neocomplete
let g:neocomplete#enable_at_startup = 1

syntax on
set background=dark
colorscheme solarized
let g:solarized_termtrans = 1

set number
set nocp
set ruler
set cursorline
set hlsearch
set incsearch

syntax on

set shiftwidth=2
set shiftround
set autoindent
set tabstop=8
set expandtab
set colorcolumn=80
set modeline
set modelines=5

set backspace=indent,eol,start

autocmd filetype crontab setlocal nobackup nowritebackup

map <C-p> :set paste<CR>
map <C-n> :set nonumber!<CR>

set foldmethod=manual
inoremap <C-f> <C-O>za
nnoremap <C-f> za
onoremap <C-f> <C-C>za
vnoremap <C-f> zf

highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/
