if &compatible
  set nocompatible " Be iMproved
endif

" Use CoC for LSP features
" https://github.com/dense-analysis/ale#5iii-how-can-i-use-ale-and-cocnvim-together
let g:ale_disable_lsp = 1

" vim-plug start
let data_dir = '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin()

" Linting and completion
Plug 'dense-analysis/ale'
Plug 'Shougo/neco-vim'
Plug 'neoclide/coc-neco'
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" Theme
Plug 'bluz71/vim-moonfly-colors'
Plug 'luochen1990/rainbow'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" Git
Plug 'tpope/vim-fugitive'
" https://github.com/tpope/vim-rhubarb#installation
Plug 'tpope/vim-rhubarb'

" Files & search
Plug 'junegunn/fzf.vim'
Plug 'ludovicchabant/vim-gutentags'

" Syntax
Plug 'chr4/nginx.vim'
Plug 'ekalinin/Dockerfile.vim'
Plug 'fatih/vim-go'
Plug 'google/vim-jsonnet'
Plug 'hashivim/vim-terraform'
Plug 'jjo/vim-cue'
Plug 'keith/rspec.vim'
Plug 'martinda/Jenkinsfile-vim-syntax'
Plug 'rodjek/vim-puppet'
Plug 'vim-ruby/vim-ruby'

" Editor config
Plug 'editorconfig/editorconfig-vim'

" Tools
Plug 'cohama/lexima.vim'
Plug 'godlygeek/tabular'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-surround'

call plug#end()
""" vim-plug end

""" CoC
" Ensure we use system node so it doesn't conflict with asdf and repos with
" older node version
let g:coc_node_path = '/usr/bin/node'

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Merge signcolumn and number column into one
set signcolumn=number

" Automatically install default plugins
let g:coc_global_extensions = [
\ 'coc-docker',
\ 'coc-eslint',
\ 'coc-explorer',
\ 'coc-go',
\ 'coc-json',
\ 'coc-prettier',
\ 'coc-sh',
\ 'coc-snippets',
\ 'coc-solargraph',
\ 'coc-swagger',
\ 'coc-tsserver',
\ 'coc-yaml',
\]

" Expand snippets using CTRL+l
imap <C-l> <Plug>(coc-snippets-expand)

" Formatting selected code: \f
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-@> coc#refresh()

inoremap <silent><expr> <TAB>
  \ coc#pum#visible() ? coc#_select_confirm() :
  \ coc#expandableOrJumpable() ?
  \ "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
  \ CheckBackSpace() ? "\<TAB>" :
  \ coc#refresh()

function! CheckBackSpace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

let g:coc_snippet_next = '<tab>'

" explorer
nmap <space>e <Cmd>CocCommand explorer<CR>

" prettier
command! -nargs=0 Prettier :CocCommand prettier.forceFormatDocument

""" Language Servers
" Required for operations modifying multiple buffers like rename.
set hidden

""" vim-go
let g:go_highlight_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_function_calls = 1
let g:go_highlight_operators = 1
" This handles using gopls language server
let g:go_code_completion_enabled = 1
let g:go_gopls_enabled = 1
" lint across the whole package to avoid false positives
let g:ale_go_golangci_lint_package = 1
let g:go_def_reuse_buffer = 1

""" go mod tidy
:command GoModTidy !go mod tidy -v

""" Shared clipboard
set clipboard=unnamedplus

""" Airline
let g:airline_theme='atomic'

""" https://github.com/vim/vim/issues/6112
set t_TI= t_TE=

""" Theme
colorscheme moonfly
set termguicolors
syntax on

""" ALE
let g:ale_fixers = {
\   '*': ['remove_trailing_lines', 'trim_whitespace'],
\   'ruby': ['rubocop'],
\   'rb': ['rubocop'],
\   'bash': ['shfmt'],
\   'go': ['gofmt', 'goimports'],
\   'terraform': ['terraform']
\}

let g:ale_fix_on_save = 0

highlight clear ALEErrorSign
highlight clear ALEWarningSign
let g:airline#extensions#ale#enabled = 1
let g:ale_change_sign_column_color = 1
let g:ale_list_window_size = 5

nmap <silent> <C-k> <Plug>(ale_previous_wrap)
nmap <silent> <C-j> <Plug>(ale_next_wrap)

""" fzf
" Requires that fzf is cloned in ~/.fzf
set rtp+=~/.fzf
let g:fzf_history_dir = '~/.fzf-history'
let g:fzf_buffers_jump = 1

map <C-f> :Files<CR>

" Searches for the word under the cursor
map <C-s> :Rg <C-r><C-w><CR>

""" swapfiles
set directory=~/.vim/swapfiles

""" vim-ruby omni https://github.com/vim-ruby/vim-ruby/wiki/VimRubySupport#omni-completion-functions
let g:rubycomplete_buffer_loading = 1
let g:rubycomplete_classes_in_global = 1
let g:rubycomplete_rails = 1

""" Terraform
let g:terraform_fmt_on_save=1

""" Defaults
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
set ruler
set shiftround
set shiftwidth=2
set tabstop=8

set number         " Show current line number
set relativenumber " Show relative line numbers

autocmd FileType make set autoindent noexpandtab tabstop=4 shiftwidth=4
autocmd FileType crontab setlocal nobackup nowritebackup
autocmd FileType text,markdown let b:vcm_tab_complete = 'dict'
autocmd FileType go,cue set autoindent noexpandtab tabstop=4 shiftwidth=4

""" Whitespace
nnoremap <silent> <F5> :let _s=@/ <Bar> :%s/\s\+$//e <Bar> :let @/=_s <Bar> :nohl <Bar> :unlet _s <CR>
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/

""" Splitting
set splitbelow
set splitright

""" Disable arrow keys
" Command Mode
cnoremap <Down> <Nop>
cnoremap <Left> <Nop>
cnoremap <Right> <Nop>
cnoremap <Up> <Nop>

" Insert Mode
inoremap <Down> <Nop>
inoremap <Left> <Nop>
inoremap <Right> <Nop>
inoremap <Up> <Nop>

" Normal Mode
nnoremap <Down> <Nop>
nnoremap <Left> <Nop>
nnoremap <Right> <Nop>
nnoremap <Up> <Nop>

" Visual Mode
vnoremap <Down> <Nop>
vnoremap <Left> <Nop>
vnoremap <Right> <Nop>
vnoremap <Up> <Nop>

" Disable page-up & page-down
nnoremap <PageUp> <Nop>
nnoremap <PageDown> <Nop>

""" Prompt to create directory if it doesn't exist
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

""" Custom commands
command Save Git save
