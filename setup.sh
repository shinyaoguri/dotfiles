#!/bin/bash

echo "\nOSの判定"
if [ "$(uname)" == 'Darwin' ]; then
  OS='Mac'
  echo "-> Mac"
  if [ -f ./mac_setup.sh ]; then
    bash ./mac_setup.sh
  else
    bash -c "$(curl -fsSL https://raw.githubusercontent.com/shinyaoguri/dotfiles/main/mac_setup.sh)"
  fi
elif [ "$(expr substr $(uname -s) 1 5)" == 'Linux' ]; then
  OS='Linux'
  echo "-> Linux"
elif [ "$(expr substr $(uname -s) 1 10)" == 'MINGW32_NT' ]; then                                                                                           
  OS='Cygwin'
else
  echo "Your platform ($(uname -a)) is not supported."
  exit 1
fi