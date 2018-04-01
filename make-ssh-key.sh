#!/bin/sh

echo -n "Enter comment: "
read comment

if [ -e $HOME/.ssh/id_rsa ]
then
  echo -n "Enter key file: $HOME/.ssh/"
  read keyfile
else
  mkdir -p $HOME/.ssh
  keyfile="id_rsa"
fi
  
ssh-keygen -t rsa -b 4096 -f $HOME/.ssh/$keyfile -C $comment
