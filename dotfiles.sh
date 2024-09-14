#!/bin/zsh

# NeoVim設定
NVIM_DIR=~/.config/nvim

# 引数が渡されているかをチェック
if [ -z "$1" ]; then
  echo "エラー: 引数が必要です (lazy または astro)"
  exit 1
fi

# 既存のNeovim設定を削除
rm -rf $NVIM_DIR
mkdir -p $NVIM_DIR

# 引数に応じて処理を分岐
if [ "$1" = "lazy" ]; then
  cp -rf ~/dotfiles/lazynvim/* $NVIM_DIR
  echo "LazyVim 設定をコピーしました。"
elif [ "$1" = "astro" ]; then
  cp -rf ~/dotfiles/astronvim/* $NVIM_DIR
  echo "AstroNvim 設定をコピーしました。"
else
  echo "エラー: 不正な引数です。'lazy' または 'astro' を指定してください。"
  exit 1
fi

# IdeaVim設定
ln -sf ~/dotfiles/.vimrc ~/.ideavimrc
echo "IdeaVim 設定しました。"

