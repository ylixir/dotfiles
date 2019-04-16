let
  # https://unix.stackexchange.com/questions/183440/how-do-i-create-a-local-repository-for-nixos-nixpkgs
  pkgs = import <nixpkgs> {};
  homies = with pkgs; [
    ag
    cacert
    curl
    direnv
    emacs
    fish
    latex
    lorri
    neovim
    nix
    nodejs
    ps
    tmux
    yarn
    ];
  lorri = import ./lorri;
  emacs = pkgs.emacsWithPackages(e: (with e; [
    company
    company-lsp
    counsel
    direnv
    evil
    evil-collection
    evil-magit
    general
    ivy
    lsp-mode
    lsp-ui
    magit
    php-mode
    projectile
    swiper
    use-package
    which-key
  ]));
  tmux = import ./tmux (with pkgs;
    { inherit
        makeWrapper
        symlinkJoin
        writeText
        ;
      tmux = pkgs.tmux;
    });
  latex = pkgs.texlive.combine {
      inherit (pkgs.texlive) scheme-small algorithms cm-super moderncv marvosym;
  };
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
