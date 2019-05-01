with builtins; pkgs:
let
  buildVimPlugin = pkgs.vimUtils.buildVimPluginFrom2Nix;

  rainbow-parens = buildVimPlugin {
    pname = "rainbow-parens";
    version = "2019-04-24";
    src = pkgs.fetchFromGitHub {
      owner = "junegunn";
      repo = "rainbow_parentheses.vim";
      rev = "27e7cd73fec9d1162169180399ff8ea9fa28b003";
      sha256 = "0izbjq6qbia013vmd84rdwjmwagln948jh9labhly0asnhqyrkb8";
    };
    dependencies = [];
  };

  #vimspector isn't working, this deals with dbgp
  vdebug = buildVimPlugin {
    pname = "vdebug";
    version = "2019-04-24";
    src = pkgs.fetchFromGitHub {
      owner = "vim-vdebug";
      repo = "vdebug";
      rev = "v1.5.2";
      sha256 = "1zps2zjspqyc8qqw92xgwx4s7gz88qhqzvn0bg137k6aj6yzp60f";
    };
    dependencies = [];
  };

  vista = buildVimPlugin {
    pname = "vista";
    version = "2019-04-26";
    src = pkgs.fetchFromGitHub {
      owner = "liuchengxu";
      repo = "vista.vim";
      rev = "713342f0e040a3ab6cef9fa0ae14799622f7c265";
      sha256 = "1lld6yjs0sf5jdma2lvxc4h7l4ak1msha56brkyjp6fdwrnl60ss";
    };
    dependencies = [];
  };

  vimspector = buildVimPlugin {
    pname = "vimspector";
    version = "2019-04-24";
    src = pkgs.fetchFromGitHub {
      owner = "puremourning";
      repo = "vimspector";
      rev = "3ce01853284ddf88c8963256a756dbbfd85a5966";
      sha256 = "03f1q5yfjylzjaz1rm00s7a08kjrci6kj7qvskkwb8vl5z04xy70";
    };
    dependencies = [];
  };
in pkgs.neovim.override {
  viAlias = true;
  configure = {
    customRC = builtins.readFile ./vimrc;
    packages.myVimPackage = with pkgs.vimPlugins; {
      start = [
        LanguageClient-neovim
        deoplete-nvim
        fugitive
        fzf-vim
        fzfWrapper
        nerdtree
        nerdtree-git-plugin
        rainbow-parens
        vdebug
        vim-airline
        vim-airline-themes
        vim-nix
        vim-parinfer
        vim-slime
        vimspector
        vista
        ];
      opt = [
        elm-vim
        vim-jsonnet
        ];
    };
  };
}
