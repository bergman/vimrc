filetype off
execute pathogen#infect()
execute pathogen#helptags()
syntax on
filetype indent plugin on

set nocompatible

set t_Co=256
let base16colorspace=256  " Access colors present in 256 colorspace
colorscheme base16-tomorrow
"colorscheme Tomorrow-Night
highlight Normal ctermbg=none
highlight Folded ctermbg=none

let g:agprg = 'ag --column --smart-case'
let g:airline_section_z = '%3l,%2c'
let g:airline_theme = 'badwolf'
let g:airline_left_sep=''
let g:airline_right_sep=''
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#left_sep = ''
let g:airline#extensions#tabline#left_alt_sep = '|'

set background=dark

"let g:syntastic_check_on_open=1
let g:syntastic_always_populate_loc_list=1
"let g:syntastic_python_checker_args='--ignore=E501,E302'
"let g:syntastic_python_checker_args='--ignore=E501,E302,E111,E303'

" dont manage working dir
let g:ctrlp_working_path_mode = 0
let g:ctrlp_custom_ignore = 'node_modules'
let g:ctrlp_open_multiple_files = '4hjr'
let g:ctrlp_map = '<leader>,'
nnoremap <leader>. :CtrlPTag<CR>
nnoremap <leader>t :Tagbar<CR>

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
set viminfo='10,\"100,:1000,%,n~/.viminfo

" restore last position
function! ResCur()
  if line("'\"") > 0 && line("'\"") <= line("$")
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
autocmd FileType python setlocal softtabstop=4 tabstop=4 shiftwidth=4 expandtab foldmethod=indent
autocmd FileType haskell setlocal makeprg=ghc\ %
autocmd FileType javascript setlocal foldmethod=syntax shiftwidth=2 expandtab nosmartindent formatoptions-=o
autocmd FileType coffee setlocal foldmethod=indent shiftwidth=2 expandtab nosmartindent formatoptions-=o
autocmd InsertLeave *.coffee syntax sync fromstart
autocmd FileType markdown setlocal textwidth=72 formatoptions=cqt wrapmargin=0 expandtab autoindent

autocmd FileType coffee highlight coffeeThinArrow ctermbg=Blue ctermfg=Black
autocmd FileType coffee syntax match coffeeThinArrow /->/
autocmd FileType coffee highlight coffeeFatArrow ctermbg=Brown ctermfg=Black
autocmd FileType coffee syntax match coffeeFatArrow /=>/
autocmd FileType coffee highlight coffeeConsole ctermfg=Magenta
autocmd FileType coffee syntax match coffeeConsole /\<console\>/
autocmd FileType coffee syntax match coffeeSpaceError /^\t\+/
highlight Todo ctermbg=Magenta ctermfg=Black
autocmd BufEnter * syntax match Done /.*@done/
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

set hlsearch " highlight matches in a search (hls)
set incsearch " show the current matching pattern as you search (is)

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

set wildignore+=*.pyc,.DS_Store,*.class,*/dump/*,*/.git/*

set number " show line numbers

set history=1000

set listchars=trail:-,tab:>-
set list
set fillchars="vert:|,fold:"
set splitbelow
set splitright
set nowrap
set backspace=indent,eol,start " allow backspacing over these
set formatoptions-=o " don't continue comments on o/O
if v:version ># 703 || v:version ==# 703 && has('patch541')
  " doesn't work on vim versions earlier than 7.3.541
  set formatoptions+=j " remove extra comment markers when joining lines
endif

noremap Y y$
" disable shift-k for man pages
nnoremap K <Nop>
nnoremap <leader>v :tabe $MYVIMRC<CR>
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

"" javascript
"" console.log word under cursor
"nnoremap <leader>m yiwOconsole.log("<esc>pa:", <esc>pa)<esc>
"" console.log selected text
"vnoremap <leader>m yOconsole.log("<esc>pa:", <esc>pa)<esc>

" python
" print word under cursor
nnoremap <leader>m yiwOprint "<esc>pa: %s" % <esc>pa<esc>
" print selected text
vnoremap <leader>m yOprint "<esc>pa: %s" % <esc>pa<esc>

" kolon
nnoremap Ö :

" add @done to end of line
nnoremap <leader>d mmA @done <C-R>=strftime("%Y-%m-%d %H:%M")<cr><esc>`m
nnoremap <leader>p :set paste!<CR>

"nnoremap <leader>h mmA<C-R>=strftime("%Y-%m-%d %H.%M")<cr><esc>`m
nnoremap <leader>h o<C-R>=strftime("%Y-%m-%d %H.%M")<cr><esc>
nnoremap <leader>H O<C-R>=strftime("%Y-%m-%d %H.%M")<cr><esc>

" vim powerline settings:
" https://powerline.readthedocs.org/en/latest/tipstricks.html
set noshowmode " Hide the default mode text (e.g. -- INSERT -- below the statusline)

set timeoutlen=1000 ttimeoutlen=10

"" make esc faster
"if ! has('gui_running')
"    set timeoutlen=10
"    augroup FastEscape
"        autocmd!
"        au InsertEnter * set timeoutlen=0
"        au InsertLeave * set timeoutlen=1000
"    augroup END
"endif

" Set a nicer foldtext function
set foldtext=MyFoldText()
function! MyFoldText()
  let maxwidth = 80
  let endtext = (v:foldend - v:foldstart + 1) . ' lines'
  let linetext = strpart(getline(v:foldstart), 0, -3 + maxwidth - len(endtext))
  let textlength = len(linetext)
  return linetext . repeat(' ', 80 - textlength - len(endtext)) . endtext
endfunction

set tags=.tags
let g:netrw_list_hide= '.*\.swp$,.*\.pyc'
