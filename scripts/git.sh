#!/usr/bin/env bash
#
# git.sh - Git設定
# Gitのグローバル設定を行います
# 依存: packages.sh (gitコマンドが必要)
#

set -euo pipefail

readonly SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
readonly ROOT_DIR="$(dirname "$SCRIPT_DIR")"

# 必要なライブラリを読み込む
source "$ROOT_DIR/scripts/common.sh"
source "$ROOT_DIR/scripts/logging.sh"

# 定数定義
readonly FEATURE_NAME="Git"
readonly GIT_MESSAGE_FILE="$ROOT_DIR/.gitmessage.txt"

# Git設定
setup_git_config() {
  log_info "Setting up Git configuration..."

  # ユーザー名とメールアドレスの確認
  local current_name=$(git config --global user.name 2>/dev/null || echo "")
  local current_email=$(git config --global user.email 2>/dev/null || echo "")

  if [[ -z "$current_name" ]]; then
    log_warn "Git user.name is not set"
    log_info "Set it with: git config --global user.name 'Your Name'"
  fi

  if [[ -z "$current_email" ]]; then
    log_warn "Git user.email is not set"
    log_info "Set it with: git config --global user.email 'your.email@example.com'"
  fi

  # 基本設定
  git config --global init.defaultBranch main
  git config --global core.editor nvim
  git config --global core.autocrlf input
  git config --global pull.rebase false
  git config --global push.default current

  # コミットテンプレート設定
  if [[ -f "$GIT_MESSAGE_FILE" ]]; then
    git config --global commit.template "$GIT_MESSAGE_FILE"
    log_success "Git commit template configured"
  fi

  # エイリアス設定
  git config --global alias.st status
  git config --global alias.co checkout
  git config --global alias.br branch
  git config --global alias.ci commit
  git config --global alias.lg "log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit"

  log_success "Git configuration completed"
}

# 設定の検証
verify_installation() {
  log_info "Verifying Git setup..."

  if ! command_exists git; then
    log_error "Git command not found"
    return 1
  fi

  # 重要な設定の確認
  local configs=(
    "init.defaultBranch"
    "core.editor"
    "commit.template"
  )

  local has_error=false
  for config in "${configs[@]}"; do
    if ! git config --global "$config" >/dev/null 2>&1; then
      log_warn "Git config $config is not set"
      has_error=true
    fi
  done

  if [[ "$has_error" == true ]]; then
    log_warn "Some Git configurations are missing"
  fi

  return 0
}

# クリーンアップ処理
cleanup() {
  log_section "Cleaning up $FEATURE_NAME"

  if ! command_exists git; then
    log_warn "git command not found, skipping cleanup."
    return 0
  fi

  local configs_to_unset=(
    "init.defaultBranch"
    "core.editor"
    "core.autocrlf"
    "pull.rebase"
    "push.default"
    "commit.template"
  )

  for key in "${configs_to_unset[@]}"; do
    if git config --global --get "$key" >/dev/null; then
      git config --global --unset "$key"
      log_info "Unset git config: $key"
    fi
  done

  if git config --global --get-regexp "^alias\." >/dev/null; then
    git config --global --remove-section alias
    log_info "Removed all git aliases"
  fi

  log_success "$FEATURE_NAME cleanup completed!"
}

# メイン処理
main() {
  log_section "$FEATURE_NAME Setup"

  # 依存関係の確認
  if ! command_exists git; then
    log_error "git is required but not installed"
    log_info "Please run packages.sh first"
    return 1
  fi

  show_command_version git

  # Git設定
  if ! setup_git_config; then
    log_error "Failed to setup Git configuration"
    return 1
  fi

  # 設定の検証
  if ! verify_installation; then
    log_error "Git setup verification failed"
    return 1
  fi

  log_success "$FEATURE_NAME setup completed!"
  return 0
}

main "$@"
