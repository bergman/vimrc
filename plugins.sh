#!/bin/sh

bundle=bundle
mkdir -p $bundle

plugins=(
	https://github.com/bergman/vim-tomorrow-theme.git
	https://github.com/godlygeek/tabular.git
	https://github.com/kien/ctrlp.vim.git
	https://github.com/majutsushi/tagbar.git
	https://github.com/mileszs/ack.vim.git
	https://github.com/scrooloose/syntastic.git
	https://github.com/tpope/vim-fugitive.git
	https://github.com/tpope/vim-markdown.git
	https://github.com/tpope/vim-surround.git
	https://github.com/derekwyatt/vim-scala.git
	https://github.com/bergman/vim-coffee-script.git
	https://github.com/bling/vim-airline.git
	https://github.com/nelstrom/vim-visual-star-search.git
	https://github.com/rking/ag.vim
	https://github.com/nvie/vim-flake8.git
	https://github.com/hynek/vim-python-pep8-indent.git
)

disabled=(
	https://github.com/davidoc/taskpaper.vim.git
	https://github.com/tpope/vim-commentary.git
	https://github.com/tpope/vim-repeat.git
	https://github.com/xolox/vim-misc.git
	https://github.com/xolox/vim-easytags.git
	https://github.com/Lokaltog/vim-powerline.git
	https://github.com/kien/rainbow_parentheses.vim.git
)

for plugin in ${plugins[@]}; do
	(cd $bundle && git clone "$plugin")
done

for d in $bundle/*; do
	(cd $d && git pull --rebase)
done
