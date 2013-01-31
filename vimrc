set nocompatible

call pathogen#infect()
call pathogen#helptags()

syntax enable
set t_Co=256
colorscheme Tomorrow-Night
hi Normal ctermbg=none
hi Folded ctermbg=none

filetype indent plugin on
let mapleader = ","
set laststatus=2 " enable statusbar for all windows

" Tell vim to remember certain things when we exit
"  '10  :  marks will be remembered for up to 10 previously edited files
"  "100 :  will save up to 100 lines for each register
"  :100 :  up to 100 lines of command-line history will be remembered
"  %    :  saves and restores the buffer list
"  n... :  where to save the viminfo files
set viminfo='10,\"100,:100,%,n~/.viminfo

" restore last position
function! ResCur()
  if line("'\"") <= line("$")
    normal! g`"
		normal! zv
		normal! zz
    return 1
  endif
endfunction
augroup resCur
  autocmd!
  autocmd BufWinEnter * call ResCur()
augroup END

" make Python follow PEP8 for whitespace (http://www.python.org/dev/peps/pep-0008/)
au FileType python setlocal softtabstop=4 tabstop=4 shiftwidth=4 expandtab foldmethod=indent foldminlines=2
au FileType haskell setl makeprg=ghc\ %
au FileType coffee setl foldmethod=indent shiftwidth=2 expandtab nosmartindent formatoptions-=o

let g:syntastic_check_on_open=1
"let g:syntastic_python_checker_args='--ignore=E501,E302'
"let g:syntastic_python_checker_args='--ignore=E501,E302,E111,E303'

set autoread " auto-reload files changed on disk.

set foldignore= " fold comments as well as code (default: #)

function! MakeGitCommitStartOnFirstLine()
  " don't (re)store filepos for git commit message files
  if &filetype == "gitcommit"
    call setpos('.', [0, 1, 1, 0])
  endif
endfunction

" make git commit messages always start on first line.
au BufEnter * call MakeGitCommitStartOnFirstLine()

set hlsearch " highlight matches in a search (hls),
set incsearch " show the current matching pattern as you search (is),

set colorcolumn=80 " highlights column 80, keeping lines short!

set statusline=%<%f\ %h%m%r\ %a%=%-14.(%l,%c%V%)\ %P

" easy split navigation http://vimbits.com/bits/10
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" hides buffers instead of closing when switching to a new one
"set hidden

" set tabstop to 2 spaces
set tabstop=2
set shiftwidth=2

" disable swap and backup files
set nobackup noswapfile

nnoremap <leader>l :TagbarToggle<CR>
" dont manage working dir
let g:ctrlp_working_path_mode = 0
let g:ctrlp_custom_ignore = 'node_modules'
let g:ctrlp_open_multiple_files = '4hjr'

let g:easytags_cmd = '/usr/local/bin/ctags'

set wildignore+=*.pyc,.DS_Store,*.class,*/dump/*

set nu " show line numbers

set history=1000

set splitbelow
set splitright
set nowrap
set backspace=indent,eol,start " allow backspacing over these
set formatoptions-=o " don't continue comments on o/O
set formatoptions+=j " remove extra comment markers when joining lines

let g:tagbar_type_scala = {
    \ 'ctagstype' : 'Scala',
    \ 'kinds'     : [
        \ 'p:packages:1',
        \ 'V:values',
        \ 'v:variables',
        \ 'T:types',
        \ 't:traits',
        \ 'o:objects',
        \ 'a:aclasses',
        \ 'c:classes',
        \ 'r:cclasses',
        \ 'm:methods'
    \ ]
\ }
