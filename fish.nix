pkgs: {
  enable = true;

  interactiveShellInit = ''
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
    setenv SSH_ENV $HOME/.ssh/environment

    function start_agent
      echo "Initializing new SSH agent ..."
      ssh-agent -c | sed 's/^echo/#echo/' > $SSH_ENV
      echo "succeeded"
      chmod 600 $SSH_ENV 
      . $SSH_ENV > /dev/null
      ssh-add
    end

    function test_identities
      ssh-add -l | grep "The agent has no identities" > /dev/null
      if [ $status -eq 0 ]
        ssh-add
        if [ $status -eq 2 ]
          start_agent
        end
      end
    end

    if [ -n "$SSH_AGENT_PID" ] 
      ps -ef | grep $SSH_AGENT_PID | grep ssh-agent > /dev/null
      if [ $status -eq 0 ]
        test_identities
      end  
    else
      if [ -f $SSH_ENV ]
        . $SSH_ENV > /dev/null
      end  

      ps -ef \
      | grep $SSH_AGENT_PID \
      | grep -v grep \
      | grep ssh-agent \
      > /dev/null

      if [ $status -eq 0 ]
        test_identities
      else 
        start_agent
      end  
    end

    function fish_user_key_bindings
      fzf_key_bindings
    end

    function fuck -d "Correct your previous console command"
      set -l fucked_up_command $history[1]
      env TF_SHELL=fish TF_ALIAS=fuck PYTHONIOENCODING=utf-8 thefuck $fucked_up_command | read -l unfucked_command
      if [ "$unfucked_command" != "" ]
        eval $unfucked_command
        builtin history delete --exact --case-sensitive -- $fucked_up_command
        builtin history merge ^ /dev/null
      end
    end
    '';

  promptInit = builtins.readFile (builtins.fetchurl "https://raw.githubusercontent.com/oh-my-fish/theme-coffeeandcode/master/fish_prompt.fish");
}
