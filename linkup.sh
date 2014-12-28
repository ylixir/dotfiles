#!/bin/sh
mkdir -p ~/.vim/colors
mkdir -p ~/.config
ln -sf `pwd`/vim/colors/inkpot.vim ~/.vim/colors/
ln -sf `pwd`/gitconfig ~/.gitconfig
ln -sf `pwd`/vimrc ~/.vimrc
ln -sf `pwd`/gvimrc ~/.gvimrc
ln -sf `pwd`/herbstluftwm ~/.config/
