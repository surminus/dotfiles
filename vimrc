"dein Scripts-----------------------------
if &compatible
  set nocompatible               " Be iMproved
endif

" Required:
set runtimepath+=$HOME/.cache/dein/repos/github.com/Shougo/dein.vim

" Required:
call dein#begin("$HOME/.cache/dein")

" Let dein manage dein
" Required:
call dein#add("$HOME/.cache/dein/repos/github.com/Shougo/dein.vim")

""" Completion
call dein#add('Shougo/deoplete.nvim')
call dein#add('roxma/nvim-yarp')
call dein#add('roxma/vim-hug-neovim-rpc')
call dein#add('tbodt/deoplete-tabnine', { 'build': './install.sh' })
call dein#add('autozimu/LanguageClient-neovim', { 'build': 'bash install.sh', 'branch': 'next' })
call dein#add('Shougo/neco-syntax')

" Linting
call dein#add('dense-analysis/ale')
" https://github.com/dense-analysis/ale/issues/3373#issuecomment-701967881
" call dein#add('surminus/ale')

" Theme
call dein#add('bluz71/vim-moonfly-colors')
call dein#add('luochen1990/rainbow')
call dein#add('vim-airline/vim-airline')
call dein#add('vim-airline/vim-airline-themes')

" Git
call dein#add('tpope/vim-fugitive')

" Files & search
call dein#add('junegunn/fzf.vim')
call dein#add('scrooloose/nerdtree')

" Syntax
call dein#add('chr4/nginx.vim')
call dein#add('ekalinin/Dockerfile.vim')
call dein#add('fatih/vim-go')
call dein#add('google/vim-jsonnet')
call dein#add('hashivim/vim-terraform')
call dein#add('martinda/Jenkinsfile-vim-syntax')
call dein#add('rodjek/vim-puppet')

" Editor config
call dein#add('editorconfig/editorconfig-vim')

" Tools
call dein#add('godlygeek/tabular')
call dein#add('tpope/vim-endwise')
call dein#add('tpope/vim-surround')
" https://github.com/jiangmiao/auto-pairs/issues/74#issuecomment-54138837
call dein#add('amcsi/auto-pairs')

" Required:
call dein#end()

" Required:
filetype plugin indent on
syntax enable

" If you want to install not installed plugins on startup.
if dein#check_install()
  call dein#install()
endif

" To update plugins:
" call dein#update()

"End dein Scripts-------------------------

" nerdtree
if $TMUX
  map <C-p> :NERDTreeToggle<CR>
else
  map <C-x> :NERDTreeToggle<CR>
endif

" deoplete
let g:deoplete#enable_at_startup = 1
let g:deoplete#complete_method = "omnifunc"

call deoplete#custom#option('omni_patterns', {
\ 'go': '[^. *\t]\.\w*',
\})

" Required for operations modifying multiple buffers like rename.
set hidden

" To install configured language servers:
" gem install solargraph
" npm i -g bash-language-server
let g:LanguageClient_serverCommands = {
\ 'ruby': ['~/.rbenv/shims/solargraph', 'stdio'],
\ 'sh': ['bash-language-server', 'start'],
\ 'terraform': ['terraform-ls', 'serve'],
\ }

" vim-go
let g:go_highlight_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_function_calls = 1
let g:go_highlight_operators = 1
" This handles using gopls language server
let g:go_code_completion_enabled = 1
let g:go_gopls_enabled = 1

" Shared clipboard
set clipboard=unnamed

" Airline
let g:airline_theme='atomic'

" https://github.com/vim/vim/issues/6112
set t_TI= t_TE=

" Theme
colorscheme moonfly
set termguicolors
syntax on

" ALE
let g:ale_fixers = {
\   '*': ['remove_trailing_lines', 'trim_whitespace'],
\   'ruby': ['rubocop'],
\   'rb': ['rubocop'],
\   'bash': ['shfmt'],
\   'markdown': ['mdl'],
\   'go': ['gofmt', 'goimports']
\}

let g:ale_linters = {
\   'go': ['gobuild', 'gofmt', 'golint', 'gosimple', 'govet'],
\}

highlight clear ALEErrorSign
highlight clear ALEWarningSign
let g:airline#extensions#ale#enabled = 1
let g:ale_change_sign_column_color = 1

" Next error
map <C-e> :ALENext<CR>

" fzf
" Requires that fzf is cloned in ~/.fzf
set rtp+=~/.fzf

let g:fzf_history_dir = '~/.fzf-history'
let g:fzf_buffers_jump = 1

map <C-f> :Files<CR>

" Searches for the word under the cursor
map <C-s> :Rg <C-r><C-w><CR>

" swapfiles
set directory=~/.vim/swapfiles

" vim-ruby omni https://github.com/vim-ruby/vim-ruby/wiki/VimRubySupport#omni-completion-functions
let g:rubycomplete_buffer_loading = 1
let g:rubycomplete_classes_in_global = 1
let g:rubycomplete_rails = 1

set autoindent
set backspace=indent,eol,start
set colorcolumn=80
set cursorline
set expandtab
set hlsearch
set incsearch
set modeline
set modelines=5
set nocp
set number
set ruler
set shiftround
set shiftwidth=2
set tabstop=8

autocmd FileType crontab setlocal nobackup nowritebackup
autocmd FileType text,markdown let b:vcm_tab_complete = 'dict'
autocmd FileType go set autoindent noexpandtab tabstop=4 shiftwidth=4
autocmd FileType make setlocal noexpandtab

" Whitespace
nnoremap <silent> <F5> :let _s=@/ <Bar> :%s/\s\+$//e <Bar> :let @/=_s <Bar> :nohl <Bar> :unlet _s <CR>
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/

" Line numbers
map <C-n> :set nonumber!<CR>

" Splitting
set splitbelow
set splitright

" Terminal shortcut
map <C-T> :term ++close ++rows=10<cr>

" Prompt to create directory if it doesn't exist
" https://stackoverflow.com/a/42872275
augroup vimrc-auto-mkdir
  autocmd!
  autocmd BufWritePre * call s:auto_mkdir(expand('<afile>:p:h'), v:cmdbang)
  function! s:auto_mkdir(dir, force)
    if !isdirectory(a:dir)
          \   && (a:force
          \       || input("'" . a:dir . "' does not exist. Create? [y/N]") =~? '^y\%[es]$')
      call mkdir(iconv(a:dir, &encoding, &termencoding), 'p')
    endif
  endfunction
augroup END
