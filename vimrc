"{{{ Plug-ins
call plug#begin()

" colorschemes
Plug 'morhetz/gruvbox'

" functionality
Plug 'benmills/vimux'
Plug 'ervandew/ag'
Plug 'godlygeek/tabular'
Plug 'milkypostman/vim-togglelist'
Plug 'scrooloose/syntastic'
Plug 'shougo/unite-outline'
Plug 'shougo/unite.vim'
Plug 'shougo/vimproc.vim', { 'do': 'make' }
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-git'
Plug 'tpope/vim-markdown'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'tsukkee/unite-tag'
Plug 'wincent/terminus'

" filetype
Plug 'sheerun/vim-polyglot'

call plug#end()
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
vnoremap * :<C-u>call <SID>VSetSearch()<CR>//<CR>
vnoremap # :<C-u>call <SID>VSetSearch()<CR>??<CR>

if executable('ag')
  set grepprg=ag\ --nogroup\ --nocolor
endif
"}}}
"{{{ Look and feel
syntax on
filetype indent plugin on
colorscheme gruvbox
set background=dark
highlight Normal ctermbg=NONE

" disable all bells (this is a bit backwards but it works)
" see: http://unix.stackexchange.com/a/5313
" see: :h visualbell
set visualbell
set t_vb=

" delete netrw buffers
autocmd FileType netrw setl bufhidden=delete

" make ctrl-6 work again
let g:netrw_altfile=1

" hide by default
let g:netrw_hide=1
let g:netrw_list_hide= '.*\.py[co],\(^\|\s\s\)\zs\.\S\+'

set timeoutlen=1000 ttimeoutlen=10

set modeline
set modelines=3

"set wildmode=longest,list,full
set wildmode=longest,list:longest
set wildmenu
set wildignore+=*.pyc,.DS_Store,*.class,dump,.git/,*/.git/

" show git diff when committing
autocmd! BufEnter COMMIT_EDITMSG DiffGitCached | wincmd H | wincmd p | wincmd H | call setpos('.', [0, 1, 1, 0])
autocmd! BufWinLeave COMMIT_EDITMSG pclose

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
" disable backup for crontab
autocmd FileType crontab setlocal nowritebackup nobackup

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

" dash - for :Ex
nnoremap - :Explore<cr>

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
nnoremap ]w :cwindow<cr>:cnfile<cr>zx
nnoremap [w :cwindow<cr>:cpfile<cr>zx
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

autocmd FileType xml setlocal equalprg=xmllint\ --format\ --recover\ -\ 2>/dev/null
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
call unite#custom#source('file_rec/async,file_rec/git', 'sorters', ['sorter_length'])

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
"{{{ Vimux
let g:VimuxHeight = "10"
" q: quit scroll mode, C-u: clear command line, C-c: interrupt whatever is
" running
let g:VimuxResetSequence="q C-u C-c"
nnoremap <leader>z :VimuxPromptCommand<cr>
nnoremap <leader>x :VimuxRunLastCommand<cr>
"}}}
"{{{ Javascript and Coffeescript
autocmd FileType javascript,coffeescript setlocal foldmethod=indent shiftwidth=2 expandtab nosmartindent
" console.log word under cursor
autocmd FileType javascript,coffeescript nnoremap <leader>m yiwoconsole.log("<esc>pa:", <esc>pa)<esc>
" console.log selected text
autocmd FileType javascript,coffeescript vnoremap <leader>m yoconsole.log("<esc>pa:", <esc>pa)<esc>
"
" coffeescript custom stuff, mark thin and fat arrows differently
autocmd FileType coffeescript highlight coffeeThinArrow ctermbg=Blue ctermfg=Black
autocmd FileType coffeescript syntax match coffeeThinArrow /->/
autocmd FileType coffeescript highlight coffeeFatArrow ctermbg=Brown ctermfg=Black
autocmd FileType coffeescript syntax match coffeeFatArrow /=>/
autocmd FileType coffeescript highlight coffeeConsole ctermfg=Magenta
autocmd FileType coffeescript syntax match coffeeConsole /\<console\>/
autocmd FileType coffeescript syntax match coffeeSpaceError /^\t\+/
"}}}
"{{{ Markdown
autocmd filetype markdown setlocal textwidth=72 formatoptions=cqt wrapmargin=0 expandtab autoindent

" headers
autocmd filetype markdown nnoremap <leader>1 :t.<cr>Vr=o<cr>
autocmd filetype markdown nnoremap <leader>2 :t.<cr>Vr-o<cr>
"}}}
"{{{ Python
" make Python follow PEP8 for whitespace (http://www.python.org/dev/peps/pep-0008/)
autocmd FileType python setlocal softtabstop=4 tabstop=4 shiftwidth=4 expandtab foldmethod=indent foldlevelstart=0

" log word under cursor
autocmd FileType python nnoremap <leader>n yiwolog.info("<esc>pa: %s", <esc>pa)<esc>
" log selected text
autocmd FileType python vnoremap <leader>n yolog.info("<esc>pa: %s", <esc>pa)<esc>
" print word under cursor
autocmd FileType python nnoremap <leader>m yiwoprint "<esc>pa: %s" % <esc>pa<esc>
" print selected text
autocmd FileType python vnoremap <leader>m yoprint "<esc>pa: %s" % <esc>pa<esc>

let s:has_opened_ipython = 0
function! VimuxSlime(code)
  if !s:has_opened_ipython
    call VimuxRunCommand("ipython")
    let s:has_opened_ipython = 1
  endif

  call VimuxSendText("%cpaste")
  call VimuxSendKeys("Enter")
  call VimuxSendText(a:code)
  call VimuxSendKeys("Enter")
  call VimuxSendKeys("C-d")
endfunction

" If text is selected, save it in the v buffer and send that buffer to tmux
autocmd FileType python vnoremap <leader>r y :call VimuxSlime(@")<CR>
"}}}
"{{{ Machine local settings in ~/.vimrc.local
if filereadable(glob("~/.vimrc.local")) 
  source ~/.vimrc.local
endif
"}}}
" vim: ft=vim fdm=marker et
