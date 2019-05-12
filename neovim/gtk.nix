pkgs: with pkgs;

rustPlatform.buildRustPackage rec {
  name = "neovim-gtk-unstable-${version}";
  version = "0.2.0";

  src = fetchFromGitHub {
    owner = "daa84";
    repo = "neovim-gtk";
    rev = "v0.2.0";
    sha256 = "0ngwav37bjqjjgd9ksv4midmrf0r4p2if8wk75fdinbg75yr7qwr";
  };

  cargoSha256 = "06cgb3mspq7sz8vr45vcmd4m4dawdy1g72zrcma2sfp8csism7kj";

  buildInputs = [ gtk3 gnome3.vte wrapGAppsHook ];

  meta = with stdenv.lib; {
    description = "GTK+ UI for Neovim";
    homepage = https://github.com/daa84/neovim-gtk;
    license = with licenses; [ gpl3 ];
    # maintainers = [ maintainers.somebodyplease ];
    #platforms = [ platforms.linux ];
  };
}
