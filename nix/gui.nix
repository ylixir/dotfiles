let
  cli = import ./cli.nix;
  pkgs = import <nixpkgs> {};
in
  with pkgs;
  cli ++ [
    st
    fontconfig
    iosevka
  ]
