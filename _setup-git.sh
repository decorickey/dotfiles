#!/bin/bash

set -euo pipefail

# 共通ライブラリの読み込み
if [[ -z "${SCRIPT_DIR:-}" ]]; then
    readonly SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
fi
source "$SCRIPT_DIR/_common.sh"

# 定数定義
readonly GITMESSAGE_FILE="$SCRIPT_DIR/.gitmessage.txt"

# git設定の適用
apply_git_config() {
    local config_name="$1"
    local config_value="$2"
    local description="${3:-}"
    
    # 現在の設定値を取得
    local current_value=$(git config --global "$config_name" 2>/dev/null || echo "")
    
    if [[ "$current_value" == "$config_value" ]]; then
        log_info "$config_name は既に設定されています: $config_value"
    else
        if git config --global "$config_name" "$config_value"; then
            if [[ -n "$description" ]]; then
                log_success "$description を設定しました: $config_value"
            else
                log_success "$config_name を設定しました: $config_value"
            fi
            
            if [[ -n "$current_value" ]]; then
                log_info "  (変更前: $current_value)"
            fi
        else
            log_error "$config_name の設定に失敗しました"
            return 1
        fi
    fi
}

# コミットテンプレートの設定
setup_commit_template() {
    if [[ ! -f "$GITMESSAGE_FILE" ]]; then
        log_warn "コミットテンプレートファイルが見つかりません: $GITMESSAGE_FILE"
        log_info "コミットテンプレートの設定をスキップします"
        return 0
    fi
    
    apply_git_config "commit.template" "$GITMESSAGE_FILE" "コミットテンプレート"
}

# エディタの確認と設定
setup_editor() {
    # nvimの存在確認
    if ! command_exists nvim; then
        log_warn "nvimがインストールされていません"
        log_info "デフォルトのエディタ設定をスキップします"
        return 0
    fi
    
    apply_git_config "core.editor" "nvim" "デフォルトエディタ"
}

# 推奨されるgit設定
apply_recommended_configs() {
    log_info "推奨されるgit設定を適用します..."
    
    # push設定
    apply_git_config "push.autoSetupRemote" "true" "自動リモート設定"
    
    # pull設定
    apply_git_config "pull.rebase" "false" "pullのデフォルト動作（merge）"
    
    # 色設定
    apply_git_config "color.ui" "auto" "カラー出力"
    
    # エイリアス設定（オプション）
    setup_useful_aliases
}

# 便利なエイリアスの設定
setup_useful_aliases() {
    log_info "便利なgitエイリアスを設定します..."
    
    local aliases=(
        "st:status"
        "co:checkout"
        "br:branch"
        "ci:commit"
        "lg:log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit"
        "last:log -1 HEAD"
        "unstage:reset HEAD --"
    )
    
    for alias_def in "${aliases[@]}"; do
        local alias_name="${alias_def%%:*}"
        local alias_command="${alias_def#*:}"
        
        apply_git_config "alias.$alias_name" "$alias_command" "エイリアス '$alias_name'"
    done
}

# 現在の設定を表示
show_current_config() {
    log_info ""
    log_info "現在のgit設定:"
    echo "----------------------------------------"
    git config --global --list | grep -E "(user\.|core\.|commit\.|push\.|pull\.|alias\.)" | sort
    echo "----------------------------------------"
}

# メイン処理
main() {
    print_section "Git設定"
    
    # gitの確認
    require_command git "先にパッケージのセットアップを実行してください" || exit 1
    show_command_version git
    
    # 各種設定の適用
    setup_commit_template
    setup_editor
    apply_recommended_configs
    
    # 設定の表示
    show_current_config
    
    print_completion "Git設定"
}

# スクリプト実行
main "$@"