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
rm ~/dotfiles/lazyvim/lazy-lock.json
ln -s ~/dotfiles/lazyvim $NVIM_DIR
echo "SetUp LazyVim"

echo

# IdeaVim設定
ln -sf ~/dotfiles/.vimrc ~/.ideavimrc
echo "SetUp IdeaVim"

echo

# ツール群
if ! brew list gopls &>/dev/null; then
  echo "Install gopls"
  brew install gopls
else
  echo "Update gopls"
  brew upgrade gopls
fi

echo

if ! brew list golangci-lint &>/dev/null; then
  echo "Install golangci-lint"
  brew install golangci-lint
else
  echo "Update golangci-lint"
  brew upgrade golangci-lint
fi

echo

if ! brew list lazygit &>/dev/null; then
  echo "Install lazygit"
  brew install lazygit
else
  echo "Update lazygit"
  brew upgrade lazygit
fi

echo

if ! brew list ripgrep &>/dev/null; then
  echo "Install ripgrep"
  brew install ripgrep
else
  echo "Update ripgrep"
  brew upgrade ripgrep
fi
