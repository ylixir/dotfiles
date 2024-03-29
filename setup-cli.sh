#!/usr/bin/env bash

# if [ -f $HOME/.nix-profile/etc/profile.d/nix.sh ]
# then
#   . $HOME/.nix-profile/etc/profile.d/nix.sh
# fi
# 
# if [ -f $HOME/.nix-profile/etc/profile.d/hm-session-vars.sh ]
# then
#   . $HOME/.nix-profile/etc/profile.d/hm-session-vars.sh
# fi
# 
# if ! which nix-env
# then
#   if . ./install-nix.sh
#   then
#     #need the environment setup
#     . $HOME/.nix-profile/etc/profile.d/nix.sh
#   else
#     echo "Could not install nix"
#     exit 1
#   fi
# fi
# 
# clean out any unnecessary packages
nix-env -f bones.nix -i --remove-all

mkdir -p ~/.config/nixpkgs
ln -sf `pwd`/home.nix ~/.config/nixpkgs/home.nix
export NIX_PATH=$HOME/.nix-defexpr/channels${NIX_PATH:+:}$NIX_PATH
# homemanager is somehow conflicting with nix
nix-env --set-flag priority 4 nix-2.4
nix-shell '<home-manager>' -A install
. $HOME/.nix-profile/etc/profile.d/hm-session-vars.sh
echo switching!!!!!!!!
home-manager switch --show-trace

#mostly bash is the default, and our game is just
#to be able to use fish, not make it the "default"
# echo $SHELL | grep bash
# if [ $? != 0 ]
# then
#   chsh -s `which bash`
#   if [ $? != 0 ]
#   then
#     chsh -s /bin/bash
#   fi
# fi
# 
# mkdir -p $HOME/.local/share/fonts
# cp -R fonts/* $HOME/.local/share/fonts/
# fc-cache -f -v $HOME/.local/share/fonts/
# 
