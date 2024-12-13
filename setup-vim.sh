#!/bin/bash

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
echo "***** Initialize LazyVim *****"
rm ~/dotfiles/lazyvim/lazy-lock.json
ln -s ~/dotfiles/lazyvim $NVIM_DIR
echo

# IdeaVim設定
echo "***** Initialize IdeaVim *****"
ln -sf ~/dotfiles/.vimrc ~/.ideavimrc
echo

# ツール群
tools=("gopls" "golangci-lint", "lazygit", "repgrep")

for tool in "${tools[@]}"; do
  if ! brew list "$tool" &>/dev/null; then
    echo "***** Install $tool *****"
    brew install "$tool"
  else
    echo "***** Upgrade $tool *****"
    brew upgrade "$tool"
  fi
  echo
done
