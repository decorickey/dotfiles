#!/usr/bin/env bash
#
# dotfiles セットアップスクリプト
# 統一されたインターフェースで各種ツールをセットアップします
#

set -euo pipefail

readonly SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
readonly LOG_FILE="$SCRIPT_DIR/setup.log"

# ライブラリの読み込み
source "$SCRIPT_DIR/scripts/logging.sh"
source "$SCRIPT_DIR/scripts/common.sh"

# セットアップスクリプトの定義（連想配列の代わりに関数を使用）
get_setup_script() {
  case "$1" in
  "packages") echo "packages.sh" ;;
  "shell") echo "shell.sh" ;;
  "git") echo "git.sh" ;;
  "go") echo "go.sh" ;;
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

# デフォルトの実行順序
readonly DEFAULT_ORDER=(packages shell git go neovim tmux volta claude codex gemini vscode)

# ヘルプメッセージ
show_help() {
  cat <<EOF
使用方法: $0 [オプション] [ステップ...]

オプション:
    -h, --help     このヘルプメッセージを表示
    -l, --list     利用可能なセットアップステップを表示
    -o, --only     指定したステップのみ実行
    -s, --skip     指定したステップをスキップ

例:
    $0                    # すべてのステップを実行
    $0 --only packages    # packagesステップのみ実行
    $0 --skip volta       # voltaステップをスキップ
EOF
}

# 利用可能なステップを表示
list_steps() {
  echo "利用可能なセットアップステップ:"
  for step in "${DEFAULT_ORDER[@]}"; do
    echo "  - $step"
  done
}

# セットアップスクリプトを実行
run_script() {
  local name="$1"
  local script_name=$(get_setup_script "$name")
  if [[ -z "$script_name" ]]; then
    log_error "不明なステップ: $name"
    return 1
  fi

  local script="scripts/$script_name"

  if [[ ! -f "$SCRIPT_DIR/$script" ]]; then
    # 古いスクリプトにフォールバック
    local old_script="_setup-$name.sh"
    if [[ -f "$SCRIPT_DIR/$old_script" ]]; then
      script="$old_script"
    else
      old_script="_install-$name.sh"
      if [[ -f "$SCRIPT_DIR/$old_script" ]]; then
        script="$old_script"
      else
        log_error "スクリプトが見つかりません: $name"
        return 1
      fi
    fi
  fi

  log_info "実行中: $name"
  if bash "$SCRIPT_DIR/$script" 2>&1 | tee -a "$LOG_FILE"; then
    log_success "$name が完了しました"
    return 0
  else
    log_error "$name が失敗しました"
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
  echo "セットアップ開始: $(date)" >"$LOG_FILE"

  log_section "dotfiles セットアップ"
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
    if ! run_script "$step"; then
      failed_steps+=("$step")
    fi
    echo
  done

  # 結果表示
  if [[ ${#failed_steps[@]} -eq 0 ]]; then
    log_success "すべてのセットアップが完了しました！"
  else
    log_error "以下のステップで失敗しました:"
    for step in "${failed_steps[@]}"; do
      echo "  - $step"
    done
    exit 1
  fi
}

main "$@"
