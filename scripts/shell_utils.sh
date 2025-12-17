#!/usr/bin/env bash

set -euo pipefail

#
# shell_utils.sh - シェル設定関連
# シェル設定ファイルへの追加とパス管理機能を提供
#

# 必要なライブラリ
source "$(dirname "${BASH_SOURCE[0]}")/logging.sh"

# zsh設定ファイル
readonly ZSHRC="$HOME/.zshrc"

# zsh設定ファイルに行を追加
add_to_shell_config() {
  local line="$1"
  local comment="${2:-}"

  if [[ -f "$ZSHRC" ]]; then
    if ! grep -Fxq "$line" "$ZSHRC"; then
      if [[ -n "$comment" ]]; then
        echo "" >>"$ZSHRC"
        echo "# $comment" >>"$ZSHRC"
      fi
      echo "$line" >>"$ZSHRC"
      log_info "Added to .zshrc"
    else
      log_debug "Already exists in .zshrc"
    fi
  else
    log_error ".zshrc not found"
    return 1
  fi
}

# パスを追加
add_to_path() {
  local new_path="$1"
  local comment="${2:-PATH設定}"

  add_to_shell_config "export PATH=\"$new_path:\$PATH\"" "$comment"

  # 現在のセッションにも反映
  export PATH="$new_path:$PATH"
}

# 環境変数を設定
set_env_var() {
  local var_name="$1"
  local var_value="$2"
  local comment="${3:-環境変数設定}"

  add_to_shell_config "export $var_name=\"$var_value\"" "$comment"

  # 現在のセッションにも反映
  export "$var_name=$var_value"
}

# zsh設定ファイルから行を削除
remove_from_shell_config() {
  local pattern="$1"

  if [[ ! -f "$ZSHRC" ]]; then
    log_warn ".zshrc not found, skipping removal."
    return 0
  fi

  # パターンに一致する行が存在するか確認
  if grep -q "$pattern" "$ZSHRC"; then
    log_info "Removing lines matching pattern '$pattern' from .zshrc..."
    # パターンに一致しない行を一時ファイルに書き出す
    grep -v "$pattern" "$ZSHRC" > "${ZSHRC}.tmp"
    # 一時ファイルを元のファイルに置き換える
    mv "${ZSHRC}.tmp" "$ZSHRC"
    log_success "Successfully removed lines from .zshrc"
  else
    log_debug "Pattern '$pattern' not found in .zshrc."
  fi
}

# Homebrewのパスを設定する共通関数
# 各スクリプトが独立して動作できるようにする
ensure_homebrew_path() {
  local brew_path=""

  # Homebrewがすでにコマンドとして利用可能な場合は何もしない
  if command -v brew &>/dev/null; then
    log_debug "Homebrew is already in PATH"
    return 0
  fi

  # macOSとLinuxで異なるHomebrewのパスを確認
  if [[ "$(uname)" == "Darwin" ]]; then
    brew_path="/opt/homebrew/bin/brew"
  else
    brew_path="/home/linuxbrew/.linuxbrew/bin/brew"
  fi

  # Homebrewが指定のパスに存在する場合は環境変数を設定
  if [[ -x "$brew_path" ]]; then
    log_debug "Setting up Homebrew environment from $brew_path"
    eval "$("$brew_path" shellenv)"
    return 0
  else
    log_warn "Homebrew not found at $brew_path"
    return 1
  fi
}
