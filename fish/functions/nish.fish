function nish
  set -x IN_NIX_SHELL yes
  if test -e shell.nix
    nix run -f shell.nix -c fish
  else
    nix run -c fish
  end
  set -e IN_NIX_SHELL
end
