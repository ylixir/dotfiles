#!/bin/sh
mkdir -p ~/.vim/colors
mkdir -p ~/.config
ln -sf `pwd`/vim/colors/inkpot.vim ~/.vim/colors/
ln -sf `pwd`/gitconfig ~/.gitconfig
ln -sf `pwd`/vimrc ~/.vimrc
ln -sf `pwd`/gvimrc ~/.gvimrc
ln -sf `pwd`/xinitrc ~/.xinitrc
ln -sf `pwd`/herbstluftwm ~/.config/
ln -sf `pwd`/fonts ~/.fonts
ln -sf `pwd`/bin ~/bin
fc-cache -fv
