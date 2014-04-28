" vim: filetype=vim foldmethod=marker et

setlocal foldmethod=indent shiftwidth=2 expandtab nosmartindent
" console.log word under cursor
nnoremap <leader>m yiwoconsole.log("<esc>pa:", <esc>pa)<esc>
" console.log selected text
vnoremap <leader>m yoconsole.log("<esc>pa:", <esc>pa)<esc>
