#!/usr/bin/env bash
#
# claude.sh - Claude Codeの設定ファイルとエージェント、コマンドのセットアップ
# Claude Codeの設定ファイル、エージェント、コマンドディレクトリのシンボリックリンクを作成します
# 依存: なし
#

set -euo pipefail

readonly SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
readonly ROOT_DIR="$(dirname "$SCRIPT_DIR")"

# 必要なライブラリを読み込む
source "$ROOT_DIR/scripts/common.sh"
source "$ROOT_DIR/scripts/logging.sh"

# 定数定義
readonly FEATURE_NAME="Claude Code"
readonly CLAUDE_DIR="$HOME/.claude"
readonly SOURCE_CLAUDE_DIR="$ROOT_DIR/.claude"
readonly AGENTS_DIR="$CLAUDE_DIR/agents"
readonly SOURCE_AGENTS_DIR="$SOURCE_CLAUDE_DIR/agents"
readonly COMMANDS_DIR="$CLAUDE_DIR/commands"
readonly SOURCE_COMMANDS_DIR="$SOURCE_CLAUDE_DIR/commands"

# 関数定義
setup_claude_config() {
  log_info "Setting up Claude Code configuration files..."

  # 必要なディレクトリの作成
  create_directory "$CLAUDE_DIR"

  # CLAUDE.mdのシンボリックリンク作成
  local claude_md="$SOURCE_CLAUDE_DIR/CLAUDE.md"
  if [[ -f "$claude_md" ]]; then
    create_symlink "$claude_md" "$CLAUDE_DIR/CLAUDE.md" "CLAUDE.md configuration"
  else
    log_warn "CLAUDE.md not found: $claude_md"
  fi

  # settings.jsonのシンボリックリンク作成
  local settings_json="$SOURCE_CLAUDE_DIR/settings.json"
  if [[ -f "$settings_json" ]]; then
    create_symlink "$settings_json" "$CLAUDE_DIR/settings.json" "settings.json configuration"
  else
    log_warn "settings.json not found: $settings_json"
  fi

  # statusline-command.shのシンボリックリンク作成
  local statusline_script="$SOURCE_CLAUDE_DIR/statusline-command.sh"
  if [[ -f "$statusline_script" ]]; then
    create_symlink "$statusline_script" "$CLAUDE_DIR/statusline-command.sh" "statusline-command.sh script"
  else
    log_warn "statusline-command.sh not found: $statusline_script"
  fi

  return 0
}

setup_claude_agents() {
  log_info "Setting up Claude Code agents..."

  if [[ ! -d "$SOURCE_AGENTS_DIR" ]]; then
    log_warn "Agents directory not found: $SOURCE_AGENTS_DIR"
    return 0
  fi

  # 既存のagentsディレクトリを削除
  if [[ -e "$AGENTS_DIR" ]]; then
    log_info "Removing existing agents directory: $AGENTS_DIR"
    rm -rf "$AGENTS_DIR"
  fi

  # agentsディレクトリ自体をシンボリックリンクとして作成
  if ! create_symlink "$SOURCE_AGENTS_DIR" "$AGENTS_DIR" "agents directory"; then
    return 1
  fi

  return 0
}

setup_claude_commands() {
  log_info "Setting up Claude Code commands..."

  if [[ ! -d "$SOURCE_COMMANDS_DIR" ]]; then
    log_warn "Commands directory not found: $SOURCE_COMMANDS_DIR"
    return 0
  fi

  # 既存のcommandsディレクトリを削除
  if [[ -e "$COMMANDS_DIR" ]]; then
    log_info "Removing existing commands directory: $COMMANDS_DIR"
    rm -rf "$COMMANDS_DIR"
  fi

  # commandsディレクトリ自体をシンボリックリンクとして作成
  if ! create_symlink "$SOURCE_COMMANDS_DIR" "$COMMANDS_DIR" "commands directory"; then
    return 1
  fi

  return 0
}

show_usage_info() {
  log_info ""
  log_info "Claude Code setup completed!"
  log_info ""
  log_info "Available configurations:"
  if [[ -f "$CLAUDE_DIR/CLAUDE.md" ]]; then
    log_info "  • Global instructions: $CLAUDE_DIR/CLAUDE.md"
  fi
  if [[ -f "$CLAUDE_DIR/settings.json" ]]; then
    log_info "  • Settings: $CLAUDE_DIR/settings.json"
  fi
  if [[ -f "$CLAUDE_DIR/statusline-command.sh" ]]; then
    log_info "  • Statusline script: $CLAUDE_DIR/statusline-command.sh"
  fi
  if [[ -d "$AGENTS_DIR" ]]; then
    log_info "  • Agents directory: $AGENTS_DIR"
  fi
  if [[ -d "$COMMANDS_DIR" ]]; then
    log_info "  • Commands directory: $COMMANDS_DIR"
  fi
}

verify_installation() {
  log_info "Verifying $FEATURE_NAME installation..."

  # 基本ディレクトリの確認
  if [[ ! -d "$CLAUDE_DIR" ]]; then
    log_error "Claude directory not found: $CLAUDE_DIR"
    return 1
  fi

  log_success "Claude directory created: $CLAUDE_DIR"

  # 設定ファイルの確認
  local config_files_found=0

  if [[ -L "$CLAUDE_DIR/CLAUDE.md" ]] && [[ -e "$CLAUDE_DIR/CLAUDE.md" ]]; then
    log_info "CLAUDE.md is properly linked"
    ((config_files_found++))
  fi

  if [[ -L "$CLAUDE_DIR/settings.json" ]] && [[ -e "$CLAUDE_DIR/settings.json" ]]; then
    log_info "settings.json is properly linked"
    ((config_files_found++))
  fi

  if [[ -L "$CLAUDE_DIR/statusline-command.sh" ]] && [[ -e "$CLAUDE_DIR/statusline-command.sh" ]]; then
    log_info "statusline-command.sh is properly linked"
    ((config_files_found++))
  fi

  # エージェントディレクトリの確認
  if [[ -L "$AGENTS_DIR" ]] && [[ -d "$AGENTS_DIR" ]]; then
    log_info "Agents directory is properly linked"
    ((config_files_found++))
  fi

  # コマンドディレクトリの確認
  if [[ -L "$COMMANDS_DIR" ]] && [[ -d "$COMMANDS_DIR" ]]; then
    log_info "Commands directory is properly linked"
    ((config_files_found++))
  fi

  if [[ $config_files_found -eq 0 ]]; then
    log_warn "No configuration files or directories were found"
    log_info "This may be normal if source configurations don't exist yet"
  fi

  return 0
}

cleanup() {
  log_section "Cleaning up $FEATURE_NAME"

  if [[ -L "$CLAUDE_DIR/CLAUDE.md" ]]; then
    rm "$CLAUDE_DIR/CLAUDE.md"
    log_info "Removed Claude guidance symlink: $CLAUDE_DIR/CLAUDE.md"
  fi

  if [[ -L "$CLAUDE_DIR/settings.json" ]]; then
    rm "$CLAUDE_DIR/settings.json"
    log_info "Removed Claude settings symlink: $CLAUDE_DIR/settings.json"
  fi

  if [[ -L "$CLAUDE_DIR/statusline-command.sh" ]]; then
    rm "$CLAUDE_DIR/statusline-command.sh"
    log_info "Removed Claude statusline script symlink: $CLAUDE_DIR/statusline-command.sh"
  fi

  if [[ -L "$AGENTS_DIR" ]]; then
    rm "$AGENTS_DIR"
    log_info "Removed Claude agents symlink: $AGENTS_DIR"
  fi

  if [[ -L "$COMMANDS_DIR" ]]; then
    rm "$COMMANDS_DIR"
    log_info "Removed Claude commands symlink: $COMMANDS_DIR"
  fi

  if [[ -d "$CLAUDE_DIR" ]] && [[ -z "$(ls -A "$CLAUDE_DIR")" ]]; then
    rmdir "$CLAUDE_DIR"
    log_info "Removed empty directory: $CLAUDE_DIR"
  fi

  log_success "$FEATURE_NAME cleanup completed!"
}

# メイン処理
main() {
  log_section "$FEATURE_NAME Setup"

  # Claude設定ファイルのセットアップ
  if ! setup_claude_config; then
    log_error "Failed to setup Claude configuration files"
    return 1
  fi

  # エージェントのセットアップ
  if ! setup_claude_agents; then
    log_error "Failed to setup Claude agents"
    return 1
  fi

  # コマンドのセットアップ
  if ! setup_claude_commands; then
    log_error "Failed to setup Claude commands"
    return 1
  fi

  if ! verify_installation; then
    log_error "Failed to verify $FEATURE_NAME"
    return 1
  fi

  # 使用情報の表示
  show_usage_info

  log_success "$FEATURE_NAME setup completed!"
  return 0
}

main "$@"
