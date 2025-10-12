#!/usr/bin/env bash
#
# スクリプト名: vscode.sh
# 説明: VSCode設定の管理とNeovim統合設定
# 依存: neovim.sh (.vimrc)
#

set -euo pipefail

readonly SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
readonly ROOT_DIR="$(dirname "$SCRIPT_DIR")"

# 必要なライブラリのみ読み込む
source "$ROOT_DIR/scripts/common.sh"
source "$ROOT_DIR/scripts/logging.sh"

# 定数定義
readonly FEATURE_NAME="VSCode"
readonly VSCODE_USER_DIR="$HOME/Library/Application Support/Code/User"
readonly DOTFILES_VSCODE_DIR="$ROOT_DIR/vscode"
readonly VIMRC_FILE="$ROOT_DIR/.vimrc"

# VSCode設定ファイル
readonly SETTINGS_SRC="$DOTFILES_VSCODE_DIR/settings.json"
readonly SETTINGS_DST="$VSCODE_USER_DIR/settings.json"
readonly KEYBINDINGS_SRC="$DOTFILES_VSCODE_DIR/keybindings.json"
readonly KEYBINDINGS_DST="$VSCODE_USER_DIR/keybindings.json"

# 前提条件チェック
check_prerequisites() {
  log_info "Checking prerequisites for VSCode setup..."

  # VSCode コマンドラインツールの確認
  if ! command -v code >/dev/null 2>&1; then
    log_warn "VSCode command line tools are not installed"
    log_info "Please install VSCode and add 'code' command to PATH:"
    log_info "  1. Open VSCode"
    log_info "  2. Press Cmd+Shift+P"
    log_info "  3. Type 'Shell Command: Install 'code' command in PATH'"
    log_info "  4. Select and execute the command"
    return 1
  fi

  # .vimrcファイルの存在確認
  if [[ ! -f "$VIMRC_FILE" ]]; then
    log_error ".vimrc file not found: $VIMRC_FILE"
    log_error "Please run neovim setup first: ./setup.sh --only neovim"
    return 1
  fi

  return 0
}

# VSCode拡張機能の確認
check_extensions() {
  log_info "Checking VSCode extensions..."

  # NeoVim拡張機能の確認
  if ! code --list-extensions | grep -q "asvetliakov.vscode-neovim"; then
    log_warn "VSCode NeoVim extension is not installed"
    log_info "Please install the extension:"
    log_info "  code --install-extension asvetliakov.vscode-neovim"
    log_info "Or install manually from the VSCode extensions marketplace"
  else
    log_info "VSCode NeoVim extension is installed"
  fi
}

# VSCode設定のセットアップ
setup_vscode_config() {
  log_info "Setting up VSCode configuration..."

  # VSCode User ディレクトリの確認
  if [[ ! -d "$VSCODE_USER_DIR" ]]; then
    log_warn "VSCode User directory not found: $VSCODE_USER_DIR"
    log_info "Please run VSCode at least once to create the configuration directory"
    return 1
  fi

  # settings.json のシンボリックリンク作成
  if ! create_symlink "$SETTINGS_SRC" "$SETTINGS_DST" "VSCode settings"; then
    log_warn "Failed to create VSCode settings symlink"
    return 1
  fi

  # keybindings.json のシンボリックリンク作成
  if ! create_symlink "$KEYBINDINGS_SRC" "$KEYBINDINGS_DST" "VSCode keybindings"; then
    log_warn "Failed to create VSCode keybindings symlink"
    return 1
  fi

  return 0
}

# 設定の確認
verify_setup() {
  log_info "Verifying VSCode setup..."

  local success=true

  # シンボリックリンクの確認
  if [[ -L "$SETTINGS_DST" ]] && [[ "$(readlink "$SETTINGS_DST")" == "$SETTINGS_SRC" ]]; then
    log_info "VSCode settings linked successfully"
  else
    log_error "VSCode settings link verification failed"
    success=false
  fi

  if [[ -L "$KEYBINDINGS_DST" ]] && [[ "$(readlink "$KEYBINDINGS_DST")" == "$KEYBINDINGS_SRC" ]]; then
    log_info "VSCode keybindings linked successfully"
  else
    log_error "VSCode keybindings link verification failed"
    success=false
  fi

  # .vimrcにVSCode設定が含まれているかの確認
  if grep -q "exists('g:vscode')" "$VIMRC_FILE"; then
    log_info "VSCode configuration found in .vimrc"
  else
    log_warn "VSCode configuration not found in .vimrc"
    success=false
  fi

  if [[ "$success" == true ]]; then
    log_success "VSCode setup completed successfully!"
    log_info "VSCode is now configured with unified Vim keybindings"
    log_info "Make sure to install the NeoVim extension if not already installed:"
    log_info "  code --install-extension asvetliakov.vscode-neovim"
  else
    log_error "VSCode setup completed with some issues"
    return 1
  fi

  return 0
}

# メイン処理
main() {
  log_section "Setting up $FEATURE_NAME"

  # 前提条件チェック
  if ! check_prerequisites; then
    log_error "Prerequisites check failed"
    return 1
  fi

  # 拡張機能の確認（必須ではない）
  check_extensions || true

  # VSCode設定のセットアップ
  if ! setup_vscode_config; then
    log_error "VSCode configuration setup failed"
    return 1
  fi

  # 設定の確認
  if ! verify_setup; then
    log_error "VSCode setup verification failed"
    return 1
  fi

  log_success "$FEATURE_NAME setup completed successfully!"
  return 0
}

# スクリプトが直接実行された場合のみmainを呼び出す
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
  main "$@"
fi
