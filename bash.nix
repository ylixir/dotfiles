pkgs:{
  enable = true;
  shellOptions = [
    # Append to history file rather than replacing it.
    "histappend"
    
    # check the window size after each command and, if
    # necessary, update the values of LINES and COLUMNS.
    "checkwinsize"
    
    # Extended globbing.
    "extglob"
    # TODO fix this to work on a mac
    #"globstar"
    
    # Warn if closing shell with running jobs.
    # TODO fix this to work on a mac
    #"checkjobs"
    ];
  profileExtra = ''
    #home-manager doesn't work without this
    export NIX_PATH=$HOME/.nix-defexpr/channels''${NIX_PATH:+:}$NIX_PATH
    . $HOME/.nix-profile/etc/profile.d/nix.sh
    '';
  initExtra = ''
    #ls default dir color is unreadable on black background
    LS_COLORS=$LS_COLORS:'di=0;35:' ; export LS_COLORS

    if [ -z $FISHLVL ]
    then
      export FISHLVL=1
      exec `which fish`
    fi
    '';
}
