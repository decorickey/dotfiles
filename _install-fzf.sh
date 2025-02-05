#!/bin/bash

echo "***** fzf *****"
if ! [ -d ~/.fzf ]; then
  echo "Install"
  git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
  ~/.fzf/install
else
  echo "Update"
  cd ~/.fzf && git pull && ./install
  cd
fi
