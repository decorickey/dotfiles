#!/bin/bash

if ! [ -d ~/.fzf ]; then
  echo "***** Install fzf *****"
  git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
  cd ~/.fzf
  ./install
  cd ~/dotfiles
else
  echo "***** Update fzf *****"
  cd ~/.fzf
  git pull
  ./install
  cd ~/dotfiles
fi
echo
