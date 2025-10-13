#!/usr/bin/env bash

set -euo pipefail

#
# logging.sh - ログ出力関数
# 色付きのログ出力機能を提供
#

# ラベルの表示幅を揃える
_LOG_LABEL_WIDTH=7

# 汎用ログ出力
_log_message() {
  local color="$1"
  local label="$2"
  shift 2
  local message="$*"
  local padding_width=$((_LOG_LABEL_WIDTH - ${#label} + 1))
  if (( padding_width < 1 )); then
    padding_width=1
  fi
  local padding=""
  printf -v padding "%*s" "$padding_width" ""
  printf "\033[%sm[%s]\033[0m%s%s\n" "$color" "$label" "$padding" "$message"
}

# 情報メッセージ（緑）
log_info() {
  _log_message "0;32" "INFO" "$@"
}

# 警告メッセージ（黄）
log_warn() {
  _log_message "0;33" "WARN" "$@"
}

# エラーメッセージ（赤）
log_error() {
  _log_message "0;31" "ERROR" "$@" >&2
}

# 成功メッセージ（シアン）
log_success() {
  _log_message "0;36" "SUCCESS" "$@"
}

# デバッグメッセージ（紫）
log_debug() {
  if [[ -n "${DEBUG:-}" ]]; then
    _log_message "0;35" "DEBUG" "$@"
  fi
}

# セクション区切り
log_section() {
  local title="$1"
  echo
  echo -e "\033[0;34m========================================"
  echo -e "  $title"
  echo -e "========================================\033[0m"
  echo
}
