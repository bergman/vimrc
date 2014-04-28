" vim: filetype=vim foldmethod=marker et

DiffGitCached | wincmd L | wincmd p
autocmd! BufEnter COMMIT_EDITMSG call setpos('.', [0, 1, 1, 0])
