if status --is-interactive
  ssh_agent_start
  tty | grep "dev/tty"
  if [ $status != 0 ]; and test -z $TMUX
    exec tmux
  end
end
