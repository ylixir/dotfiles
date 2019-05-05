{ pkgs, ... }: {
  programs.home-manager.enable = true;
  home.packages = with pkgs; [
    (import ./lorri {})
    ag
    cargo
    fontconfig
    nerdfonts
    ps
    thefuck
  ];

  #TODO fix fonts
  fonts.fontconfig.enable = true;

#  home.file = {
#    ".config/nvim/init.vim".source = neovim/init.vim;
#  };
  programs.bash = (import ./bash.nix pkgs);
  programs.direnv.enable = true;
  programs.fish = (import ./fish.nix pkgs);
  programs.fzf.enable = true;
  programs.git = (import ./git.nix pkgs);
  programs.neovim = (import ./neovim pkgs);
}
