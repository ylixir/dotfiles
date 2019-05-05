pkgs:{
  enable = true;
  initExtra = ''
    #home-manager doesn't work without this
    export NIX_PATH=$HOME/.nix-defexpr/channels''${NIX_PATH:+:}$NIX_PATH

    #ls default dir color is unreadable on black background
    LS_COLORS=$LS_COLORS:'di=0;35:' ; export LS_COLORS

    if [ -z $IN_NIX_SHELL ] && [ -z $PIPENV_ACTIVE ]
    then
      if [ -f $HOME/.nix-profile/etc/profile.d/nix.sh ]
      then
        export PATH=$HOME/.yarn/bin:$PATH
        . $HOME/.nix-profile/etc/profile.d/nix.sh

        #TODO make sure os x still needs this
        # which launchctl &> /dev/null && launchctl setenv PATH $PATH
      fi
      exec `which fish`
    fi
    '';
}
