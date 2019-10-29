{ pkgs, ... }:
let 
  node-pkgs = (import ./node {});
in {
  programs.home-manager.enable = true;
  home.packages = with pkgs; [
    (import ./lorri {})
    ag
    adoptopenjdk-bin
    bash #TODO open pr to fix this with home-manager
    cargo
    gnumake
    nodePackages.node2nix
    node-pkgs."@elm-tooling/elm-language-server"
    node-pkgs.intelephense # php language server
    node-pkgs.javascript-typescript-langserver
    node-pkgs.prettier
    nodejs-12_x
    ps
    solargraph # ruby language server
  ] ++ (if pkgs.system == "x86_64-darwin" then [] else [ (import neovim/gtk.nix pkgs) ]) ;

  home.file = {
    ".config/fish/functions/fzf_key_bindings.fish".source = builtins.fetchurl "https://raw.githubusercontent.com/junegunn/fzf/master/shell/key-bindings.fish";
    ".config/nvim/colors/inkpot.vim".source = neovim/inkpot.vim;
    ".config/nvim/init.vim".source = neovim/init.vim;
    ".config/nvim/coc-settings.json".source = neovim/coc-settings.json;
  };
  programs.bash = (import ./bash.nix pkgs);
  programs.direnv.enable = true;
  programs.fish = (import ./fish.nix pkgs);
  programs.fzf.enable = true;
  programs.git = (import ./git.nix pkgs);
  programs.neovim = (import ./neovim pkgs);
}
