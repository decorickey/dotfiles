#!/bin/bash

set -euo pipefail

# 定数定義
readonly CLAUDE_DIR="$HOME/.claude"
readonly DOTFILES_CLAUDE_DIR="$HOME/dotfiles/claude"
readonly AGENTS_DIR="$CLAUDE_DIR/agents"
readonly SOURCE_AGENTS_DIR="$DOTFILES_CLAUDE_DIR/agents"

# 色付きログ出力
log_info() {
  echo -e "\033[0;32m[INFO]\033[0m $1"
}

log_warn() {
  echo -e "\033[0;33m[WARN]\033[0m $1"
}

log_error() {
  echo -e "\033[0;31m[ERROR]\033[0m $1"
}

# ディレクトリ作成関数
create_directory_if_not_exists() {
  local dir="$1"
  if [ ! -d "$dir" ]; then
    mkdir -p "$dir"
    log_info "ディレクトリを作成しました: $dir"
  else
    log_info "ディレクトリは既に存在します: $dir"
  fi
}

# シンボリックリンク作成関数
create_symlink() {
  local source="$1"
  local target="$2"
  local description="${3:-ファイル}"

  if [ ! -e "$source" ]; then
    log_error "ソースファイルが存在しません: $source"
    return 1
  fi

  rm -rf "$target"
  ln -sf "$source" "$target"
  log_info "${description}のシンボリックリンクを作成/更新しました: $source -> $target"
}

# エージェントファイルのシンボリックリンク作成
setup_agent_symlinks() {
  if [ ! -d "$SOURCE_AGENTS_DIR" ]; then
    log_warn "エージェントディレクトリが見つかりません: $SOURCE_AGENTS_DIR"
    return 0
  fi

  local agent_files=("$SOURCE_AGENTS_DIR"/*.md)

  # ファイルが存在しない場合の処理
  if [ ! -e "${agent_files[0]}" ]; then
    log_warn "エージェントファイルが見つかりません: $SOURCE_AGENTS_DIR/*.md"
    return 0
  fi

  for agent_file in "${agent_files[@]}"; do
    if [ -f "$agent_file" ]; then
      local filename=$(basename "$agent_file")
      local target_file="$AGENTS_DIR/$filename"
      create_symlink "$agent_file" "$target_file" "エージェント"
    fi
  done
}

# メイン処理
main() {
  log_info "Claude Code セットアップを開始します..."

  # 必要なディレクトリの作成
  create_directory_if_not_exists "$CLAUDE_DIR"
  create_directory_if_not_exists "$AGENTS_DIR"

  # 設定ファイルのシンボリックリンク作成
  create_symlink "$DOTFILES_CLAUDE_DIR/CLAUDE.md" "$CLAUDE_DIR/CLAUDE.md" "CLAUDE.md"
  create_symlink "$DOTFILES_CLAUDE_DIR/settings.json" "$CLAUDE_DIR/settings.json" "settings.json"

  # エージェントファイルのシンボリックリンク作成
  setup_agent_symlinks

  log_info "Claude Code セットアップが完了しました。"
}

# スクリプト実行
main "$@"
