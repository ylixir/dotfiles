#!/bin/sh
nix-env -f cli.nix -i --remove-all

#this is gross
grep -F `which fish` /etc/shells
if [ $? -ne 0 ]; then
  which fish | sudo tee -a /etc/shells
fi
chsh -s `which fish`
