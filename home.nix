{ pkgs, ... }: {
  programs.home-manager.enable = true;
  home.packages = with pkgs; [
    (import ./lorri {})
    ag
    bash #TODO open pr to fix this with home-manager
    cargo
    clang
    nodejs
    ps
    thefuck
  ] ++ (if pkgs.system == "x86_64-darwin" then [] else [ pkgs.konsole ]) ;

  home.file = {
    ".config/nvim/colors/inkpot.vim".source = neovim/inkpot.vim;
  };
  programs.bash = (import ./bash.nix pkgs);
  programs.direnv.enable = true;
  programs.fish = (import ./fish.nix pkgs);
  programs.fzf.enable = true;
  programs.git = (import ./git.nix pkgs);
  programs.neovim = (import ./neovim pkgs);
}
