#!/bin/zsh

# NeoVim設定
CONFIG_DIR=~/.config
NVIM_DIR=${CONFIG_DIR}/nvim

# 既存のNeovim設定を削除
rm -rf ~/.local/share/nvim
rm -rf ~/.local/state/nvim
rm -rf ~/.cache/nvim
rm -rf $CONFIG_DIR
mkdir -p $CONFIG_DIR

# LazyVim設定
rm ~/dotfiles/lazyvim/lazy-lock.json
ln -s ~/dotfiles/lazyvim $NVIM_DIR
echo "LazyVim を設定しました。"

# IdeaVim設定
ln -sf ~/dotfiles/.vimrc ~/.ideavimrc
echo "IdeaVim 設定しました。"

