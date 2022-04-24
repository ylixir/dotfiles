log:

from windows for wsl2:
download https://github.com/nix-community/NixOS-WSL/releases/latest/download/nixos-wsl-installer.tar.gz
then `wsl --import NixOS .\NixOS\ Downloads/nixos-wsl-installer.tar.gz --version 2`
then `wsl -d NixOS`
note that this didn't work at first (couldn't mount something), after booting ubuntu so i could see the dmesg it seemed like it started working?

now `sudo nano /etc/nixos/configuration.nix` probably want to add
```nix
environment.systemPackages = with pkgs; [
  curl
  git
  home-manager
  neovim # or your editor of choice
];
```

at least until we can get some modules rolling with some better defaults
i also added in a specific user

now to set up ssh key:
`bash <(curl https://raw.githubusercontent.com/ylixir/dotfiles/nix/make-ssh-key.sh)`
then `cat ~/.ssh/id_rsa.pub | clip.exe`

