#!/bin/zsh
ln -sf ~/dotfiles/.ideavimrc ~/.ideavimrc

DIR="${HOME}/.config/nvim"
if [ -d ${DIR} ]; then
  ln -sf ~/dotfiles/init.lua "${DIR}/init.lua"
else
  echo "Not Found \"${DIR}\""
fi

DIR="${HOME}/.ipython/profile_default"
if [ -d ${DIR} ]; then
  ln -sf ~/dotfiles/ipython_config.py "${DIR}/ipython_config.py"
else
  echo "Not Found \"${DIR}\""
  echo "Exec \"ipython profile create\""
fi

