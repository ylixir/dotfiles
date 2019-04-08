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

function isWsl
  uname -a | grep -q "Microsoft"
end

#don't obliterate logging/kernel/etc output on first tty
function isFirstTty
  tty | grep -q "/dev/tty1"
end

if status --is-interactive
  ssh_agent_start
  isWsl || not isFirstTty
  if [ 0 -eq "$status" ] && [ -z $TMUX ]
    exec tmux
  end
end

direnv hook fish | source
