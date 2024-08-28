set autochdir " Automatically switch to current working directory
set autoindent
set backspace=indent,eol,start
set clipboard=unnamedplus
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
set signcolumn=yes
set tabstop=8

autocmd FileType crontab setlocal nobackup nowritebackup
autocmd FileType go,cue,lua,make set autoindent noexpandtab tabstop=4 shiftwidth=4
autocmd FileType text,markdown let b:vcm_tab_complete = 'dict'

" Whitespace
nnoremap <silent> <F5> :let _s=@/ <Bar> :%s/\s\+$//e <Bar> :let @/=_s <Bar> :nohl <Bar> :unlet _s <CR>
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/

" Delete whitespace on save
autocmd BufWritePre * :%s/\s\+$//e

" Custom commands
command Blame Git blame
command Reload source ~/.vimrc
command Save Git save
command Terminal term ++close ++rows=10

" Directory navigation
command Root exe 'cd '.system('git rev-parse --show-cdup')
command Cur cd %:p:h

" https://github.com/vim/vim/issues/6112
set t_TI= t_TE=

" numbers
nnoremap <leader>n :NumbersToggle<CR>

" Prompt to create directory if it doesn't exist
" https://stackoverflow.com/a/42872275
augroup mkdir
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
