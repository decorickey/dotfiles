#!/bin/bash

echo "***** Install fzf *****"
if ! [ -d ~/.fzf ]; then
  echo "Install fzf"
  git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
  ~/.fzf/install
else
  echo "Update fzf"
  cd ~/.fzf && git pull && ./install
  cd
fi
