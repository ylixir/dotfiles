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

  promptInit = ''
    # name: Informative Vcs
    # author: Mariusz Smykula <mariuszs at gmail.com>

    function fish_prompt --description 'Write out the prompt'
        echo -n "╭─"
        if test -n "$IN_NIX_SHELL"
            set_color $fish_color_error
            echo -n "<nix-shell> "
        end

        set -l last_status $status

        if not set -q __fish_git_prompt_show_informative_status
            set -g __fish_git_prompt_show_informative_status 1
        end
        if not set -q __fish_git_prompt_hide_untrackedfiles
            set -g __fish_git_prompt_hide_untrackedfiles 1
        end

        if not set -q __fish_git_prompt_color_branch
            set -g __fish_git_prompt_color_branch magenta --bold
        end
        if not set -q __fish_git_prompt_showupstream
            set -g __fish_git_prompt_showupstream "informative"
        end
        if not set -q __fish_git_prompt_char_upstream_ahead
            set -g __fish_git_prompt_char_upstream_ahead "↑"
        end
        if not set -q __fish_git_prompt_char_upstream_behind
            set -g __fish_git_prompt_char_upstream_behind "↓"
        end
        if not set -q __fish_git_prompt_char_upstream_prefix
            set -g __fish_git_prompt_char_upstream_prefix ""
        end

        if not set -q __fish_git_prompt_char_stagedstate
            set -g __fish_git_prompt_char_stagedstate "●"
        end
        if not set -q __fish_git_prompt_char_dirtystate
            set -g __fish_git_prompt_char_dirtystate "✚"
        end
        if not set -q __fish_git_prompt_char_untrackedfiles
            set -g __fish_git_prompt_char_untrackedfiles "…"
        end
        if not set -q __fish_git_prompt_char_conflictedstate
            set -g __fish_git_prompt_char_conflictedstate "✖"
        end
        if not set -q __fish_git_prompt_char_cleanstate
            set -g __fish_git_prompt_char_cleanstate "✔"
        end

        if not set -q __fish_git_prompt_color_dirtystate
            set -g __fish_git_prompt_color_dirtystate blue
        end
        if not set -q __fish_git_prompt_color_stagedstate
            set -g __fish_git_prompt_color_stagedstate yellow
        end
        if not set -q __fish_git_prompt_color_invalidstate
            set -g __fish_git_prompt_color_invalidstate red
        end
        if not set -q __fish_git_prompt_color_untrackedfiles
            set -g __fish_git_prompt_color_untrackedfiles $fish_color_normal
        end
        if not set -q __fish_git_prompt_color_cleanstate
            set -g __fish_git_prompt_color_cleanstate green --bold
        end

        if not set -q __fish_prompt_normal
            set -g __fish_prompt_normal (set_color normal)
        end

        set -l color_cwd
        set -l prefix
        set -l suffix
        switch "$USER"
            case root toor
                if set -q fish_color_cwd_root
                    set color_cwd $fish_color_cwd_root
                else
                    set color_cwd $fish_color_cwd
                end
                set suffix '╰─#'
            case '*'
                set color_cwd $fish_color_cwd
                set suffix '╰─>'
        end

        # PWD
        set_color $color_cwd
        echo -n (pwd)
        set_color normal

        printf '%s ' (__fish_vcs_prompt)

        if not test $last_status -eq 0
            set_color $fish_color_error
            echo -n "[$last_status] "
            set_color normal
        end

        printf "\n%s \n" $suffix
    end
    '';
}
