{
  description = "ylixir's Home Manager configurations";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # nixpkgs.url = "github:nixos/nixpkgs/release-21.11";
    # home-manager = {
    #   url = "github:nix-community/home-manager/release-21.11";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };
    paq-nvim = { # plugin manager for neovim
      url = "github:savq/paq-nvim";
      flake = false;
    };
    # nodeExtra = {
    #   url = "./node/";
    #   flake = false;
    # };
  };

  outputs = { self, nixpkgs, home-manager, paq-nvim }:
  {
    homeConfigurations =
    let
      configuration = {pkgs, ...}:
      let
        nodeExtra = import ./node {pkgs=pkgs;};
      in
      {
        programs.home-manager.enable = true;
        home.packages = with pkgs; [
          gcc
          gnumake
          curl
          fd # wanted by telescope-nvim
          fish
          home-manager
          lorri
          neovim-unwrapped
          nodeExtra."@angular/language-server-11.x" # pulls dependencies from node_modules (version has to match)
          nodejs
          nodePackages.node2nix
          nodePackages.typescript-language-server
          nodePackages.typescript # needed by the language server
          nodePackages.vue-language-server
          ripgrep
          rnix-lsp # nix language server
          rubyPackages.solargraph # ruby language server
          sumneko-lua-language-server
          thefuck
          nixFlakes
        ];

        programs = {
          bash = (import ./bash.nix pkgs);
      
          direnv = {
            enable = true;
          };

          fzf = {
            enable = true;
          };

          git = {
            enable = true;

            includes = [
              { contents = { user = { name = "Jon Allen"; email = "jon@ylixir.io"; }; };
                condition = "gitdir:~/code/"; }
              { contents = { user = { name = "Jon Allen"; email = "jon.allen@icims.com"; }; };
                condition = "gitdir:~/altru/"; }
            ];

            # right now we have no git user config out of these directories
            # we can uncomment these lines if we change our mind
            # userName = "Jon Allen";
            # userEmail = "jon@ylixir.io";
          };
        };

        xdg.configFile."nix/nix.conf".source = ./nix.conf;

        # configFile is ~/.config/ and dataFile is ~/.local/share/
        xdg.configFile."nvim/init.lua".source = ./neovim/init.lua;
        xdg.dataFile."nvim/site/pack/paqs/start/paq-nvim".source = paq-nvim;

        xdg.configFile."fish/config.fish".source = ./fish/config.fish;
        xdg.configFile."fish/functions/fish_prompt.fish".source = ./fish/functions/fish_prompt.fish;
      };
    in {
      # cecaelia
      "ylixir" = home-manager.lib.homeManagerConfiguration {
	configuration = configuration;
        system = "x86_64-linux";
        homeDirectory = "/home/ylixir";
        username = "ylixir";
        stateVersion = "21.11";
      };
      # altru macbook
      "jonallen" = home-manager.lib.homeManagerConfiguration {
	configuration = configuration;
        system = "x86_64-darwin";
        homeDirectory = "/Users/jonallen";
        username = "jonallen";
        stateVersion = "21.11";
      };
    };
  };
}
