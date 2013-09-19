#!/bin/sh

mkdir -p bundle

(cd bundle; git clone https://github.com/bergman/vim-tomorrow-theme.git)
(cd bundle; git clone https://github.com/godlygeek/tabular.git)
(cd bundle; git clone https://github.com/kien/ctrlp.vim.git)
#(cd bundle; git clone https://github.com/majutsushi/tagbar.git)
(cd bundle; git clone https://github.com/mileszs/ack.vim.git)
(cd bundle; git clone https://github.com/scrooloose/syntastic.git)
#(cd bundle; git clone https://github.com/tpope/vim-commentary.git)
(cd bundle; git clone https://github.com/tpope/vim-fugitive.git)
(cd bundle; git clone https://github.com/tpope/vim-markdown.git)
#(cd bundle; git clone https://github.com/tpope/vim-repeat.git)
(cd bundle; git clone https://github.com/tpope/vim-surround.git)
#(cd bundle; git clone https://github.com/xolox/vim-misc.git) # needed for easytags
#(cd bundle; git clone https://github.com/xolox/vim-easytags.git)
(cd bundle; git clone https://github.com/derekwyatt/vim-scala.git)
(cd bundle; git clone https://github.com/bergman/vim-coffee-script.git)
(cd bundle; git clone https://github.com/Lokaltog/vim-powerline.git)
#(cd bundle; git clone https://github.com/kien/rainbow_parentheses.vim.git)
(cd bundle; git clone https://github.com/nelstrom/vim-visual-star-search.git)
(cd bundle; git clone https://github.com/rking/ag.vim)
#(cd bundle; git clone https://github.com/davidoc/taskpaper.vim.git)

# python
(cd bundle; git clone https://github.com/nvie/vim-flake8.git)
(cd bundle; git clone https://github.com/hynek/vim-python-pep8-indent.git)
