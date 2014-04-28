" vim: filetype=vim foldmethod=marker et

" make Python follow PEP8 for whitespace (http://www.python.org/dev/peps/pep-0008/)
setlocal softtabstop=4 tabstop=4 shiftwidth=4 expandtab foldmethod=indent foldlevelstart=0
" print word under cursor
nnoremap <leader>m yiwoprint "<esc>pa: %s" % <esc>pa<esc>
" print selected text
vnoremap <leader>m yoprint "<esc>pa: %s" % <esc>pa<esc>
