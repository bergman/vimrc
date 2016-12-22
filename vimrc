"{{{ Plug-ins
call plug#begin()

" colorschemes
Plug 'morhetz/gruvbox'

" functionality
Plug 'benekastah/neomake'
Plug 'benmills/vimux'
Plug 'bronson/vim-visual-star-search'
Plug 'ervandew/ag'
Plug 'godlygeek/tabular'
Plug 'lilydjwg/colorizer'
Plug 'milkypostman/vim-togglelist'
Plug 'shougo/denite.nvim'
Plug 'shougo/vimproc.vim', { 'do': 'make' }
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-vinegar'

" filetype
Plug 'sheerun/vim-polyglot'

call plug#end()
"}}}
"{{{ Searching
set hlsearch " highlight matches in a search (hls)
set incsearch " show the current matching pattern as you search (is)
nnoremap <silent> <leader><space> :nohlsearch<cr>:syntax sync fromstart<cr>

if executable('ag')
  set grepprg=ag\ --nogroup\ --nocolor
endif

set tags=./.tags;~
"}}}
"{{{ Neovim
if has("nvim")
  tnoremap <Esc> <C-\><C-n>
  tnoremap <C-w><C-w> <C-\><C-n><C-w><C-w>
endif
"}}}
"{{{ Look and feel
let $NVIM_TUI_ENABLE_CURSOR_SHAPE=1
let $NVIM_TUI_ENABLE_TRUE_COLOR=1
set termguicolors
syntax on
filetype indent plugin on
colorscheme gruvbox
if $ITERM_PROFILE =~ 'light'
  set background=light
  highlight Folded guibg=#F5EDD3
else
  set background=dark
endif
highlight Normal guibg=NONE

set showcmd
set statusline=%<%f\ %h%m%r\ %a%=%-14.(%l,%c%V%)\ %P
" enable statusline for all windows
set laststatus=2

" disable all bells (this is a bit backwards but it works)
" see: http://unix.stackexchange.com/a/5313
" see: :h visualbell
set visualbell
set t_vb=

" delete netrw buffers
autocmd FileType netrw setl bufhidden=delete

" make ctrl-6 work again
let g:netrw_altfile=1

set timeoutlen=1000 ttimeoutlen=10

set modeline modelines=3

"set wildmode=longest,list,full
set wildmenu wildmode=longest,list:longest wildignore+=*.pyc,.DS_Store,*.class,dump,.git/,*/.git/

" show git diff when committing
autocmd! BufEnter COMMIT_EDITMSG DiffGitCached | wincmd H | wincmd p | wincmd H | call setpos('.', [0, 1, 1, 0])
autocmd! BufWinLeave COMMIT_EDITMSG pclose

" defaults, space instead of tabs, set tabstop to 4 spaces
set expandtab tabstop=4 shiftwidth=4

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
if has("nvim")
  set viminfo='100,\"100,:1000,%
else
  set viminfo='100,\"100,:1000,%,n~/.viminfo
endif

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

" disable shift-k for man pages
nnoremap K <Nop>

" show syntax name/type under cursor
command! Highlight :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
      \ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
      \ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>

function! QuickFixPreviousFile()
  try
    cpfile
  catch /^Vim\%((\a\+)\)\=:E553/
    clast
  endtry
endfunction

function! QuickFixNextFile()
  try
    cnfile
  catch /^Vim\%((\a\+)\)\=:E553/
    cfirst
  endtry
endfunction

function! QuickFixPrevious()
  try
    cprev
  catch /^Vim\%((\a\+)\)\=:E553/
    cfirst
  endtry
endfunction

function! QuickFixNext()
  try
    cnext
  catch /^Vim\%((\a\+)\)\=:E553/
    clast
  endtry
endfunction

function! LocationPrevious()
  try
    lprev
  catch /^Vim\%((\a\+)\)\=:E553/
    llast
  endtry
endfunction

function! LocationNext()
  try
    lnext
  catch /^Vim\%((\a\+)\)\=:E553/
    lfirst
  endtry
endfunction

nnoremap ]l :call LocationNext()<cr>zx
nnoremap [l :call LocationPrevious()<cr>zx
nnoremap ]q :call QuickFixNext()<cr>zx
nnoremap [q :call QuickFixPrevious()<cr>zx
nnoremap ]w :call QuickFixNextFile()<cr>zx
nnoremap [w :call QuickFixPreviousFile()<cr>zx
nnoremap ]t :ptnext<cr>
nnoremap [t :ptprevious<cr>
nnoremap ]u :Denite -resume -select=+1 -immediately<cr>
nnoremap [u :Denite -resume -select=-1 -immediately<cr>

" mappa svenska Ö till kolon om man råkar köra svenskt tangentbord
nnoremap Ö :

nnoremap <leader>p :set paste!<CR>

"nnoremap <leader>h mmA<C-R>=strftime("%Y-%m-%d %H.%M")<cr><esc>`m
nnoremap <leader>h o<C-R>=strftime("%Y-%m-%d %H.%M")<cr><esc>
nnoremap <leader>H O<C-R>=strftime("%Y-%m-%d %H.%M")<cr><esc>

" open preview window with tag under cursor
nnoremap <silent> <leader>o <c-w>}

" open ~/.vim with leader-v
nnoremap <leader>v :edit $MYVIMRC<CR>

" sort comma-space separated words on a line
command SortCommaSeparated ::call setline(line('.'),join(sort(split(getline('.'), ',\s*')), ', '))<cr>
"}}}
"{{{ Undo
if has('persistent_undo')
  set undofile                " Save undo's after file closes
  set undodir=~/.vim/.undo    " where to save undo histories
  set undolevels=1000         " How many undos
  set undoreload=10000        " number of lines to save for undo
endif
"}}}
"{{{ denite
"call denite#custom#var('file_rec', 'command', ['ag', '--follow', '--nocolor', '--nogroup', '-g', ''])
call denite#custom#map('insert', '<Down>', '<denite:move_to_next_line>', 'noremap')
call denite#custom#map('insert', '<Up>', '<denite:move_to_previous_line>', 'noremap')
call denite#custom#source('file_mru', 'matchers', ['matcher_fuzzy', 'matcher_project_files'])
call denite#custom#source('file_rec', 'matchers', ['matcher_cpsm'])
call denite#custom#source('file_rec', 'sorters', ['sorter_sublime'])
call denite#custom#source('file_mru', 'converters', ['converter_relative_word'])

" Define alias
call denite#custom#alias('source', 'file_rec/git', 'file_rec')
call denite#custom#var('file_rec/git', 'command', ['git', 'ls-files', '-co', '--exclude-standard'])

" Change ignore_globs
call denite#custom#filter('matcher_ignore_globs', 'ignore_globs',
      \ [ '.git/', '.ropeproject/', '__pycache__/',
      \   'venv/', 'images/', '*.min.*', 'img/', 'fonts/'])

nnoremap <silent> <leader>\ :Denite -auto-resize -reversed buffer<cr>
nnoremap <silent> <leader>, :Denite -auto-resize -reversed file_rec/git<cr>
nnoremap <silent> <leader>. :Denite -auto-resize -reversed -ignorecase tag<cr>
nnoremap <silent> <leader>' :Denite -auto-resize -reversed file_rec/neovim tag<cr>
nnoremap <silent> <leader>y :Denite -auto-resize -reversed history/yank<cr>
nnoremap <silent> <leader>t :DeniteCursorWord -auto-resize -reversed tag<cr>
"}}}
"{{{ Vimux
let g:VimuxHeight = "10"
" q: quit scroll mode, C-u: clear command line, C-c: interrupt whatever is
" running
let g:VimuxResetSequence="q C-u C-c"
nnoremap <leader>z :VimuxPromptCommand<cr>
nnoremap <leader>x :VimuxRunLastCommand<cr>

function! VimuxRunLast()
  call VimuxSendKeys("C-c")
  call VimuxSendKeys("Up")
  call VimuxSendKeys("Enter")
endfunction
nnoremap <leader>r :call VimuxRunLast()<cr>
"}}}
"{{{ Javascript and Coffeescript
autocmd FileType javascript,coffeescript setlocal foldmethod=indent shiftwidth=2 expandtab nosmartindent
" console.log word under cursor
autocmd FileType javascript,coffeescript nnoremap <leader>m yiwoconsole.log("<esc>pa:", <esc>pa)<esc>
" console.log selected text
autocmd FileType javascript,coffeescript vnoremap <leader>m yoconsole.log("<esc>pa:", <esc>pa)<esc>
"
" coffeescript custom stuff, mark thin and fat arrows differently
autocmd FileType coffeescript highlight coffeeThinArrow guibg=Blue ctermbg=Blue guifg=Black ctermfg=Black
autocmd FileType coffeescript syntax match coffeeThinArrow /->/
autocmd FileType coffeescript highlight coffeeFatArrow guibg=Brown ctermbg=Brown guifg=Black ctermfg=Black
autocmd FileType coffeescript syntax match coffeeFatArrow /=>/
autocmd FileType coffeescript highlight coffeeConsole ctermfg=Magenta guifg=Magenta
autocmd FileType coffeescript syntax match coffeeConsole /\<console\>/
autocmd FileType coffeescript syntax match coffeeSpaceError /^\t\+/
"}}}
"{{{ Markdown
let g:markdown_folding=1
autocmd filetype markdown setlocal textwidth=72 formatoptions=cqt wrapmargin=0 expandtab autoindent

" headers
autocmd filetype markdown nnoremap <leader>1 :t.<cr>Vr=o<cr>
autocmd filetype markdown nnoremap <leader>2 :t.<cr>Vr-o<cr>
"}}}
"{{{ Python
" perform syntax check for python
autocmd! BufWritePost *.py Neomake

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
"{{{ XML
autocmd FileType xml setlocal foldmethod=indent equalprg=xmllint\ --format\ --recover\ -\ 2>/dev/null
"}}}
if filereadable(glob("~/.vimrc.local"))
  source ~/.vimrc.local
endif
" vim: ft=vim fdm=marker et
