#!/usr/bin/env bash

#note that this is very bash centric.
if [ -f $HOME/.nix-profile/etc/profile.d/nix.sh ]
then
  . $HOME/.nix-profile/etc/profile.d/nix.sh ]
fi

if ! which nix-env
then
  if . ./install-nix.sh
  then
    #need the environment setup
    . $HOME/.nix-profile/etc/profile.d/nix.sh
  else
    echo "Could not install nix"
    exit 1
  fi
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

if [ -z \$IN_NIX_SHELL ] && [ -z \$PIPENV_ACTIVE ]
then
  if [ -f $HOME/.nix-profile/etc/profile.d/nix.sh ]
  then
    . $HOME/.nix-profile/etc/profile.d/nix.sh ]
  fi

  exec `which fish`
fi
eof

fi

rm -rf $HOME/.config/fish
mkdir -p $HOME/.config/fish
cp -R fish/* $HOME/.config/fish/

rm -rf $HOME/.config/herbstluftwm
mkdir -p $HOME/.config/herbstluftwm
cp -R herbstluftwm/* $HOME/.config/herbstluftwm/


rm -rf $HOME/.emacs.d
mkdir -p $HOME/.emacs.d
cp -R emacs/* $HOME/.emacs.d/

# get pretty colors for emacs and such
# https://www.gnu.org/software/emacs/manual/html_node/efaq/Colors-on-a-TTY.html
tic -x -o ~/.terminfo terminfo-24bit.src

git config --global user.email "jon@ylixir.io"
git config --global user.name "Jon Allen"
