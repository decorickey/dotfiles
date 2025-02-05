#!/bin/bash

echo "***** Setup NeoVim *****"
CONFIG_DIR=~/.config
NVIM_DIR=${CONFIG_DIR}/nvim
echo

echo "***** Reset NeoVim *****"
rm -rf ~/.local/share/nvim
rm -rf ~/.local/state/nvim
rm -rf ~/.cache/nvim
rm -rf $CONFIG_DIR
mkdir -p $CONFIG_DIR
echo

echo "***** Initialize LazyVim *****"
ln -s ~/dotfiles/lazyvim $NVIM_DIR
echo

echo "***** Initialize IdeaVim *****"
ln -sf ~/dotfiles/.vimrc ~/.ideavimrc
echo
