# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:
let
  julia-mono-custom = ({ lib, fetchzip } :
    let
      version = "0.022";
    in fetchzip {
      name = "JuliaMono-${version}";
      url = "https://github.com/cormullion/juliamono/releases/download/v${version}/JuliaMono.zip";
      sha256 = "0h4ahvfh3brw209nggnc5gmyfnxbfw9n6kgnp2ic9niqgzm57igw";

      postFetch = ''
        mkdir -p $out/share/fonts/truetype
        unzip -j $downloadedFile \*.ttf -d $out/share/fonts/truetype
      '';

      meta = {
        description = "A monospaced font for scientific and technical computing";
        maintainers = with lib.maintainers; [ suhr ];
        platforms = with lib.platforms; all;
        homepage = "https://juliamono.netlify.app/";
        license = lib.licenses.ofl;
      };
    });
  unstable = import (fetchTarball https://nixos.org/channels/nixos-unstable/nixexprs.tar.xz) {
    config.allowUnfree = true;
    config.firefox.enablePlasmaBrowserIntegration = true;
    config.i18n.defaultLocale = "fr_FR.UTF-8";
    overlays = [(self: super: {julia-mono-custom = julia-mono-custom;})];
  };
in
{
  imports =
    [ # Include the results of the hardware scan.
      /etc/nixos/hardware-configuration.nix
    ];

  # Use the systemd-boot EFI boot loader.
  boot.initrd.luks.devices = {
    nixos = {
      device = "/dev/disk/by-uuid/e8814488-df90-4567-a4cc-cba2d6898d6d";
      preLVM = true;
      allowDiscards = true;
    };
  };
  boot.kernelPackages = unstable.linuxPackages_5_9;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.grub.device = "nodev";
  boot.loader.grub.efiSupport = true;
  boot.loader.grub.enable = true;
  boot.loader.grub.useOSProber = true;
  boot.loader.grub.version = 2;
  boot.loader.systemd-boot.enable = true;

  console.useXkbConfig = true;

  networking.hostName = "cecaelia"; # Define your hostname.
  networking.interfaces.wlo1.useDHCP = true;
  networking.useDHCP = false; # deprecated
  # network manager and wpa supplicant are mutually exclusive
  networking.networkmanager.enable = true;
  networking.wireless.enable = false;  # Enables wireless support via wpa_supplicant.
  # generate pskRaw hashes with wpa_passphrase
  networking.wireless.networks = {
    TP-Link_B2DE = {
      pskRaw = "5cde700fd7307f7949e00af49c5fa4a973a2de69406cd1c4d10a80404f5870ac";
    };
  };

  nix.allowedUsers = [ "ylixir" ];
  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.firefox.enablePlasmaBrowserIntegration = true;

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  i18n.defaultLocale = "fr_FR.UTF-8";
  nixpkgs.config.i18n.defaultLocale = "fr_FR.UTF-8";
  # console = {
  #   font = "Lat2-Terminus16";
  #   keyMap = "us";
  # };

  # Set your time zone.
  time.timeZone = "America/New_York";

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    binutils
    clang
    exfat
    gcc
    git
    gnumake
    google-chrome
    hexchat
    home-manager
    minecraft
    ntfs3g
    slack
    spotify
    steam
    unstable.firefox-devedition-bin
    unstable.thunderbird-bin
    vim
    xclip
    xournalpp
    zoom-us
  ];
  environment.variables = {
    MOZ_USE_XINPUT2 = "1";
    MOZ_LEGACY_PROFILES = "1";
  };

  fonts.fonts = with pkgs; [
    julia-mono-custom
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  #   pinentryFlavor = "gnome3";
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable sound.
  sound.enable = true;
  hardware.bluetooth.enable = true;
  hardware.pulseaudio.enable = true;
  hardware.opengl.driSupport32Bit = true;
  hardware.opengl.extraPackages32 = with pkgs.pkgsi686Linux; [ libva ];
  hardware.pulseaudio.support32Bit = true;

  # Enable the X11 windowing system.
  # services.tlp.enable = true;
  services.xserver.enable = true;
  services.xserver.layout = "us";
  services.xserver.xkbOptions = "caps:ctrl_modifier";
  # services.xserver.xkbOptions = "eurosign:e";

  # Enable touchpad support.
  services.xserver.libinput = {
    clickMethod = "clickfinger";
    enable = true;
    naturalScrolling = true;
    tapping = false;
  };

  # Enable the KDE Desktop Environment.
  services.xserver.displayManager.sddm = {
    enable = true;
    autoLogin.enable = true;
    autoLogin.relogin = true;
    autoLogin.user = "ylixir";
  };
  services.xserver.desktopManager.plasma5.enable = true;
  # services.xserver.videoDrivers = [ "amdgpu" ];

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.mutableUsers = false;
  users.users.root = {
    hashedPassword = "*";
  };
  # generate password with `mkpasswd -m sha-512`
  users.users.ylixir = {
    isNormalUser = true;
    extraGroups = [ "wheel" "audio" ];
    hashedPassword = "$6$WjwE2PYaCenVIvmn$cwlslsZhBysgIb1ieN/JrGbsxgSGO.5XHQEYi1GxXsNH.1CUIdU6bCobdJ/M33D2tEteTuTdNbWsPUciXMwUJ/";
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "20.03"; # Did you read the comment?
}

