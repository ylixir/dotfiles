{ pkgs, ... }: {
  programs.home-manager.enable = true;
  home.packages = with pkgs; [
    (import ./lorri {})
    ag
    asciinema
    bash #TODO open pr to fix this with home-manager
    cargo
    clang
    nodejs
    ps
    thefuck
  ] ++ (if pkgs.system == "x86_64-darwin" then [] else [ pkgs.konsole ]) ;

  home.file = {
    ".config/fish/functions/fzf_key_bindings.fish".source = builtins.fetchurl "https://raw.githubusercontent.com/junegunn/fzf/master/shell/key-bindings.fish";
    ".config/nvim/colors/inkpot.vim".source = neovim/inkpot.vim;
    ".config/nvim/init.vim".source = neovim/init.vim;
  };
  programs.bash = (import ./bash.nix pkgs);
  programs.direnv.enable = true;
  programs.fish = (import ./fish.nix pkgs);
  programs.fzf.enable = true;
  programs.git = (import ./git.nix pkgs);
  programs.neovim = (import ./neovim pkgs);
}
