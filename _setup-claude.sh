#!/bin/bash

# .claude ディレクトリのパス
CLAUDE_DIR="$HOME/.claude"
# dotfiles/claude ディレクトリのパス
DOTFILES_CLAUDE_DIR="$HOME/dotfiles/claude"

# .claude ディレクトリが存在しない場合は作成
if [ ! -d "$CLAUDE_DIR" ]; then
  mkdir -p "$CLAUDE_DIR"
  echo "ディレクトリを作成しました: $CLAUDE_DIR"
else
  echo "ディレクトリは既に存在します: $CLAUDE_DIR"
fi

# CLAUDE.md ファイルへのシンボリックリンクを作成
TARGET_CLAUDE_MD="$CLAUDE_DIR/CLAUDE.md"
SOURCE_CLAUDE_MD="$DOTFILES_CLAUDE_DIR/CLAUDE.md"
rm -rf "$TARGET_CLAUDE_MD"
ln -sf "$SOURCE_CLAUDE_MD" "$TARGET_CLAUDE_MD"
echo "シンボリックリンクを作成/更新しました: $SOURCE_CLAUDE_MD -> $TARGET_CLAUDE_MD"

# docs ディレクトリへのシンボリックリンクを作成
TARGET_DOCS_PATH="$CLAUDE_DIR/docs"
SOURCE_DOCS_DIR="$DOTFILES_CLAUDE_DIR/docs"
rm -rf "$TARGET_DOCS_PATH"
ln -sf "$SOURCE_DOCS_DIR" "$TARGET_DOCS_PATH"
echo "シンボリックリンクを作成/更新しました: $TARGET_DOCS_PATH -> $SOURCE_DOCS_DIR"
