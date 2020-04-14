let
  # https://unix.stackexchange.com/questions/183440/how-do-i-create-a-local-repository-for-nixos-nixpkgs
  pkgs = import <nixpkgs> {};
  homies = with pkgs; [
    ag
    cacert
    curl
    direnv
    fish
    fzf
    #latex
    neovim
    nix
    nodejs
    ps
    python
    python2Packages.pynvim
    python3
    python3Packages.pynvim
    thefuck
    yarn
    #home-manager
    ];
  latex = pkgs.texlive.combine {
      inherit (pkgs.texlive) scheme-small algorithms cm-super moderncv marvosym;
  };
  neovim = import ./neovim pkgs;
in
  homies
