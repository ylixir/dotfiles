#!/bin/sh

function isWsl {
  uname -a | grep -q Microsoft
}

if isWsl
then
  # https://github.com/NixOS/nix/issues/2651
  sudo mkdir -p /etc/nix
  sudo bash -c "echo 'sandbox = false' >> /etc/nix/nix.conf"
  sudo bash -c "echo 'use-sqlite-wal = false' >> /etc/nix/nix.conf"
fi


#https://nixos.org/nix/download.html
curl https://nixos.org/nix/install | sh
nix-channel --add https://github.com/rycee/home-manager/archive/master.tar.gz home-manager
nix-channel --update
