#!/bin/sh
nix-env -f cli.nix -i --remove-all


#setup fish. note that this is very bash centric.
#mostly bash is the default, and our game is just
#to be able to use fish, not make it the "default"

# make sure that we fire bashrc, even on a login
if [ -e $HOME/.bash_profile ]; then
  profile="$HOME/.bash_profile"
elif [ -e $HOME/.bash_login ]; then
  profile="$HOME/.bash_login"
else
  profile="$HOME/.profile"
fi
grep -F bashrc $profile
if [ $? -ne 0 ]; then
  printf ". %s\n" $HOME/.bashrc >> $profile
fi

# now make sure bash starts fish when running from login mode
grep -F fish $HOME/.bashrc
if [ $? -ne 0 ]; then
  printf "if [ -z \$IN_NIX_SHELL ]; then\n" >> $HOME/.bashrc
  printf "  exec %s\n" `which fish` >> $HOME/.bashrc
  printf "fi\n" `which fish` >> $HOME/.bashrc
fi
