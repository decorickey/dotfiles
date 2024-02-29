#!/bin/zsh
ln -sf ~/dotfiles/.vimrc ~/.ideavimrc

DIR="${HOME}/.config/nvim/lua/user"
if [ ! -d ${DIR} ]; then
  mkdir ${DIR}
  echo "Created \"${DIR}\""
fi
ln -sf ~/dotfiles/nvim/init.lua "${DIR}/init.lua"
ln -sf ~/dotfiles/nvim/mappings.lua "${DIR}/mappings.lua"
ln -sf ~/dotfiles/nvim/options.lua "${DIR}/options.lua"
ln -sf ~/dotfiles/nvim/plugins "${DIR}/plugins"
echo "Created symbolic links"

DIR="${HOME}/.ipython/profile_default"
if [ -d ${DIR} ]; then
  ln -sf ~/dotfiles/ipython_config.py "${DIR}/ipython_config.py"
else
  echo "Not Found \"${DIR}\""
  echo "Exec \"ipython profile create\""
fi

echo "Complete!!!"
