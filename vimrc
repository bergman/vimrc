filetype off
execute pathogen#infect()
execute pathogen#helptags()
syntax on
filetype indent plugin on

set nocompatible
let g:Powerline_symbols = 'fancy'
let g:syntastic_check_on_open=1
let g:syntastic_always_populate_loc_list=1
"let g:syntastic_python_checker_args='--ignore=E501,E302'
"let g:syntastic_python_checker_args='--ignore=E501,E302,E111,E303'

" dont manage working dir
let g:ctrlp_working_path_mode = 0
let g:ctrlp_custom_ignore = 'node_modules'
let g:ctrlp_open_multiple_files = '4hjr'

let g:easytags_cmd = '/usr/local/bin/ctags --exclude=.git'

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

set t_Co=256
colorscheme Tomorrow-Night
hi Normal ctermbg=none
hi Folded ctermbg=none

set modeline
set modelines=3

" enable statusbar for all windows
set laststatus=2

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
    normal! zx
    normal! zz
    return 1
  endif
endfunction
augroup resCur
  autocmd!
  autocmd BufWinEnter * call ResCur()
augroup END

" make Python follow PEP8 for whitespace (http://www.python.org/dev/peps/pep-0008/)
autocmd FileType python setlocal softtabstop=4 tabstop=4 shiftwidth=4 expandtab foldmethod=indent foldminlines=2
autocmd FileType haskell setl makeprg=ghc\ %
autocmd FileType javascript setl foldmethod=syntax shiftwidth=2 expandtab nosmartindent formatoptions-=o
autocmd FileType coffee setl foldmethod=indent shiftwidth=2 expandtab nosmartindent formatoptions-=o
autocmd InsertLeave *.coffee syn sync fromstart
autocmd FileType markdown setlocal textwidth=72 formatoptions=cqt wrapmargin=0

autocmd FileType coffee hi coffeeThinArrow ctermbg=Blue ctermfg=Black
autocmd FileType coffee syn match coffeeThinArrow /->/
autocmd FileType coffee hi coffeeFatArrow ctermbg=Brown ctermfg=Black
autocmd FileType coffee syn match coffeeFatArrow /=>/
autocmd FileType coffee hi coffeeConsole ctermfg=Magenta
autocmd FileType coffee syn match coffeeConsole /\<console\>/
autocmd FileType coffee syn match coffeeSpaceError /^\t\+/
highlight Todo ctermbg=Magenta ctermfg=Black
autocmd BufEnter * syn match Done /.*@done/
highlight Done ctermfg=Darkgray

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

"set statusline=%<%f\ %h%m%r\ %a%=%-14.(%l,%c%V%)\ %P

" easy split navigation http://vimbits.com/bits/10
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" hides buffers instead of closing when switching to a new one
set hidden

" set tabstop to 2 spaces
set tabstop=2
set shiftwidth=2

" disable swap and backup files
set nobackup noswapfile

nnoremap <leader>l :lwindow<CR>
nnoremap <leader>q :cwindow<CR>

set wildignore+=*.pyc,.DS_Store,*.class,*/dump/*

set nu " show line numbers

set history=1000

set listchars=trail:-,tab:>-
set list
set fillchars="vert:|,fold:"
set splitbelow
set splitright
set nowrap
set backspace=indent,eol,start " allow backspacing over these
set formatoptions-=o " don't continue comments on o/O
" doesn't work on earlier versions of vim 7.3
set formatoptions+=j " remove extra comment markers when joining lines

noremap Y y$
" disable shift-k for man pages
nnoremap K <Nop>
nnoremap <leader>v :vs $MYVIMRC<CR>
" show syntax name/type under cursor
nnoremap <leader>c :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
      \ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
      \ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>

nnoremap ]l :lwindow<cr>:lnext<cr>zx
nnoremap [l :lwindow<cr>:lprevious<cr>zx
nnoremap ]q :cwindow<cr>:cnext<cr>zx
nnoremap [q :cwindow<cr>:cprevious<cr>zx

" markdown headers
nnoremap <leader>1 :t.<cr>Vr=o<cr>
nnoremap <leader>2 :t.<cr>Vr-o<cr>

" javascript
" console.log word under cursor
nnoremap <leader>m yiwOconsole.log("<esc>pa:", <esc>pa)<esc>
" console.log selected text
vnoremap <leader>m yOconsole.log("<esc>pa:", <esc>pa)<esc>

" kolon
nnoremap Ö :

" add @done to end of line
nnoremap <leader>d mmA @done <C-R>=strftime("%Y-%m-%d %H:%M")<cr><esc>`m

" vim powerline settings:
" https://powerline.readthedocs.org/en/latest/tipstricks.html
set noshowmode " Hide the default mode text (e.g. -- INSERT -- below the statusline)

" make esc faster
if ! has('gui_running')
    set ttimeoutlen=10
    augroup FastEscape
        autocmd!
        au InsertEnter * set timeoutlen=0
        au InsertLeave * set timeoutlen=1000
    augroup END
endif

" Set a nicer foldtext function
set foldtext=MyFoldText()
function! MyFoldText()
  return getline(v:foldstart) . ' ...'
endfunction
