#!/usr/bin/env bash
#
# スクリプト名: 05_tmux.sh
# 説明: tmuxの設定ファイルのセットアップ
# 依存: 01_packages.sh (tmux)
#

set -euo pipefail

readonly SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
readonly ROOT_DIR="$(dirname "$SCRIPT_DIR")"

# 必要なライブラリのみ読み込む
source "$ROOT_DIR/scripts/common.sh"
source "$ROOT_DIR/scripts/logging.sh"

# 定数定義
readonly FEATURE_NAME="tmux"
readonly TMUX_CONF="$HOME/.tmux.conf"
readonly SOURCE_TMUX_CONF="$ROOT_DIR/tmux.conf"

# 関数定義
setup_tmux_config() {
    log_info "Setting up tmux configuration..."
    
    if [[ ! -f "$SOURCE_TMUX_CONF" ]]; then
        log_error "Source tmux configuration not found: $SOURCE_TMUX_CONF"
        return 1
    fi
    
    # シンボリックリンクを作成
    if ! create_symlink "$SOURCE_TMUX_CONF" "$TMUX_CONF" "tmux configuration"; then
        return 1
    fi
    
    return 0
}

show_reload_instructions() {
    log_info ""
    log_info "To reload tmux configuration in existing sessions, run:"
    log_info "  tmux source-file ~/.tmux.conf"
    log_info ""
    log_info "Or press prefix (Ctrl-b) and type:"
    log_info "  :source-file ~/.tmux.conf"
}

verify_installation() {
    log_info "Verifying $FEATURE_NAME installation..."
    
    # tmuxの存在確認
    if ! command_exists tmux; then
        log_error "tmux is not installed"
        return 1
    fi
    
    show_command_version tmux
    
    # 設定ファイルのリンク確認
    if [[ -L "$TMUX_CONF" ]] && [[ -e "$TMUX_CONF" ]]; then
        log_success "tmux configuration is properly linked"
        local link_target=$(readlink "$TMUX_CONF")
        log_info "Configuration linked to: $link_target"
    else
        log_error "tmux configuration link has issues"
        return 1
    fi
    
    return 0
}

# メイン処理
main() {
    log_section "$FEATURE_NAME Setup"
    
    # tmuxの確認
    if ! require_command tmux "Please run 01_packages.sh first"; then
        return 1
    fi
    
    # tmux設定のセットアップ
    if ! setup_tmux_config; then
        log_error "Failed to setup tmux configuration"
        return 1
    fi
    
    if ! verify_installation; then
        log_error "Failed to verify $FEATURE_NAME"
        return 1
    fi
    
    # リロード手順の表示
    show_reload_instructions
    
    log_success "$FEATURE_NAME setup completed!"
    return 0
}

main "$@"