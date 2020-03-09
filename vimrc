set nocompatible              " be iMproved, required
filetype off                  " required

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

let g:ale_completion_enabled = 1

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

Plugin 'Shougo/neocomplete'
Plugin 'altercation/vim-colors-solarized'
Plugin 'fatih/vim-go'
Plugin 'godlygeek/tabular'
Plugin 'hashivim/vim-terraform'
Plugin 'jiangmiao/auto-pairs'
Plugin 'kien/ctrlp.vim'
Plugin 'luochen1990/rainbow'
Plugin 'nsf/gocode', {'rtp': 'vim/'}
Plugin 'rodjek/vim-puppet'
Plugin 'scrooloose/nerdtree'
Plugin 'tpope/vim-endwise'
Plugin 'tpope/vim-surround'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'w0rp/ale'
" Plugin 'martinda/Jenkinsfile-vim-syntax'

" nerdtree
map <C-x> :NERDTreeToggle<CR>

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on

autocmd FileType text,markdown let b:vcm_tab_complete = 'dict'

autocmd Filetype go set autoindent noexpandtab tabstop=4 shiftwidth=4

" shared clipboard
set clipboard=unnamed

" rainbow
let g:rainbow_active = 0 "0 if you want to enable it later via :RainbowToggle

" neocomplete
let g:neocomplete#enable_at_startup = 1

" airline
let g:airline_theme='atomic'

syntax on
set background=dark
colorscheme solarized
let g:solarized_termtrans = 1

" ALE
let g:ale_fixers = {
\   '*': ['remove_trailing_lines', 'trim_whitespace'],
\   'ruby': ['rubocop'],
\   'bash': ['shfmt'],
\   'markdown': ['mdl']
\}

" In ~/.vim/vimrc, or somewhere similar.
let g:ale_linters = {
\   'go': ['gobuild'],
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
set directory=~/.vim/swapfiles

" vim-ruby omni https://github.com/vim-ruby/vim-ruby/wiki/VimRubySupport#omni-completion-functions
let g:rubycomplete_buffer_loading = 1
let g:rubycomplete_classes_in_global = 1
let g:rubycomplete_rails = 1

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

" delete whitespace with F5
nnoremap <silent> <F5> :let _s=@/ <Bar> :%s/\s\+$//e <Bar> :let @/=_s <Bar> :nohl <Bar> :unlet _s <CR>

" splitting
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

set splitbelow
set splitright

" CTRL+n to remove line numbers
map <C-n> :set nonumber!<CR>

" CTRL+w S to disable syntastic
nnoremap <C-w>S :SyntasticCheck<CR>

highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/
