#!/bin/sh
# . ./setup-cli.sh
mkdir -p $HOME/.config/nixpkgs
cp -rf nix/* $HOME/.config/nixpkgs/
nix-env -riA userPackages -f '<nixpkgs>'
