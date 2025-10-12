#!/usr/bin/env bash
#
# スクリプト名: 04_neovim.sh
# 説明: NeovimとLazyVimの設定、IdeaVimの設定
# 依存: 01_packages.sh (neovim, git)
#

set -euo pipefail

readonly SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
readonly ROOT_DIR="$(dirname "$SCRIPT_DIR")"

# 必要なライブラリのみ読み込む
source "$ROOT_DIR/scripts/common.sh"
source "$ROOT_DIR/scripts/logging.sh"

# 定数定義
readonly FEATURE_NAME="Neovim"
readonly CONFIG_DIR="$HOME/.config"
readonly NVIM_DIR="$CONFIG_DIR/nvim"
readonly LAZYVIM_DIR="$ROOT_DIR/lazyvim"
readonly VIMRC_FILE="$ROOT_DIR/.vimrc"
readonly IDEAVIMRC_FILE="$HOME/.ideavimrc"

# Neovim関連のディレクトリ
readonly NVIM_DATA_DIR="$HOME/.local/share/nvim"
readonly NVIM_STATE_DIR="$HOME/.local/state/nvim"
readonly NVIM_CACHE_DIR="$HOME/.cache/nvim"

# 関数定義
cleanup_neovim() {
  log_info "Cleaning up Neovim related files..."

  local dirs=(
    "$NVIM_DATA_DIR"
    "$NVIM_STATE_DIR"
    "$NVIM_CACHE_DIR"
  )

  for dir in "${dirs[@]}"; do
    if [[ -d "$dir" ]]; then
      rm -rf "$dir"
      log_info "Removed: $dir"
    fi
  done

  # 既存のnvim設定ディレクトリの削除
  if [[ -e "$NVIM_DIR" ]]; then
    if [[ -L "$NVIM_DIR" ]]; then
      rm "$NVIM_DIR"
      log_info "Removed existing symlink: $NVIM_DIR"
    else
      rm -rf "$NVIM_DIR"
      log_info "Removed existing directory: $NVIM_DIR"
    fi
  fi

  return 0
}

setup_lazyvim() {
  log_info "Setting up LazyVim..."

  if [[ ! -d "$LAZYVIM_DIR" ]]; then
    log_error "LazyVim configuration directory not found: $LAZYVIM_DIR"
    return 1
  fi

  # シンボリックリンクの作成
  if ! create_symlink "$LAZYVIM_DIR" "$NVIM_DIR" "LazyVim configuration"; then
    return 1
  fi

  return 0
}

setup_ideavim() {
  log_info "Setting up IdeaVim..."

  if [[ ! -f "$VIMRC_FILE" ]]; then
    log_warn ".vimrc file not found: $VIMRC_FILE"
    log_info "Skipping IdeaVim setup"
    return 0
  fi

  # シンボリックリンクの作成
  if ! create_symlink "$VIMRC_FILE" "$IDEAVIMRC_FILE" "IdeaVim configuration"; then
    log_warn "Failed to create IdeaVim symlink"
    return 0
  fi

  return 0
}

show_setup_instructions() {
  log_info ""
  log_info "Neovim setup completed!"
  log_info ""
  log_info "First-time usage notes:"
  log_info "  1. When you launch nvim, LazyVim will automatically install plugins"
  log_info "  2. Installation may take some time"
  log_info "  3. If errors occur, run :checkhealth for diagnostics"
  log_info ""
  log_info "Recommended commands:"
  log_info "  nvim              # Launch Neovim"
  log_info "  :LazySync         # Sync plugins"
  log_info "  :checkhealth      # Health check"
}

verify_installation() {
  log_info "Verifying $FEATURE_NAME installation..."

  # Neovimの存在確認
  if ! command_exists nvim; then
    log_error "nvim is not installed"
    return 1
  fi

  show_command_version nvim "--version | head -n1"

  # 設定ファイルの存在確認
  if [[ ! -e "$NVIM_DIR/init.lua" ]]; then
    log_error "init.lua not found"
    return 1
  fi

  log_info "LazyVim configuration linked successfully"

  # IdeaVim設定の確認
  if [[ -L "$IDEAVIMRC_FILE" ]]; then
    log_info "IdeaVim configuration linked successfully"
  fi

  return 0
}

# メイン処理
main() {
  log_section "$FEATURE_NAME Setup"

  # Neovimの確認
  if ! require_command nvim "Please run 01_packages.sh first"; then
    return 1
  fi

  if ! require_command git "Please run 01_packages.sh first"; then
    return 1
  fi

  # クリーンアップ
  if ! cleanup_neovim; then
    log_error "Failed to cleanup Neovim"
    return 1
  fi

  # 設定ディレクトリの準備
  create_directory "$CONFIG_DIR"

  # LazyVimのセットアップ
  if ! setup_lazyvim; then
    log_error "Failed to setup LazyVim"
    return 1
  fi

  # IdeaVimのセットアップ
  setup_ideavim

  if ! verify_installation; then
    log_error "Failed to verify $FEATURE_NAME"
    return 1
  fi

  # セットアップ手順の表示
  show_setup_instructions

  log_success "$FEATURE_NAME setup completed!"
  return 0
}

main "$@"

