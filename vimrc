if &compatible
  set nocompatible " Be iMproved
endif

" vim-plug start
let data_dir = '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin()

" coc
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" Theme
Plug 'bluz71/vim-moonfly-colors'
Plug 'luochen1990/rainbow'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" Git
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb' " https://github.com/tpope/vim-rhubarb#installation
Plug 'airblade/vim-gitgutter'

" Files & search
Plug 'junegunn/fzf.vim'

" Syntax
Plug 'chr4/nginx.vim'
Plug 'ekalinin/Dockerfile.vim'
Plug 'fatih/vim-go'
Plug 'fladson/vim-kitty'
Plug 'google/vim-jsonnet'
Plug 'hashivim/vim-terraform'
Plug 'jjo/vim-cue'
Plug 'keith/rspec.vim'
Plug 'leafgarland/typescript-vim'
Plug 'vim-ruby/vim-ruby'

" Editor config
Plug 'editorconfig/editorconfig-vim'

" Tools
Plug 'cohama/lexima.vim'
Plug 'farmergreg/vim-lastplace'
Plug 'godlygeek/tabular'
Plug 'honza/vim-snippets'
Plug 'myusuf3/numbers.vim'
Plug 'ryanoasis/vim-devicons'
Plug 'szw/vim-g'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'

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
\ 'coc-diagnostic',
\ 'coc-docker',
\ 'coc-eslint',
\ 'coc-explorer',
\ 'coc-go',
\ 'coc-html',
\ 'coc-json',
\ 'coc-prettier',
\ 'coc-sh',
\ 'coc-snippets',
\ 'coc-solargraph',
\ 'coc-swagger',
\ 'coc-toml',
\ 'coc-tsserver',
\ 'coc-yaml',
\]

" Go to diagnostics
nmap <C-j> <Plug>(coc-diagnostic-next)
nmap <C-k> <Plug>(coc-diagnostic-prev)

" Expand snippets using CTRL+l
imap <C-l> <Plug>(coc-snippets-expand)

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

" Use K to show documentation in preview window
nnoremap <silent> K :call ShowDocumentation()<CR>

function! ShowDocumentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
  endif
endfunction

" Add `:Format` command to format current buffer
command! -nargs=0 Format :call CocActionAsync('format')

" explorer
nmap <space>e <Cmd>CocCommand explorer<CR>

" prettier
command! -nargs=0 Prettier :CocCommand prettier.forceFormatDocument

" swagger
command -nargs=0 Swagger :CocCommand swagger.render

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

""" Language Servers
" Required for operations modifying multiple buffers like rename.
set hidden

""" vim-go
let g:go_highlight_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_function_calls = 1
let g:go_highlight_operators = 1

" Compability with coc-go
let g:go_gopls_enabled = 1
let g:go_diagnostics_level = 0
let g:go_doc_keywordprg_enabled = 0
let g:go_code_completion_enabled = 0
let g:go_def_mapping_enabled = 0

""" go mod tidy
:command GoModTidy !go mod tidy -v

""" git-gutter
set signcolumn=yes

""" Shared clipboard
set clipboard=unnamedplus

""" Airline
let g:airline_theme='deus'
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#buffer_nr_show = 1

""" https://github.com/vim/vim/issues/6112
set t_TI= t_TE=

""" Theme
colorscheme moonfly
set termguicolors
syntax on

""" numbers
" \n for toggling number
nnoremap <leader>n :NumbersToggle<CR>

""" fzf
" Requires that fzf is cloned in ~/.fzf
set rtp+=~/.fzf
let g:fzf_history_dir = '~/.fzf-history'
let g:fzf_buffers_jump = 1

" Search for files
nmap <leader>f :Files<CR>
" Search for Git files
nmap <leader>g :GFiles<CR>
" Git diff files
nmap <leader>d :GFiles?<CR>
" Search for word
nmap <leader>s :Rg<CR>
" Search for the word under the cursor
nmap <leader>w :Rg <C-r><C-w><CR>
" Open buffers
nmap <leader>b :Buffers<CR>

""" swapfiles
set directory=~/.vim/swapfiles//

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
set noshowmode
set number
set ruler
set shiftround
set shiftwidth=2
set tabstop=8

autocmd FileType make set autoindent noexpandtab tabstop=4 shiftwidth=4
autocmd FileType crontab setlocal nobackup nowritebackup
autocmd FileType text,markdown let b:vcm_tab_complete = 'dict'
autocmd FileType go,cue set autoindent noexpandtab tabstop=4 shiftwidth=4

""" Whitespace
nnoremap <silent> <F5> :let _s=@/ <Bar> :%s/\s\+$//e <Bar> :let @/=_s <Bar> :nohl <Bar> :unlet _s <CR>
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/

" Delete whitespace on save
autocmd BufWritePre * :%s/\s\+$//e

""" Splitting
set splitbelow
set splitright

""" Disable arrow keys
for key in ['<Up>', '<Down>', '<Left>', '<Right>']
  exec 'noremap' key '<Nop>'
  exec 'inoremap' key '<Nop>'
  exec 'cnoremap' key '<Nop>'
endfor

" Disable page-up & page-down
nnoremap <PageUp> <Nop>
nnoremap <PageDown> <Nop>

""" Tabs
" Remap short for switch tabs
nnoremap H gT
nnoremap L gt

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

" Automatically open Terraform docs resource
function! TerraformDocs()
  let line = getline('.')
  let parts = split(line, '\zs\s\+\ze')

  if parts[0] != 'resource' && parts[0] != 'data'
    echoerr 'Cannot process line: '.line
    return
  endif

  let type = parts[0]
  let full_resource = parts[1]

  let provider = split(full_resource, "_")[0]
  let identifier = substitute(full_resource, provider.'_', '', '')

  if type == "data"
    let url_type = 'data-sources/'
  else
    let url_type = 'resources/'
  endif

  let url = 'https://registry.terraform.io/providers/hashicorp/'.provider.'/latest/docs/'.url_type.identifier

  execute system('open ' . url)
endfunction

function! TerraformFunc()
  let word = expand('<cword>')
  if word ==# ""
    echoerr 'No word under cursor'
    return
  endif

  let url = 'https://www.terraform.io/docs/configuration/functions/' . word . '.html'
  execute system('open ' . url)
endfunction

command TerraformDocs call TerraformDocs()
command TerraformFunc call TerraformFunc()

""" Custom commands
command Save Git save
command Reload source ~/.vimrc
command Terminal term ++close ++rows=10
command Blame Git blame

" Directory navigation
command Root exe 'cd '.system('git rev-parse --show-cdup')
command Cur cd %:p:h

" Automatically switch to current working directory
set autochdir
