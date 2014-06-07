" vim: filetype=vim foldmethod=marker et

setlocal foldmethod=indent shiftwidth=2 expandtab nosmartindent

" coffeescript custom stuff, mark thin and fat arrows differently
highlight coffeeThinArrow ctermbg=Blue ctermfg=Black
syntax match coffeeThinArrow /->/
highlight coffeeFatArrow ctermbg=Brown ctermfg=Black
syntax match coffeeFatArrow /=>/
highlight coffeeConsole ctermfg=Magenta
syntax match coffeeConsole /\<console\>/
syntax match coffeeSpaceError /^\t\+/
