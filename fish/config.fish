# sometimes windows works a little differently
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
