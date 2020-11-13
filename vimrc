"dein Scripts-----------------------------
if &compatible
  set nocompatible               " Be iMproved
endif

" Required:
set runtimepath+=/home/laura/.cache/dein/repos/github.com/Shougo/dein.vim

" Required:
if dein#load_state('/home/laura/.cache/dein')
  call dein#begin('/home/laura/.cache/dein')

  " Let dein manage dein
  " Required:
  call dein#add('/home/laura/.cache/dein/repos/github.com/Shougo/dein.vim')

  """ Completion
  " call dein#add('Shougo/neocomplete')
  call dein#add('Shougo/deoplete.nvim')
  call dein#add('roxma/nvim-yarp')
  call dein#add('roxma/vim-hug-neovim-rpc')

  " Linting
  " call dein#add('dense-analysis/ale')
  " https://github.com/dense-analysis/ale/issues/3373#issuecomment-701967881
  call dein#add('surminus/ale')

  " Theme
  call dein#add('altercation/vim-colors-solarized')
  call dein#add('luochen1990/rainbow')
  call dein#add('vim-airline/vim-airline')
  call dein#add('vim-airline/vim-airline-themes')

  " Git
  call dein#add('tpope/vim-fugitive')

  " Files & search
  call dein#add('junegunn/fzf', { 'build': './install', 'merged': 0 })
  call dein#add('junegunn/fzf.vim')
  call dein#add('scrooloose/nerdtree')

  " Syntax
  call dein#add('chr4/nginx.vim')
  call dein#add('rodjek/vim-puppet')
  call dein#add('ekalinin/Dockerfile.vim')
  call dein#add('hashivim/vim-terraform')
  call dein#add('fatih/vim-go')

  " Editor config
  call dein#add('editorconfig/editorconfig-vim')

  " Tools
  call dein#add('godlygeek/tabular')
  call dein#add('tpope/vim-endwise')
  call dein#add('tpope/vim-surround')
  " https://github.com/jiangmiao/auto-pairs/issues/74#issuecomment-54138837
  call dein#add('amcsi/auto-pairs')

  " Add or remove your plugins here like this:
  "call dein#add('Shougo/neosnippet.vim')
  "call dein#add('Shougo/neosnippet-snippets')

  " Required:
  call dein#end()
  call dein#save_state()
endif

" Required:
filetype plugin indent on
syntax enable

" If you want to install not installed plugins on startup.
if dein#check_install()
  call dein#install()
endif
"End dein Scripts-------------------------

" nerdtree
map <C-x> :NERDTreeToggle<CR>

" deoplete: can't seem to get it working nicely with vim-go, so sticking
" with neocomplete for the time-being
" EDIT: seems to be working?
let g:deoplete#enable_at_startup = 1
let g:deoplete#complete_method = "omnifunc"

call deoplete#custom#option('omni_patterns', {
\ 'go': '[^. *\t]\.\w*',
\})

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
let g:go_gopls_enabled = 1

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
map <C-s> :Rg<CR>

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
