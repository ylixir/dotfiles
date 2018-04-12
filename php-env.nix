let
pkgs = import <nixpkgs> {};
in
  pkgs.stdenv.mkDerivation rec {
    name = "env";
    env = pkgs.buildEnv { name = name; paths = buildInputs; };
    buildInputs = [
      pkgs.php
      pkgs.php72Packages.composer
    ];
  }
