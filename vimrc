set number
set nocp
syntax on
filetype plugin indent on

"
"
set background=dark
" colorscheme darkelf
" use indents of 2 spaces, and have them copied down lines:
set shiftwidth=2
set shiftround
set autoindent
set tabstop=8
set hlsearch
set expandtab
" set colorcolumn=80
set modeline
set modelines=5

execute pathogen#infect()

" Open NERDTree with CTRL+n
map <C-t> :NERDTreeToggle<CR>

autocmd filetype crontab setlocal nobackup nowritebackup

map <C-p> :set paste<CR>
map <C-n> :set nonumber!<CR>
