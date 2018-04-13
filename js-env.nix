let
pkgs = import <nixpkgs> {};
yarn = pkgs.yarn.override { nodejs = pkgs.nodejs-8_x; };
in
  [
    yarn
    pkgs.nodejs-8_x
  ]
