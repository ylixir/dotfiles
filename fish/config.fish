if status --is-interactive
  ssh_agent_start
  if test -z $TMUX
    exec tmux
  end
end
