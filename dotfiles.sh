#!/bin/zsh
ln -sf ~/dotfiles/.vimrc ~/.ideavimrc
echo "setup IdeaVim"

NVIM_DIR=~/.config/nvim
rm -rf $NVIM_DIR
mkdir -p $NVIM_DIR
# cp -rf ~/dotfiles/lazynvim/* $NVIM_DIR
cp -rf ~/dotfiles/astronvim/* $NVIM_DIR
echo "setup NeoVim"
