set nocompatible              " be iMproved, required
filetype off                  " required

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
Plugin 'Shougo/neocomplete'
Plugin 'altercation/vim-colors-solarized'
Plugin 'fatih/vim-go'
Plugin 'godlygeek/tabular'
Plugin 'hashivim/vim-terraform'
Plugin 'jiangmiao/auto-pairs'
Plugin 'kien/ctrlp.vim'
Plugin 'rodjek/vim-puppet'
Plugin 'tpope/vim-endwise'
Plugin 'tpope/vim-surround'
Plugin 'w0rp/ale'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on

autocmd FileType text,markdown let b:vcm_tab_complete = 'dict'

autocmd Filetype go set autoindent noexpandtab tabstop=4 shiftwidth=4

" neocomplete
let g:neocomplete#enable_at_startup = 1

" airline
let g:airline_theme='atomic'

if filereadable("~/.vim/bundle/vim-colors-solarized")
  syntax on
  set background=dark
  colorscheme solarized
  let g:solarized_termtrans = 1
endif

" ALE
let g:ale_fixers = {
\   '*': ['remove_trailing_lines', 'trim_whitespace'],
\   'ruby': ['rubocop'],
\   'bash': ['shfmt'],
\   'markdown': ['mdl']
\}

" Uncomment these lines to only lint on save
" let g:ale_lint_on_text_changed = 'never'
" let g:ale_lint_on_enter = 0
"
"" fix with CTRL+f
map <C-f> :ALEFix<CR>
" ALE with airline
let g:airline#extensions#ale#enabled = 1

highlight clear ALEErrorSign
highlight clear ALEWarningSign
let g:ale_change_sign_column_color = 1

" swapfiles
if filereadable("~/.vim/swapfiles")
  set directory=~/.vim/swapfiles
endif

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

" splitting
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

set splitbelow
set splitright

" CTRL+w P to disable paste
map <C-w>P :set paste<CR>
" CTRL+n to remove line numbers
map <C-n> :set nonumber!<CR>

" CTRL+w S to disable syntastic
nnoremap <C-w>S :SyntasticCheck<CR>

highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/
