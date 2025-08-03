#!/bin/bash

set -euo pipefail

# 定数定義
readonly SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
readonly LOG_FILE="$SCRIPT_DIR/setup.log"

# 共通ライブラリの読み込み
source "$SCRIPT_DIR/_common.sh"

# セットアップステップ定義
# 連想配列の代わりに関数を使用（bash/zsh互換）
get_setup_script() {
    case "$1" in
        "packages") echo "_install-packages.sh" ;;
        "oh-my-zsh") echo "_install-oh-my-zsh.sh" ;;
        "fzf") echo "_install-fzf.sh" ;;
        "volta") echo "_install-volta.sh" ;;
        "git") echo "_setup-git.sh" ;;
        "neovim") echo "_setup-neovim.sh" ;;
        "claude") echo "_setup-claude.sh" ;;
        *) echo "" ;;
    esac
}

# デフォルトのステップ順序
readonly DEFAULT_STEPS=(
    "packages"
    "oh-my-zsh"
    "fzf"
    "volta"
    "git"
    "neovim"
    "claude"
)

# ログファイル付きのログ関数（オーバーライド）
log_info() {
    local message="$1"
    echo -e "\033[0;32m[INFO]\033[0m $message" | tee -a "$LOG_FILE"
}

log_warn() {
    local message="$1"
    echo -e "\033[0;33m[WARN]\033[0m $message" | tee -a "$LOG_FILE"
}

log_error() {
    local message="$1"
    echo -e "\033[0;31m[ERROR]\033[0m $message" | tee -a "$LOG_FILE"
}

log_success() {
    local message="$1"
    echo -e "\033[0;36m[SUCCESS]\033[0m $message" | tee -a "$LOG_FILE"
}

# ヘルプメッセージ表示
show_help() {
    cat << EOF
使用方法: $0 [オプション] [ステップ...]

オプション:
    -h, --help     このヘルプメッセージを表示
    -l, --list     利用可能なセットアップステップを表示
    -s, --skip     指定したステップをスキップ
    -o, --only     指定したステップのみ実行

ステップ:
EOF
    for step in "${DEFAULT_STEPS[@]}"; do
        echo "    $step"
    done
    echo
    echo "例:"
    echo "  $0                    # すべてのステップを実行"
    echo "  $0 --only packages    # packagesステップのみ実行"
    echo "  $0 --skip volta       # voltaステップをスキップ"
}

# 利用可能なステップを表示
list_steps() {
    log_info "利用可能なセットアップステップ:"
    for step in "${DEFAULT_STEPS[@]}"; do
        local script=$(get_setup_script "$step")
        echo "  - $step ($script)"
    done
}

# スクリプトの存在確認
check_script_exists() {
    local script="$1"
    local script_path="$SCRIPT_DIR/$script"
    
    if [ ! -f "$script_path" ]; then
        log_error "スクリプトが見つかりません: $script_path"
        return 1
    fi
    
    ensure_executable "$script_path"
    return 0
}

# セットアップステップの実行
run_setup_step() {
    local step_name="$1"
    local script=$(get_setup_script "$step_name")
    
    log_info "========== $step_name セットアップ開始 =========="
    
    if ! check_script_exists "$script"; then
        log_error "$step_name のセットアップをスキップします"
        return 1
    fi
    
    if (cd "$SCRIPT_DIR" && source "./$script"); then
        log_success "$step_name のセットアップが完了しました"
    else
        log_error "$step_name のセットアップが失敗しました"
        return 1
    fi
    
    echo
}

# メイン処理
main() {
    local skip_steps=()
    local only_steps=()
    local mode="all"
    
    # オプション解析
    while [[ $# -gt 0 ]]; do
        case $1 in
            -h|--help)
                show_help
                exit 0
                ;;
            -l|--list)
                list_steps
                exit 0
                ;;
            -s|--skip)
                mode="skip"
                shift
                while [[ $# -gt 0 ]] && [[ ! "$1" =~ ^- ]]; do
                    skip_steps+=("$1")
                    shift
                done
                ;;
            -o|--only)
                mode="only"
                shift
                while [[ $# -gt 0 ]] && [[ ! "$1" =~ ^- ]]; do
                    only_steps+=("$1")
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
    echo "セットアップ開始: $(date)" > "$LOG_FILE"
    
    log_info "dotfiles セットアップを開始します..."
    log_info "ログファイル: $LOG_FILE"
    echo
    
    # OS情報を表示
    show_os_info
    echo
    
    # 実行するステップの決定
    local steps_to_run=()
    
    case $mode in
        "only")
            steps_to_run=("${only_steps[@]}")
            ;;
        "skip")
            for step in "${DEFAULT_STEPS[@]}"; do
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
            steps_to_run=("${DEFAULT_STEPS[@]}")
            ;;
    esac
    
    # ステップの実行
    local failed_steps=()
    
    for step in "${steps_to_run[@]}"; do
        local script_check=$(get_setup_script "$step")
        if [[ -z "$script_check" ]]; then
            log_error "未知のステップ: $step"
            failed_steps+=("$step")
            continue
        fi
        
        if ! run_setup_step "$step"; then
            failed_steps+=("$step")
        fi
    done
    
    # 結果表示
    echo
    if [ ${#failed_steps[@]} -eq 0 ]; then
        log_success "すべてのセットアップが正常に完了しました！"
    else
        log_error "以下のステップで失敗しました:"
        for step in "${failed_steps[@]}"; do
            echo "  - $step"
        done
        exit 1
    fi
}

# スクリプト実行
main "$@"