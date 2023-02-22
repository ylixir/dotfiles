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
  };

  outputs = { self, nixpkgs, home-manager, paq-nvim }:
  {
    homeConfigurations =
    let
      configuration = {pkgs, ...}:
      let
        nodeExtra = import ./node {pkgs=pkgs;};
        # leaving leaf for an example for future me
        # leaf-fish = pkgs.fetchurl {
        #   url = "https://raw.githubusercontent.com/daschw/leaf.nvim/7d4384784159906519d0b275fe760030146ecfa8/extras/fish/leaf-lighter.fish";
        #   sha256 = "1666wxd6yc02ry2b81sikhplzvlwdf4a7rmk2xrwqczihqjpkb7d";
        # };
      in
      {
        programs.home-manager.enable = true;
        home.packages = with pkgs; [
          gcc
          gnumake
          curl
          fd # wanted by telescope-nvim
          fish
          #gnvim # this is nice in WSL
          home-manager
          kitty
          lorri
          neovim-unwrapped
          nixFlakes
          nodeExtra."@angular/language-server-11.x" # pulls dependencies from node_modules (version has to match)
          nodeExtra."@fsouza/prettierd"
          nodeExtra."@volar/vue-language-server"
          nodeExtra."eslint"
          nodeExtra."prettier"
          nodeExtra."vscode-langservers-extracted"
          nodejs
          nodePackages.node2nix
          nodePackages.purescript-language-server
          nodePackages.typescript-language-server
          nodePackages.typescript # needed by the language server
          ripgrep
          rnix-lsp # nix language server
          rubyPackages.solargraph # ruby language server
          rust-analyzer
          sumneko-lua-language-server
          thefuck
          xsel
          xclip # to enable clipboard in WSL
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
              { contents = { user = { name = "Jon Allen"; email = "jon@ylixir.io"; }; };
                condition = "gitdir:/mnt/c/Users/ylixir/code/"; }
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
        xdg.configFile."kitty/kitty.conf".source = ./kitty.conf;
        xdg.configFile."kitty/rose-pine-dawn.conf".source = ./rose-pine-dawn.conf;
        xdg.configFile."kitty/macchiato.conf".source = ./macchiato.conf;
        xdg.configFile."kitty/latte.conf".source = ./latte.conf;
        xdg.dataFile."nvim/site/pack/paqs/start/paq-nvim".source = paq-nvim;

        xdg.configFile."fish/config.fish".source = ./fish/config.fish;
        xdg.configFile."fish/functions/fish_prompt.fish".source = ./fish/functions/fish_prompt.fish;
        xdg.configFile."fish/themes/Catppuccin Latte.theme".source = ./. + "/fish/themes/Catppuccin Latte.theme";
      };
    in {
      # cecaelia, perchta
      "ylixir" = home-manager.lib.homeManagerConfiguration {
        # system = "x86_64-linux";
        pkgs = nixpkgs.legacyPackages.x86_64-linux;
        modules = [
          configuration
          {
            home = {
              homeDirectory = "/home/ylixir";
              username = "ylixir";
              stateVersion = "22.05";
            };
          }
        ];
      };
      # icims m1 macbook
      "jallen" = home-manager.lib.homeManagerConfiguration {
        # system = "aarch64-darwin";
        pkgs = nixpkgs.legacyPackages.aarch64-darwin;
        modules = [
          configuration
          {
            home = {
        homeDirectory = "/Users/jallen";
        username = "jallen";
        stateVersion = "22.05";
            };
          }
        ];
      };
    };
  };
}
