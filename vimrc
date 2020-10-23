set nocompatible              " be iMproved, required
filetype off                  " required

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" Do not set this when another completion plugin is enabled
" let g:ale_completion_enabled = 1

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

""" Completion
" Plugin 'Shougo/neocomplete'
Plugin 'Shougo/deoplete.nvim'
Plugin 'roxma/nvim-yarp'
Plugin 'roxma/vim-hug-neovim-rpc'

" Linting
Plugin 'dense-analysis/ale'
Plugin 'fatih/vim-go'

" Theme
Plugin 'altercation/vim-colors-solarized'
Plugin 'luochen1990/rainbow'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'

" Git
Plugin 'tpope/vim-fugitive'

" Files & search
Plugin 'junegunn/fzf'
Plugin 'junegunn/fzf.vim'
Plugin 'scrooloose/nerdtree'

" Syntax
Plugin 'sheerun/vim-polyglot'
Plugin 'chr4/nginx.vim'
Plugin 'rodjek/vim-puppet'
Plugin 'ekalinin/Dockerfile.vim'
Plugin 'hashivim/vim-terraform'

" Editor config
Plugin 'editorconfig/editorconfig-vim'

" Tools
Plugin 'godlygeek/tabular'
Plugin 'tpope/vim-endwise'
Plugin 'tpope/vim-surround'
" https://github.com/jiangmiao/auto-pairs/issues/74#issuecomment-54138837
Plugin 'amcsi/auto-pairs'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on

" nerdtree
map <C-x> :NERDTreeToggle<CR>

" deoplete: can't seem to get it working nicely with vim-go, so sticking
" with neocomplete for the time-being
" EDIT: seems to be working?
let g:deoplete#enable_at_startup = 1

" neocomplete
" let g:neocomplete#enable_at_startup = 1

" Use ALE and also some plugin 'foobar' as completion sources for all code.
" call deoplete#custom#option('sources', {
" \ '_': ['ale'],
" \})

autocmd FileType text,markdown let b:vcm_tab_complete = 'dict'

autocmd Filetype go set autoindent noexpandtab tabstop=4 shiftwidth=4

" vim-go
let g:go_highlight_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_function_calls = 1
let g:go_highlight_operators = 1
let g:go_code_completion_enabled = 1

" " javascript
" " let g:javascript_plugin_jsdoc = 1
"
" shared clipboard
set clipboard=unnamed

" " rainbow
let g:rainbow_active = 0 "0 if you want to enable it later via :RainbowToggle

" airline
let g:airline_theme='atomic'

" https://github.com/vim/vim/issues/6112
set t_TI= t_TE=

" colorized
set background=dark
syntax on
colorscheme solarized
let g:solarized_termtrans = 1

" ALE
let g:ale_fixers = {
\   '*': ['remove_trailing_lines', 'trim_whitespace'],
\   'ruby': ['rubocop'],
\   'bash': ['shfmt'],
\   'markdown': ['mdl'],
\   'go': ['gofmt', 'goimports']
\}

" In ~/.vim/vimrc, or somewhere similar.
let g:ale_linters = {
\   'go': ['gobuild', 'gofmt', 'golint', 'gosimple', 'govet'],
\}

" Uncomment these lines to only lint on save
" let g:ale_lint_on_text_changed = 'normal'
" let g:ale_lint_on_enter = 0

""" fix with CTRL+f (never use it)
" map <C-f> :ALEFix<CR>
" Next error
map <C-e> :ALENext<CR>
" ALE with airline
let g:airline#extensions#ale#enabled = 1

" fuzzy finder!
map <C-f> :Files<CR>

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
" nnoremap <C-w>S :SyntasticCheck<CR>

highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/
