{
  description = "ylixir's Home Manager configurations";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    paq-nvim = { # plugin manager for neovim
      url = "github:savq/paq-nvim";
      flake = false;
    };
  };

  outputs = { self, nixpkgs, home-manager, paq-nvim }: {
    homeConfigurations = {
      "ylixir" = home-manager.lib.homeManagerConfiguration {
        configuration = {pkgs, ...}: {
          programs.home-manager.enable = true;
          home.packages = with pkgs; [
            fish
            neovim
            thefuck
            curl
            home-manager
          ];

          programs = {
            bash = (import ./bash.nix pkgs);
        
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

          # configFile is ~/.config/ and dataFile is ~/.local/share/
          xdg.configFile."nvim/init.lua".source = ./neovim/init.lua;
          xdg.dataFile."nvim/site/pack/paqs/start/paq-nvim".source = paq-nvim;

          xdg.configFile."fish/config.fish".source = ./fish/config.fish;
          xdg.configFile."fish/functions/fish_prompt.fish".source = ./fish/functions/fish_prompt.fish;
        };

        system = "x86_64-linux";
        homeDirectory = "/home/ylixir";
        username = "ylixir";
        stateVersion = "21.11";
      };
    };
  };
}
