let
  pkgs = import <nixpkgs> {};
in
  with pkgs; [
    cacert
    curl
    nix
    ]
