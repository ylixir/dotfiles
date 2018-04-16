let
pkgs = import <nixpkgs> {};
in
  [
    pkgs.php
    pkgs.php72Packages.composer
  ]
