{
  description = "ylixir's Home Manager configurations";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager }: {
    homeConfigurations = {
      "ylixir" = home-manager.lib.homeManagerConfiguration {
        configuration = {pkgs, ...}: {
          programs.home-manager.enable = true;
          home.packages = with pkgs; [
	    neovim
            curl
	    git
	    home-manager
	  ];

	  programs.git = {
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

        system = "x86_64-linux";
        homeDirectory = "/home/ylixir";
        username = "ylixir";
        stateVersion = "21.11";
      };
    };
  };
}
