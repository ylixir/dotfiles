#!/bin/sh
mkdir -p ~/.config
mkdir -p ~/.config/fish
ln -sf `pwd`/vim ~/.vim
ln -sf `pwd`/gitconfig ~/.gitconfig
ln -sf `pwd`/vimrc ~/.vimrc
ln -sf `pwd`/gvimrc ~/.gvimrc
ln -sf `pwd`/xinitrc ~/.xinitrc
ln -sf `pwd`/profile ~/.profile
ln -sf `pwd`/herbstluftwm ~/.config/
ln -sf `pwd`/fonts ~/.fonts
ln -sf `pwd`/bin ~/bin
ln -sf `pwd`/terminfo ~/.terminfo
ln -sf `pwd`/tmux.conf ~/.tmux.conf
ln -sf `pwd`/llpp.conf ~/.config/llpp.conf
ln -sf `pwd`/config.fish ~/.config/fish/config.fish
fc-cache -f
