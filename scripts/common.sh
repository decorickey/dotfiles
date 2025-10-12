#!/usr/bin/env bash
#
# common.sh - 共通ユーティリティ関数
# ファイル操作、コマンド確認、その他のユーティリティ機能を提供
#

# 必要なライブラリ
source "$(dirname "${BASH_SOURCE[0]}")/logging.sh"

# コマンドが存在するかチェック
command_exists() {
  command -v "$1" &>/dev/null
}

# 必須コマンドの確認
require_command() {
  local cmd="$1"
  local message="${2:-}"

  if ! command_exists "$cmd"; then
    log_error "$cmd がインストールされていません"
    if [[ -n "$message" ]]; then
      log_info "$message"
    fi
    return 1
  fi
}

# コマンドのバージョンを表示
show_command_version() {
  local cmd="$1"
  local version_flag="${2:---version}"

  if command_exists "$cmd"; then
    local version=$("$cmd" "$version_flag" 2>&1 | head -n1)
    log_info "$cmd バージョン: $version"
  fi
}

# ディレクトリを作成（既存の場合はスキップ）
create_directory() {
  local dir="$1"

  if [[ ! -d "$dir" ]]; then
    mkdir -p "$dir"
    log_info "ディレクトリを作成しました: $dir"
  else
    log_debug "ディレクトリは既に存在します: $dir"
  fi
}

# シンボリックリンクを作成
create_symlink() {
  local source="$1"
  local target="$2"
  local description="${3:-ファイル}"

  if [[ ! -e "$source" ]]; then
    log_error "ソースが存在しません: $source"
    return 1
  fi

  # 既存のリンクまたはファイルを削除
  if [[ -e "$target" ]] || [[ -L "$target" ]]; then
    rm -rf "$target"
  fi

  if ln -sf "$source" "$target"; then
    log_success "${description}のシンボリックリンクを作成しました: $target"
  else
    log_error "シンボリックリンクの作成に失敗しました"
    return 1
  fi
}
