set nocompatible              " be iMproved, required
filetype off                  " required

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
Plugin 'rodjek/vim-puppet'
Plugin 'Valloric/YouCompleteMe'
Plugin 'altercation/vim-colors-solarized'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on

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

autocmd filetype crontab setlocal nobackup nowritebackup

map <C-p> :set paste<CR>
map <C-n> :set nonumber!<CR>

highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/
