let
  # https://unix.stackexchange.com/questions/183440/how-do-i-create-a-local-repository-for-nixos-nixpkgs
  pkgs = import <nixpkgs> {};
  homies = with pkgs; [
    fish
    nix
    tmux
    curl
    cacert
    neovim
    ps
    direnv
    ];
  tmux = import ./tmux (with pkgs;
    { inherit
        makeWrapper
        symlinkJoin
        writeText
        ;
      tmux = pkgs.tmux;
    });
  neovim = pkgs.neovim.override {
    viAlias = true;
    configure = {
      customRC = ''
        autocmd BufRead,BufNewFile *.elm set filetype=elm
        autocmd FileType elm :packadd elm-vim
      '';
      packages.myVimPackage = with pkgs.vimPlugins; {
        start = [ ale ];
        opt = [ elm-vim ];
      };
  };
  };
in
  homies
