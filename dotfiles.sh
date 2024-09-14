#!/bin/zsh
ln -sf ~/dotfiles/.vimrc ~/.ideavimrc
echo "setup IdeaVim"

NVIM_DIR=~/.config/nvim
rm -rf ~/.config/nvim
mkdir -p $NVIM_DIR
# cp -rf ~/dotfiles/lazynvim/* $NVIM_DIR
cp -rf ~/dotfiles/astronvim/* $NVIM_DIR
echo "setup NeoVim"
