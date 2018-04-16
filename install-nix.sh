#!/bin/sh

#https://nixos.org/nix/download.html
which nix-env
if [ $? != 0 ]
then
  curl https://nixos.org/nix/install | sh
fi
