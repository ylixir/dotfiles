pkgs:{
  enable = true;
  viAlias = true;
  vimAlias = true;
  configure = {
    customRC = builtins.readFile ./init.vim;
    packages.myVimPackage = with pkgs.vimPlugins; {
      # loaded on launch
      start = [ ];
      # manually loadable by calling `:packadd $plugin-name`
      opt = [ ];
    };
  };
}
