with builtins; pkgs:
let
  buildVimPlugin = pkgs.vimUtils.buildVimPluginFrom2Nix;
  rainbow-parens = buildVimPlugin {
    pname = "rainbow-parend";
    version = "2019-04-24";
    src = pkgs.fetchFromGitHub {
      owner = "junegunn";
      repo = "rainbow_parentheses.vim";
      rev = "27e7cd73fec9d1162169180399ff8ea9fa28b003";
      sha256 = "0izbjq6qbia013vmd84rdwjmwagln948jh9labhly0asnhqyrkb8";
    };
    dependencies = [];
  };
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
      [ ale
	fzf-vim
	fzfWrapper
	nerdtree
	nerdtree-git-plugin
	vdebug
	vim-nix
        rainbow-parens
        supertab
        vim-parinfer
        vimspector
        ];
      opt = [ elm-vim ];
    };
  };
}
