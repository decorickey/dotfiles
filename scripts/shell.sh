#!/usr/bin/env bash
#
# shell.sh - シェル設定関連
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
                echo "" >> "$ZSHRC"
                echo "# $comment" >> "$ZSHRC"
            fi
            echo "$line" >> "$ZSHRC"
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