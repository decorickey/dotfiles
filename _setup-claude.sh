#!/bin/bash

# .claude ディレクトリのパス
CLAUDE_DIR="$HOME/.claude"
# dotfiles/claude ディレクトリのパス
SOURCE_DIR="$HOME/dotfiles/claude"

# .claude ディレクトリが存在しない場合は作成
if [ ! -d "$CLAUDE_DIR" ]; then
  mkdir -p "$CLAUDE_DIR"
  echo "ディレクトリを作成しました: $CLAUDE_DIR"
fi

# CLAUDE.md ファイルへのシンボリックリンクを作成
CLAUDE_MD_PATH="$SOURCE_DIR/CLAUDE.md"
if [ -f "$CLAUDE_MD_PATH" ]; then
  ln -sf "$CLAUDE_MD_PATH" "$CLAUDE_DIR/CLAUDE.md"
  echo "シンボリックリンクを作成しました: $CLAUDE_DIR/CLAUDE.md -> $CLAUDE_MD_PATH"
else
  echo "警告: ファイルが見つかりません - $CLAUDE_MD_PATH"
fi

# doc ディレクトリへのシンボリックリンクを作成
DOC_DIR_PATH="$SOURCE_DIR/docs"
if [ -d "$DOC_DIR_PATH" ]; then
  ln -sf "$DOC_DIR_PATH" "$CLAUDE_DIR/docs"
  echo "シンボリックリンクを作成しました: $CLAUDE_DIR/docs -> $DOC_DIR_PATH"
else
  echo "警告: ディレクトリが見つかりません - $DOC_DIR_PATH"
fi
