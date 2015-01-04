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
<<<<<<< HEAD
ln -sf `pwd`/bin ~/bin
=======
ln -sf `pwd`/terminfo ~/.terminfo
>>>>>>> 0bb49fe57fbf2722738884872ffcf6f10c77ff07
fc-cache -fv
