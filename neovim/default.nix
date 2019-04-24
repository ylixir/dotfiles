with builtins; pkgs:
let
  buildVimPlugin = pkgs.vimUtils.buildVimPluginFrom2Nix;
  vimspector = buildVimPlugin {
    name = "vimspector";
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
        vimspector
        ];
      opt = [ elm-vim ];
    };
  };
}
