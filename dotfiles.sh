#!/bin/zsh
ln -sf ~/dotfiles/.vimrc ~/.ideavimrc
echo "created symbolic link for IdeaVim"

rm -rf ~/.config/nvim
ln -sf ~/dotfiles/astronvim_config ~/.config/nvim
echo "created symbolic link for AstroNvim"
