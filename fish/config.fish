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

if status --is-interactive
  ssh_agent_start
  tty | grep "/dev/tty1"
  if [ $status != 0 ]; and test -z $TMUX
    exec tmux
  end
end
