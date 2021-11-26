let
  pkgs = import <nixpkgs> {};
  stable = import (fetchTarball https://nixos.org/channels/nixos-21.05/nixexprs.tar.xz) {};
  unstable = import (fetchTarball https://nixos.org/channels/nixos-unstable/nixexprs.tar.xz) {};
in
  with stable; [
    cacert
    curl
    unstable.nix_2_4
    ]
