#!/usr/bin/env bash
#
# dotfiles クリーンアップスクリプト
# 統一されたインターフェースで各種設定を元に戻します
#

set -euo pipefail

readonly SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
readonly LOG_FILE="$SCRIPT_DIR/cleanup.log"

# ライブラリの読み込み
source "$SCRIPT_DIR/scripts/logging.sh"
source "$SCRIPT_DIR/scripts/common.sh"

# クリーンアップスクリプトの定義
get_cleanup_script() {
  case "$1" in
  "packages") echo "packages.sh" ;;
  "shell") echo "shell.sh" ;;
  "git") echo "git.sh" ;;
  "neovim") echo "neovim.sh" ;;
  "tmux") echo "tmux.sh" ;;
  "volta") echo "volta.sh" ;;
  "claude") echo "claude.sh" ;;
  "vscode") echo "vscode.sh" ;;
  "codex") echo "codex.sh" ;;
  "gemini") echo "gemini.sh" ;;
  *) echo "" ;;
  esac
}

# デフォルトの実行順序 (セットアップと逆順)
readonly DEFAULT_ORDER=(vscode gemini codex claude volta tmux neovim git shell packages)

# ヘルプメッセージ
show_help() {
  cat <<EOF
使用方法: $0 [オプション] [ステップ...]

オプション:
    -h, --help     このヘルプメッセージを表示
    -l, --list     利用可能なクリーンアップステップを表示
    -o, --only     指定したステップのみ実行
    -s, --skip     指定したステップをスキップ

例:
    $0                    # すべてのステップを実行
    $0 --only neovim      # neovimステップのみ実行
    $0 --skip packages    # packagesステップをスキップ
EOF
}

# 利用可能なステップを表示
list_steps() {
  echo "利用可能なクリーンアップステップ:"
  for step in "${DEFAULT_ORDER[@]}"; do
    echo "  - $step"
  done
}

# クリーンアップスクリプトを実行
run_cleanup() {
  local name="$1"
  local script_name=$(get_cleanup_script "$name")
  if [[ -z "$script_name" ]]; then
    log_error "不明なステップ: $name"
    return 1
  fi

  local script_path="$SCRIPT_DIR/scripts/$script_name"
  if [[ ! -f "$script_path" ]]; then
    log_error "スクリプトが見つかりません: $script_path"
    return 1
  fi

  log_info "クリーンアップ実行中: $name"
  # スクリプトをsourceし、cleanup関数を実行
  if bash -c "source '$script_path' && cleanup" 2>&1 | tee -a "$LOG_FILE"; then
    log_success "$name のクリーンアップが完了しました"
    return 0
  else
    log_error "$name のクリーンアップが失敗しました"
    return 1
  fi
}

# メイン処理
main() {
  local mode="all"
  local selected_steps=()
  local skip_steps=()

  # オプション解析
  while [[ $# -gt 0 ]]; do
    case $1 in
    -h | --help)
      show_help
      exit 0
      ;;
    -l | --list)
      list_steps
      exit 0
      ;;
    -o | --only)
      mode="only"
      shift
      while [[ $# -gt 0 ]] && [[ ! "$1" =~ ^- ]]; do
        selected_steps+=("$1")
        shift
      done
      ;;
    -s | --skip)
      mode="skip"
      shift
      while [[ $# -gt 0 ]] && [[ ! "$1" =~ ^- ]]; do
        skip_steps+=("$1")
        shift
      done
      ;;
    *)
      log_error "不明なオプション: $1"
      show_help
      exit 1
      ;;
    esac
  done

  # ログファイルの初期化
  echo "クリーンアップ開始: $(date)" >"$LOG_FILE"

  log_section "dotfiles クリーンアップ"
  log_info "ログファイル: $LOG_FILE"

  # 実行するステップの決定
  local steps_to_run=()
  case $mode in
  "only")
    steps_to_run=("${selected_steps[@]}")
    ;;
  "skip")
    for step in "${DEFAULT_ORDER[@]}"; do
      local skip=false
      for skip_step in "${skip_steps[@]}"; do
        if [[ "$step" == "$skip_step" ]]; then
          skip=true
          break
        fi
      done
      if [[ "$skip" == false ]]; then
        steps_to_run+=("$step")
      fi
    done
    ;;
  *)
    steps_to_run=("${DEFAULT_ORDER[@]}")
    ;;
  esac

  # ステップの実行
  local failed_steps=()
  for step in "${steps_to_run[@]}"; do
    if ! run_cleanup "$step"; then
      failed_steps+=("$step")
    fi
    echo
  done

  # 結果表示
  if [[ ${#failed_steps[@]} -eq 0 ]]; then
    log_success "すべてのクリーンアップが完了しました！"
  else
    log_error "以下のステップで失敗しました:"
    for step in "${failed_steps[@]}"; do
      echo "  - $step"
    done
    exit 1
  fi
}

main "$@"
