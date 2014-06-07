" vim: filetype=vim foldmethod=marker et

" make Python follow PEP8 for whitespace (http://www.python.org/dev/peps/pep-0008/)
setlocal softtabstop=4 tabstop=4 shiftwidth=4 expandtab

"folding
setlocal foldmethod=indent foldlevelstart=0

" print word under cursor
nnoremap <leader>m yiwoprint "<esc>pa: %s" % <esc>pa<esc>
" print selected text
vnoremap <leader>m yoprint "<esc>pa: %s" % <esc>pa<esc>

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
vnoremap <leader>r y :call VimuxSlime(@")<CR>
