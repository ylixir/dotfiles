let
pkgs = import <nixpkgs> {};
yarn = pkgs.yarn.override { nodejs = pkgs.nodejs-8_x; };
in
  pkgs.stdenv.mkDerivation rec {
    name = "env";
    env = pkgs.buildEnv { name = name; paths = buildInputs; };
    buildInputs = [
      yarn
      pkgs.nodejs-8_x
    ];
  }
