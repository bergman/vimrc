" vim: filetype=vim foldmethod=marker et

filetype off
" Plug-ins {{{
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()
Plugin 'bling/vim-airline'
Plugin 'chriskempson/base16-vim'
Plugin 'derekwyatt/vim-scala'
Plugin 'godlygeek/tabular'
Plugin 'hynek/vim-python-pep8-indent'
Plugin 'kchmck/vim-coffee-script'
Plugin 'kien/ctrlp.vim'
Plugin 'nelstrom/vim-visual-star-search'
Plugin 'nvie/vim-flake8'
Plugin 'rking/ag.vim'
Plugin 'scrooloose/syntastic'
Plugin 'sprsquish/thrift.vim'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-git'
Plugin 'tpope/vim-markdown'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-vinegar'
Plugin 'wavded/vim-stylus'
"}}}
set nocompatible
"{{{ Searching
set ignorecase " ignore case in searches
set smartcase " ignore case unless at least one upper case char
set hlsearch " highlight matches in a search (hls)
set incsearch " show the current matching pattern as you search (is)
nnoremap <silent> <leader><space> :nohlsearch<cr>
let g:agprg = 'ag --column --smart-case'
"}}}
"{{{ Look and feel
syntax on
filetype indent plugin on
set t_Co=256
let base16colorspace=256  " Access colors present in 256 colorspace
colorscheme base16-tomorrow
set background=dark
highlight MatchParen ctermbg=19
highlight SpecialKey ctermfg=19
highlight StatusLine ctermbg=2 ctermfg=0
highlight StatusLineNC ctermbg=19 ctermfg=8
highlight TabLineSel ctermbg=19

" netrw tree listing
let g:netrw_liststyle=3

set modeline
set modelines=3

set wildmode=longest,list,full
set wildmenu
set wildignore+=*.pyc,.DS_Store,*.class,dump,.git/,*/.git/

" hides buffers instead of closing when switching to a new one
"set hidden

" what to save in sessions, default except no options
set sessionoptions=blank,buffers,curdir,folds,help,localoptions,tabpages,winsize

" defaults, space instead of tabs
set expandtab

" set tabstop to 2 spaces
set tabstop=2
set shiftwidth=2

" disable swap and backup files
set nobackup noswapfile

set number " show line numbers

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

" Make Y behave like C, D etc instead of like S
noremap Y y$

" Set a nicer foldtext function
set foldtext=MyFoldText()
function! MyFoldText()
  let maxwidth = 80
  let endtext = (v:foldend - v:foldstart + 1) . ' lines'
  let linetext = strpart(getline(v:foldstart), 0, -3 + maxwidth - len(endtext))
  let textlength = len(linetext)
  return linetext . repeat(' ', 80 - textlength - len(endtext)) . endtext
endfunction

" open preview window with tag under cursor
nnoremap <silent> <leader>o <c-w>}
"}}}
"{{{ Statusline
" LEFT:
" relative filename, [help][modified][readonly] arguments (file 1 of 3)
" RIGHT:
" NOTHING
set statusline=%<%f\ %h%m%r\ %a%=%l,%c%V
" enable statusline for all windows
set laststatus=2

" disable airline
let g:loaded_airline = 1
let g:airline_section_z = '%3l,%2c'
let g:airline_theme = 'base16'
let g:airline_left_sep=''
let g:airline_right_sep=''
let g:airline#extensions#branch#enabled = 0
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#buffer_min_count = 2
let g:airline#extensions#tabline#formatter = 'unique_tail_improved'
let g:airline#extensions#tabline#left_alt_sep = '|'
let g:airline#extensions#tabline#left_sep = ''
let g:airline#extensions#tabline#show_buffers = 0
let g:airline#extensions#tabline#show_tab_type = 0
let g:airline#extensions#tabline#tab_min_count = 0
let g:airline#extensions#tabline#tab_nr_type = 1 " tab number
let g:airline#extensions#tagbar#enabled = 0
let g:airline#extensions#whitespace#enabled = 0

" Hide the default mode text (e.g. -- INSERT -- below the statusline)
"set noshowmode
"}}}
"{{{ Syntastic
"let g:syntastic_check_on_open=1
let g:syntastic_always_populate_loc_list=1
let g:syntastic_python_checkers = ['frosted', 'flake8']
"}}}
"{{{ Undo
if has('persistent_undo')
  set undofile                " Save undo's after file closes
  set undodir=~/.vim/undo " where to save undo histories
  set undolevels=1000         " How many undos
  set undoreload=10000        " number of lines to save for undo
endif
"}}}
"{{{ Ctrl-P
" use ag, should be faster
let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
" dont manage working dir
let g:ctrlp_match_window = 'bottom,order:btt,min:1,max:20,results:100'
let g:ctrlp_working_path_mode = 0
let g:ctrlp_custom_ignore = 'node_modules'
let g:ctrlp_open_multiple_files = '4hjr'
let g:ctrlp_map = ''
let g:ctrlp_clear_cache_on_exit = 0
nnoremap <silent> <leader>, :let g:ctrlp_default_input = ''<cr>:CtrlP<cr>
nnoremap <silent> <leader>. :let g:ctrlp_default_input = '^'<cr>:CtrlPTag<cr>
nnoremap <silent> <leader>t :let g:ctrlp_default_input = expand('<cword>')<cr>:CtrlPTag<cr>
"}}}
"{{{ Utilities
" sort words on a line
nnoremap <silent> <leader>s ::call setline(line('.'),join(sort(split(getline('.'), ',\s*')), ', '))<cr>
"}}}

" Tell vim to remember certain things when we exit
"  '10  :  marks will be remembered for up to 10 previously edited files
"  "100 :  will save up to 100 lines for each register
"  :100 :  up to 100 lines of command-line history will be remembered
"  %    :  saves and restores the buffer list
"  n... :  where to save the viminfo files
set viminfo='10,\"100,:1000,%,n~/.viminfo

" command history
set history=1000

highlight Todo ctermbg=Magenta ctermfg=Black

" taskpaper
autocmd BufEnter * syntax match Done /.*@done/
highlight Done ctermfg=Darkgray
" add @done to end of line
nnoremap <leader>d mmA @done <C-R>=strftime("%Y-%m-%d %H:%M")<cr><esc>`m

setlocal formatoptions-=o
set formatoptions-=o

" auto-reload files changed on disk.
set autoread

" fold comments as well as code (default: #)
set foldignore=

" restore last position
function! ResCur()
  if line("'\"") > 0 && line("'\"") <= line("$")
    " go to last known position
    normal! g`"
    " fold everything else
    normal! zx
    " center line
    normal! zz
  endif
endfunction
augroup resCur
  autocmd!
  autocmd BufWinEnter * call ResCur()
augroup END

" easy split navigation http://vimbits.com/bits/10
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" disable shift-k for man pages
nnoremap K <Nop>

" open ~/.vimrc with leader-v
nnoremap <leader>v :tabnew<CR>:lcd ~/.vim<CR>:e $MYVIMRC<CR>

" show syntax name/type under cursor
nnoremap <leader>c :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
      \ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
      \ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>

nnoremap <leader>l :lwindow<CR>
nnoremap <leader>q :cwindow<CR>

nnoremap ]l :lwindow<cr>:lnext<cr>zx
nnoremap [l :lwindow<cr>:lprevious<cr>zx
nnoremap ]q :cwindow<cr>:cnext<cr>zx
nnoremap [q :cwindow<cr>:cprevious<cr>zx
nnoremap ]t :ptnext<cr>
nnoremap [t :ptprevious<cr>

" mappa svenska Ö till kolon om man råkar köra svenskt tangentbord
nnoremap Ö :

nnoremap <leader>p :set paste!<CR>

"nnoremap <leader>h mmA<C-R>=strftime("%Y-%m-%d %H.%M")<cr><esc>`m
nnoremap <leader>h o<C-R>=strftime("%Y-%m-%d %H.%M")<cr><esc>
nnoremap <leader>H O<C-R>=strftime("%Y-%m-%d %H.%M")<cr><esc>

set timeoutlen=1000 ttimeoutlen=10

"" make esc faster
"if ! has('gui_running')
"    set timeoutlen=10
"    augroup FastEscape
"        autocmd!
"        autocmd InsertEnter * set timeoutlen=0
"        autocmd InsertLeave * set timeoutlen=1000
"    augroup END
"endif

set tags=.tags
let g:netrw_list_hide= '.*\.swp$,.*\.pyc'
