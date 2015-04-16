"{{{ Plug-ins
filetype off
set rtp+=~/.vim/bundle/Vundle.vim/
call vundle#begin()
Plugin 'gmarik/Vundle.vim'

" colorschemes
Plugin 'morhetz/gruvbox'
Plugin 'sickill/vim-monokai'

" functionality
Plugin 'benmills/vimux'
Plugin 'ervandew/ag'
Plugin 'godlygeek/tabular'
Plugin 'milkypostman/vim-togglelist'
Plugin 'scrooloose/syntastic'
Plugin 'shougo/unite-outline'
Plugin 'shougo/unite.vim'
Plugin 'shougo/vimproc.vim'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-git'
Plugin 'tpope/vim-markdown'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-vinegar'
Plugin 'tsukkee/unite-tag'
Plugin 'vimwiki/vimwiki'

" filetype
Plugin 'derekwyatt/vim-scala'
Plugin 'hynek/vim-python-pep8-indent'
Plugin 'kchmck/vim-coffee-script'
Plugin 'nvie/vim-flake8'
Plugin 'pangloss/vim-javascript'
Plugin 'vim-scripts/jade.vim'
Plugin 'wavded/vim-stylus'
Plugin 'wlue/thrift.vim'

call vundle#end()
"}}}
"{{{ Searching
set hlsearch " highlight matches in a search (hls)
set incsearch " show the current matching pattern as you search (is)
nnoremap <silent> <leader><space> :nohlsearch<cr>:syntax sync fromstart<cr>

" Visual star search
" http://got-ravings.blogspot.se/2008/07/vim-pr0n-visual-search-mappings.html
function! s:VSetSearch()
  let temp = @@
  norm! gvy
  let @/ = '\V' . substitute(escape(@@, '\'), '\n', '\\n', 'g')
  let @@ = temp
endfunction

if executable('ag')
  set grepprg=ag\ --nogroup\ --nocolor
endif

vnoremap * :<C-u>call <SID>VSetSearch()<CR>//<CR>
vnoremap # :<C-u>call <SID>VSetSearch()<CR>??<CR>
"}}}
"{{{ Look and feel
syntax on
filetype indent plugin on
set background=dark
colorscheme gruvbox
set background=dark
highlight Normal ctermbg=NONE

" delete netrw buffers
autocmd FileType netrw setl bufhidden=delete

" make ctrl-6 work again
let g:netrw_altfile=1

let g:netrw_list_hide= '.*\.swp$,.*\.pyc'
set timeoutlen=1000 ttimeoutlen=10

set modeline
set modelines=3

"set wildmode=longest,list,full
set wildmode=longest,list:longest
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
"set nobackup noswapfile
set backupdir=~/.vim/.backup
set directory=~/.vim/.swap

set number " show line numbers

set listchars=trail:-,tab:>-
set list
set fillchars="vert:|,fold:"
"set splitbelow
"set splitright
set nowrap
set backspace=indent,eol,start " allow backspacing over these
set formatoptions-=o " don't continue comments on o/O
if v:version ># 703 || v:version ==# 703 && has('patch541')
  " doesn't work on vim versions earlier than 7.3.541
  set formatoptions+=j " remove extra comment markers when joining lines
endif

" Make Y behave like C, D etc instead of like S
"noremap Y y$

" Set a nicer foldtext function
set foldtext=NumLinesEndOfLine()
function! NumLinesEndOfLine()
  let maxwidth = 80
  let lines = (v:foldend - v:foldstart + 1)
  let linetext = strpart(getline(v:foldstart), 0, -3 + maxwidth - len(lines))
  return linetext . repeat(' ', maxwidth - len(linetext) - len(lines)) . lines
endfunction

" Tell vim to remember certain things when we exit
"  '100  :  marks will be remembered for up to 100 previously edited files
"  "100  :  will save up to 100 lines for each register
"  :1000 :  up to 1000 lines of command-line history will be remembered
"  %     :  saves and restores the buffer list
"  n...  :  where to save the viminfo files
set viminfo='100,\"100,:1000,%,n~/.viminfo

" command history
set history=1000

" auto-reload files changed on disk.
set autoread

" fold comments as well as code (default: #)
set foldignore=

set tags=.tags

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

" show syntax name/type under cursor
nnoremap <leader>c :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
      \ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
      \ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>

nnoremap ]l :lwindow<cr>:lnext<cr>zx
nnoremap [l :lwindow<cr>:lprevious<cr>zx
nnoremap ]q :cwindow<cr>:cnext<cr>zx
nnoremap [q :cwindow<cr>:cprevious<cr>zx
nnoremap ]t :ptnext<cr>
nnoremap [t :ptprevious<cr>
nnoremap ]u :UniteNext<cr>
nnoremap [u :UnitePrevious<cr>

" mappa svenska Ö till kolon om man råkar köra svenskt tangentbord
nnoremap Ö :

nnoremap <leader>p :set paste!<CR>

"nnoremap <leader>h mmA<C-R>=strftime("%Y-%m-%d %H.%M")<cr><esc>`m
nnoremap <leader>h o<C-R>=strftime("%Y-%m-%d %H.%M")<cr><esc>
nnoremap <leader>H O<C-R>=strftime("%Y-%m-%d %H.%M")<cr><esc>

" open preview window with tag under cursor
nnoremap <silent> <leader>o <c-w>}

" open ~/.vim with leader-v
nnoremap <leader>v :tabedit ~/.vim<CR>G

" sort comma-space separated words on a line
nnoremap <silent> <leader>s ::call setline(line('.'),join(sort(split(getline('.'), ',\s*')), ', '))<cr>
"}}}
"{{{ Statusline
" LEFT:
" relative filename, [help][modified][readonly] arguments (file 1 of 3)
" RIGHT:
" row,col
" set statusline=%<%f\ %h%m%r\ %a%=%l,%c,%P
set statusline=%<%f\ %h%m%r\ %a%=%-14.(%l,%c%V%)\ %P
" enable statusline for all windows
set laststatus=2
"}}}
"{{{ Syntastic
"let g:syntastic_check_on_open=1
let g:syntastic_always_populate_loc_list=1
let g:syntastic_python_checkers = ['frosted', 'flake8']
"}}}
"{{{ Undo
if has('persistent_undo')
  set undofile                " Save undo's after file closes
  set undodir=~/.vim/.undo    " where to save undo histories
  set undolevels=1000         " How many undos
  set undoreload=10000        " number of lines to save for undo
endif
"}}}
"{{{ Unite.vim
" http://www.reddit.com/r/vim/comments/26470p/how_are_you_using_unitevim/cho9wz5
let g:unite_data_directory='~/.vim/.unite'
let g:unite_source_history_yank_enable=1
if executable('ag')
  let g:unite_source_grep_command='ag'
  let g:unite_source_grep_default_opts='--nocolor --nogroup --line-numbers'
  let g:unite_source_grep_recursive_opt=''
  let g:unite_source_rec_async_command='ag --follow --nocolor --nogroup --hidden -g ""'
endif

call unite#filters#matcher_default#use(['matcher_fuzzy'])
"call unite#filters#sorter_default#use(['sorter_rank'])

nnoremap <silent> <leader>\ :Unite -no-split -start-insert buffer<cr>
nnoremap <silent> <leader>, :Unite -no-split -input= -start-insert file_rec/async<cr>
nnoremap <silent> <leader>. :Unite -no-split -start-insert -ignorecase tag<cr>
nnoremap <silent> <leader>' :Unite -no-split -start-insert buffer file_rec/async tag<cr>
nnoremap <silent> <leader>y :Unite history/yank<cr>
nnoremap <silent> <leader>t :UniteWithCursorWord tag<cr>
nnoremap <silent> <leader>o :Unite -no-split outline<cr>
nnoremap <silent> <leader>g :Unite -start-insert grep<cr>


autocmd FileType unite call s:unite_settings()
function! s:unite_settings()
  imap <buffer> <C-j>   <Plug>(unite_select_next_line)
  imap <buffer> <C-k>   <Plug>(unite_select_previous_line)
  imap <silent><buffer><expr> <C-x> unite#do_action('below')
  imap <silent><buffer><expr> <C-v> unite#do_action('right')
  imap <silent><buffer><expr> <C-t> unite#do_action('tabopen')
  nmap <buffer> <C-j>     <Plug>(unite_toggle_auto_preview)

  nmap <buffer> <F5> <Plug>(unite_redraw)
  nmap <buffer> <ESC><ESC> <Plug>(unite_exit)
endfunction
"}}}
"{{{ Vimwiki
let g:vimwiki_list = [
      \ {'path': '~/vimwiki/',
        \ 'syntax': 'markdown',
        \ 'nested_syntaxes': {'python': 'python', 'sh': 'sh'}}
        \,
      \ {'path': '~/edgeware/vimwiki/',
        \ 'syntax': 'markdown',
        \ 'nested_syntaxes': {'python': 'python', 'sh': 'sh'}}
      \ ]
let g:vimwiki_diary_months = {
      \ 1: 'januari',
      \ 2: 'februari',
      \ 3: 'mars',
      \ 4: 'april',
      \ 5: 'maj',
      \ 6: 'juni',
      \ 7: 'juli',
      \ 8: 'augusti',
      \ 9: 'september',
      \ 10: 'oktober',
      \ 11: 'november',
      \ 12: 'december'
      \ }
autocmd BufEnter *.wiki set nonu
"}}}
"{{{ Vimux
let g:VimuxHeight = "10"
" q: quit scroll mode, C-u: clear command line, C-c: interrupt whatever is
" running
let g:VimuxResetSequence="q C-u C-c"
nnoremap <leader>z :VimuxPromptCommand<cr>
nnoremap <leader>x :VimuxRunLastCommand<cr>
"}}}
"{{{ Machine local settings in ~/.vimrc.local
if filereadable(glob("~/.vimrc.local")) 
  source ~/.vimrc.local
endif
"}}}
" vim: ft=vim fdm=marker et
