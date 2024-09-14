#!/bin/zsh
ln -sf ~/dotfiles/.vimrc ~/.ideavimrc
echo "created symbolic link for IdeaVim"

rm -rf ~/.config/nvim
mkdir -p ~/.config/nvim
cp -rf ~/dotfiles/lazynvim/* ~/.config/nvim/
echo "created symbolic link for LazyNvim"
