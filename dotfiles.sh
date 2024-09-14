#!/bin/zsh

# 引数が渡されているかをチェック
if [ -z "$1" ]; then
  echo "エラー: 引数が必要です (lazy または astro)"
  exit 1
fi

# NeoVim設定
CONFIG_DIR=~/.config
NVIM_DIR=${CONFIG_DIR}/nvim

# 既存のNeovim設定を削除
rm -rf $CONFIG_DIR
mkdir -p $CONFIG_DIR

# 引数に応じて処理を分岐
if [ "$1" = "lazy" ]; then
  ln -s ~/dotfiles/lazynvim $NVIM_DIR
  echo "LazyVim を設定しました。"
elif [ "$1" = "astro" ]; then
  ln -s ~/dotfiles/astronvim $NVIM_DIR
  echo "AstroNvim を設定しました。"
else
  echo "エラー: 不正な引数です。'lazy' または 'astro' を指定してください。"
  exit 1
fi

# IdeaVim設定
ln -sf ~/dotfiles/.vimrc ~/.ideavimrc
echo "IdeaVim 設定しました。"

