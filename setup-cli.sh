#!/bin/sh

#note that this is very bash centric.

which nix-env
if [ $? != 0 ]
then
  . ./install-nix.sh
  #need the environment setup, so recurse
  exec bash -l ./setup-cli.sh
fi

nix-env -f cli.nix -i --remove-all


#mostly bash is the default, and our game is just
#to be able to use fish, not make it the "default"
echo $SHELL | grep bash
if [ $? != 0 ]
then
  chsh -s `which bash`
  if [ $? != 0 ]
  then
    chsh -s /bin/bash
  fi
fi

# make sure that we fire bashrc, even on a login
if [ -e $HOME/.bash_profile ]
then
  profile="$HOME/.bash_profile"
elif [ -e $HOME/.bash_login ]
then
  profile="$HOME/.bash_login"
else
  profile="$HOME/.profile"
fi
grep -F bashrc $profile
if [ $? != 0 ]
then
  printf ". %s\n" $HOME/.bashrc >> $profile
fi

# now make sure bash starts fish when running from login mode
grep -F fish $HOME/.bashrc
if [ $? != 0 ]
then
  cat >> $HOME/.bashrc << eof

if [ -z \$IN_NIX_SHELL ]
then
  if [ -f $HOME/.nix-profile/etc/profile.d/nix.sh ]
  then
    . $HOME/.nix-profile/etc/profile.d/nix.sh ]
  fi

  exec `which fish`
fi
eof

fi

mkdir -p $HOME/.config/fish
cp -r --remove-destination fish/* $HOME/.config/fish/
