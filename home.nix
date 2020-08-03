{ pkgs, ... }:
let 
  node-pkgs = (import ./node {});
  unstable = import (fetchTarball https://nixos.org/channels/nixos-unstable/nixexprs.tar.xz) {};
in {
  programs.home-manager.enable = true;
  home.packages = with pkgs; [
    # node-pkgs."@elm-tooling/elm-language-server"
    adoptopenjdk-bin
    ag
    bash #TODO open pr to fix this with home-manager
    cargo
    elmPackages.elm-format
    elmPackages.elm-language-server
    gnumake
    ocamlformat
    niv
    node-pkgs.intelephense # php language server
    node-pkgs.javascript-typescript-langserver
    node-pkgs.prettier
    node-pkgs.typescript-tslint-plugin
    nodePackages.node2nix
    nodejs_latest
    ps
    rls
    solargraph # ruby language server
    thefuck
    unstable.lorri
  ] ++ (if pkgs.system == "x86_64-darwin" then [] else [ (import neovim/gtk.nix pkgs) ]) ;

  home.file = {
    ".config/fish/functions/fzf_key_bindings.fish".source = builtins.fetchurl "https://raw.githubusercontent.com/junegunn/fzf/master/shell/key-bindings.fish";
    ".config/nvim/init.vim".source = neovim/init.vim;
    ".config/nvim/coc-settings.json".source = neovim/coc-settings.json;
  };
  programs.bash = (import ./bash.nix pkgs);
  programs.bat.enable = true;
  programs.direnv.enable = true;
  programs.fish = (import ./fish.nix pkgs);
  programs.fzf.enable = true;
  programs.git = (import ./git.nix pkgs);
  programs.neovim = (import ./neovim pkgs);
}
