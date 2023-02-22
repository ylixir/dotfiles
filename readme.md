log:

updating flake `nix flake update`
updating config `home-manager switch --flake path:./`

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

to commit before configuring git you must (this didn't work):
`git commit --author="Jon Allen <jon@ylixir.io>" -m "initial readme notes"`

to switch to the home-manager config: `home-manager switch --flake path:/home/ylixir/code/dotfiles/` or `home-manager switch --flake path:./`
without home-manager installed: `nix build '.#homeConfigurations."ylixir".activationPackage' && result/activate`
note: i couldn't build nix in a git directory with no head

in order to build the nix file for node dependencies `node2nix -i node-packages.json -o node-packages.nix` from the node directory.
building with node 14 instead of node 12 requires `node2nix -14` (for eslint). current version of node2nix needs explicit package name to go higher

the wsl user _must_ be uid 1000 or we get permissions errors. to fix this you may need to delete the user form /etc/password and then `find /home -uid 1001 -exec chown 1000 {} +` and `find /nix -uid 1001 -exec chown 1000 {} +`
careful about doing that to / because it will hop into /mnt/c

notes for mac
had to create user specific config
had to activate with `nix --experimental-features "nix-command flakes" build '.#homeConfigurations."jonallen@MacBook-Pro-2".activationPackage'`
had to `nix-env --uninstall curl`
had to enable flakes by adding nixFlakes to programs and making a nix.conf enabling them
neovim and lua language server won't install for some reason

couldn't set nix.conf up during bootstrap, had to create manually. then delete and symlink to nix version after bootstrap
after bootstrap, language server installs. neovim still blocked
neovim_unwrapped works
