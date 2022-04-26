{ pkgs, ... }:
let 
  node-pkgs = (import ./node {});
  osx = if pkgs.system == "x86_64-darwin" then true else false;
  stable = if osx
	then import (fetchTarball https://nixos.org/channels/nixpkgs-21.05-darwin/nixexprs.tar.xz) {}
	else import (fetchTarball https://nixos.org/channels/nixos-21.05/nixexprs.tar.xz) {};
  unstable = import (fetchTarball https://nixos.org/channels/nixpkgs-unstable/nixexprs.tar.xz) {};
in {
  programs.home-manager.enable = true;
  home.packages = with stable; [
    # node-pkgs."@elm-tooling/elm-language-server"
    adoptopenjdk-bin
    ag
    bash #TODO open pr to fix this with home-manager
    cargo
    elmPackages.elm-format
    elmPackages.elm-language-server
    gcc
    gnumake
    ocamlformat
    niv
    node-pkgs.javascript-typescript-langserver
    node-pkgs.prettier
    node-pkgs.typescript-tslint-plugin
    nodePackages.node2nix
    nodejs_latest
    ps
    rls
    solargraph # ruby language server
    thefuck
    lorri
    unstable.nix_2_4
  ] ++ (if osx then [
  ] else [
    neovim-qt
    #(import neovim/gtk.nix pkgs)
  ]) ;

  xdg.configFile."fish/functions/fzf_key_bindings.fish".source = builtins.fetchurl "https://raw.githubusercontent.com/junegunn/fzf/master/shell/key-bindings.fish";
  xdg.configFile."nvim/init.vim".source = neovim/init.vim;
  xdg.configFile."nvim/filetype.vim".source = neovim/filetype.vim;
  xdg.configFile."nvim/coc-settings.json".source = neovim/coc-settings.json;

  programs.bash = (import ./bash.nix stable);
  programs.bat.enable = true;
  programs.direnv.enable = true;
  programs.fish = (import ./fish.nix unstable);
  programs.fzf.enable = true;
  programs.git = (import ./git.nix stable);
  programs.neovim = (import ./neovim stable);
  manual.manpages.enable = !osx;
}
