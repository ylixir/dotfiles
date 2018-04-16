with (import <nixpkgs> {});
{
  packageOverrides = pkgs: with pkgs; {
    userPackages = buildEnv {
#      inherit ((import <nixpkgs/nixos> {}).config.system.path)
#      pathsToLink ignoreCollisions postBuild;
      extraOutputsToInstall = [ "man" ];
      name = "user-packages";
      paths = [ (import ./gui.nix) ];
    };
    fonts.fonts = [ iosevka ];
  };
}
