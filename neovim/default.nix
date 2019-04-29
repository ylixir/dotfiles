with builtins; pkgs:
let
  buildVimPlugin = pkgs.vimUtils.buildVimPluginFrom2Nix;

  #dependency of vim-lsp
  async-vim = buildVimPlugin {
    pname = "async-vim";
    version = "2019-04-26";
    src = pkgs.fetchFromGitHub {
      owner = "prabirshrestha";
      repo = "async.vim";
      rev = "f3014550d7a799097e56b094104dd2cd66cf2612";
      sha256 = "0zn25qwycynagrij5rsp1x7kbfz612gn7xda0hvm4y7qr3pal77p";
    };
    dependencies = [];
  };

  asyncomplete = buildVimPlugin {
    pname = "asyncomplete";
    version = "2.0.0";
    src = pkgs.fetchFromGitHub {
      owner = "prabirshrestha";
      repo = "asyncomplete.vim";
      rev = "v2.0.0";
      sha256 = "1zcl8nbybzxj3rfb3rgnb41xysxhxh1y7888w0d2s1qcmzigca68";
    };
    dependencies = [];
  };

  asyncomplete-lsp = buildVimPlugin {
    pname = "asyncomplete-lsp";
    version = "2.0.0";
    src = pkgs.fetchFromGitHub {
      owner = "prabirshrestha";
      repo = "asyncomplete-lsp.vim";
      rev = "05389e93a81aa4262355452ebdac66ae2a1939fb";
      sha256 = "0mnsp54p0i6x7w1zlmwhpi2hhwb787z1p69pr2lmz7qja2iqv36y";
    };
    dependencies = [];
  };


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

  vim-lsp = buildVimPlugin {
    pname = "vim-lsp";
    version = "2019-04-26";
    src = pkgs.fetchFromGitHub {
      owner = "prabirshrestha";
      repo = "vim-lsp";
      rev = "fe5057641cadba27caa26df74efa896e4255308e";
      sha256 = "1p27fcvgz5g1apn31f4fl0h37sf6sl2kd4wskx2jjix66ny25k0r";
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
      start =
      [ async-vim
        asyncomplete
        asyncomplete-lsp
        fugitive
        fzf-vim
        fzfWrapper
        nerdtree
        nerdtree-git-plugin
        rainbow-parens
        vdebug
        vim-airline
        vim-airline-themes
        vim-lsp
        vim-nix
        vim-parinfer
        vim-slime
        vimspector
        vista
        ];
        opt =
        [ elm-vim
          vim-jsonnet
          ];
    };
  };
}
