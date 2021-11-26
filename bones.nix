let
  pkgs = import <nixpkgs> {};
  unstable = import (fetchTarball https://nixos.org/channels/nixos-unstable/nixexprs.tar.xz) {};
in
  with pkgs; [
    cacert
    curl
    unstable.nix_2_4
    ]
