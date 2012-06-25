call pathogen#infect()
call pathogen#helptags()

set background=dark
colorscheme solarized

syntax enable
let mapleader = ","
set t_Co=256
set laststatus=2
filetype indent plugin on
" make Python follow PEP8 for whitespace (http://www.python.org/dev/peps/pep-0008/)
au FileType python setlocal softtabstop=4 tabstop=4 shiftwidth=4 expandtab
au FileType python setlocal foldmethod=indent
au FileType python setlocal foldminlines=3
" auto-reload files changed on disk.
set autoread
function! MakeGitCommitStartOnFirstLine()
  " don't (re)store filepos for git commit message files
  if &filetype == "gitcommit"
    call setpos('.', [0, 1, 1, 0])
  endif
endfunction
" make git commit messages always start on first line.
autocmd BufEnter * call MakeGitCommitStartOnFirstLine()
au FileType haskell setl makeprg=ghc\ %
" disable blinking cursor
set gcr=a:blinkon0
" highlight matches in a search (hls),
set hlsearch
" show the current matching pattern as you search (is),
set incsearch
" ignore case (ic) unless you are searching for both upper and lowercase letters (scs).
set ignorecase smartcase

"" highlight current line
"set cursorline
"
"" highlights column 80, keping lines short!
"set colorcolumn=80

set statusline=%<%f\ %h%m%r\ %a%=%-14.(%l,%c%V%)\ %P

" make Y behave like other capitals
" http://vimbits.com/bits/11
map Y y$

"" easy split navigation
"" http://vimbits.com/bits/10
"noremap <C-h> <C-w>h
"noremap <C-j> <C-w>j
"noremap <C-k> <C-w>k
"noremap <C-l> <C-w>l

"" Reselect visual block after indent
"" http://vimbits.com/bits/20
"vnoremap < <gv
"vnoremap > >gv
"
"" Use sane regexes (:h magic)
"" http://vimbits.com/bits/17
"nnoremap / /\v
"vnoremap / /\v

" Kill tabs and trailing space
" http://vimbits.com/bits/297
command! CLEAN retab | %s/ \+$//

" make mouse work
" set mouse=n

" hides buffers instead of closing when switching to a new one
set hidden

" set tabstop to 2 spaces
set tabstop=2

" disable swap and backup files
set nobackup
set noswapfile

nnoremap <leader>l :TagbarToggle<CR>
" map ctrl-p to something else so it wont collide with yankring
let g:ctrlp_map = '<c-t>'
" dont manage working dir
let g:ctrlp_working_path_mode = 0
" run find instead of vim glob
"let g:ctrlp_user_command = ['.git/', 'cd %s && git ls-files']

set wildignore+=*.pyc

let ctrlp_filter_greps = "".
    \ "egrep -iv '\\.(" .
    \ "jar|class|swp|swo|log|so|o|pyc|jpe?g|png|gif|mo|po" .
    \ ")$' | " .
    \ "egrep -v '^(\\./)?(" .
    \ "deploy/|lib/|classes/|libs/|deploy/vendor/|.git/|.hg/|.svn/|.*migrations/" .
    \ ")'"
let my_ctrlp_git_command = "" .
    \ "cd %s && git ls-files | " .
    \ ctrlp_filter_greps
if has("unix")
    let my_ctrlp_user_command = "" .
    \ "find %s '(' -type f -or -type l ')' -maxdepth 15 -not -path '*/\\.*/*' | " .
    \ ctrlp_filter_greps
endif
let g:ctrlp_user_command = ['.git/', my_ctrlp_git_command, my_ctrlp_user_command]
