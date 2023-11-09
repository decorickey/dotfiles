#!/bin/zsh
ln -sf ~/dotfiles/.vimrc ~/.ideavimrc

DIR="${HOME}/.config/nvim/lua/user"
if [ ! -d ${DIR} ]; then
  mkdir ${DIR}
fi
ln -sf ~/dotfiles/init.lua "${DIR}/init.lua"

DIR="${HOME}/.ipython/profile_default"
if [ -d ${DIR} ]; then
  ln -sf ~/dotfiles/ipython_config.py "${DIR}/ipython_config.py"
else
  echo "Not Found \"${DIR}\""
  echo "Exec \"ipython profile create\""
fi

