# code for darwin
set -l cleanpath
# make sure nix paths are in the front
for v in $PATH
  if echo $v | grep [./]nix > /dev/null
    set cleanpath $cleanpath $v
  end
end
# put the non nix paths on the end and remove duplicates
for v in $PATH
  if ! contains -- $v $cleanpath
    set cleanpath $cleanpath $v
  end
end

set -x PATH $cleanpath
set -x EDITOR nvim
set -x VISUAL nvim

if [ -n "$EMACS" ]
  set -x TERM eterm-color
else
  set -x TERM xterm-24bit
end

function isWsl
  uname -a | grep -q "Microsoft"
end

#don't obliterate logging/kernel/etc output on first tty
function isFirstTty
  tty | grep -q "/dev/tty1"
end

if status --is-interactive
  ssh_agent_start
end

direnv hook fish | source
