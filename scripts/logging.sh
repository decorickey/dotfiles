#!/usr/bin/env bash
#
# logging.sh - ログ出力関数
# 色付きのログ出力機能を提供
#

# 情報メッセージ（緑）
log_info() {
  echo -e "\033[0;32m[INFO]\033[0m $*"
}

# 警告メッセージ（黄）
log_warn() {
  echo -e "\033[0;33m[WARN]\033[0m $*"
}

# エラーメッセージ（赤）
log_error() {
  echo -e "\033[0;31m[ERROR]\033[0m $*" >&2
}

# 成功メッセージ（シアン）
log_success() {
  echo -e "\033[0;36m[SUCCESS]\033[0m $*"
}

# デバッグメッセージ（紫）
log_debug() {
  if [[ -n "${DEBUG:-}" ]]; then
    echo -e "\033[0;35m[DEBUG]\033[0m $*"
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

