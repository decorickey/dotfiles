#!/bin/bash

if ! [ -d ~/.fzf ]; then
  echo "***** Install fzf *****"
  git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
  cd ~/.fzf
  ./install --all
  cd ~/dotfiles
else
  echo "***** Update fzf *****"
  cd ~/.fzf
  git pull
  ./install --all
  cd ~/dotfiles
fi
echo
