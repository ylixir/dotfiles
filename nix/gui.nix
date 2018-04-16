let
  cli = import ./cli.nix;
  pkgs = import <nixpkgs> {};
in
  with pkgs;
  cli ++ [
    pkgs.st
    fontconfig
    iosevka
  ]
