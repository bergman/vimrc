#!/bin/sh

mkdir -p .vim/bundle
cd .vim/bundle

git clone https://github.com/altercation/vim-colors-solarized.git
git clone https://github.com/godlygeek/tabular.git
git clone https://github.com/kien/ctrlp.vim.git
git clone https://github.com/majutsushi/tagbar.git
git clone https://github.com/mileszs/ack.vim.git
git clone https://github.com/nvie/vim-flake8.git
git clone https://github.com/scrooloose/syntastic.git
git clone https://github.com/tpope/vim-commentary.git
git clone https://github.com/tpope/vim-fugitive.git
git clone https://github.com/tpope/vim-repeat.git
git clone https://github.com/tpope/vim-surround.git
git clone https://github.com/tpope/vim-unimpaired.git
git clone https://github.com/xolox/vim-easytags.git

cd -
