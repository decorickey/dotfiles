#!/usr/bin/env bash
#
# スクリプト名: 06_volta.sh
# 説明: VoltaのインストールとNode.jsバージョン管理の設定
# 依存: なし (curlが必要)
#

set -euo pipefail

readonly SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
readonly ROOT_DIR="$(dirname "$SCRIPT_DIR")"

# 必要なライブラリのみ読み込む
source "$ROOT_DIR/scripts/common.sh"
source "$ROOT_DIR/scripts/logging.sh"
source "$ROOT_DIR/scripts/shell.sh"

# 定数定義
readonly FEATURE_NAME="Volta"
readonly VOLTA_HOME="${VOLTA_HOME:-$HOME/.volta}"
readonly VOLTA_BIN="$VOLTA_HOME/bin"
readonly VOLTA_INSTALL_URL="https://get.volta.sh"

# 関数定義
check_volta() {
    log_info "Checking Volta installation..."
    
    if command_exists volta; then
        log_info "Volta is already installed"
        show_command_version volta
        return 0
    elif [[ -x "$VOLTA_BIN/volta" ]]; then
        log_info "Volta found at: $VOLTA_BIN/volta"
        setup_volta_path
        return 0
    else
        return 1
    fi
}

setup_volta_path() {
    log_info "Setting up Volta path..."
    
    # 環境変数の設定
    set_env_var "VOLTA_HOME" "$VOLTA_HOME" "Volta configuration"
    add_to_path "\$VOLTA_HOME/bin" "Volta binary path"
    
    # 現在のシェルに反映
    export VOLTA_HOME="$VOLTA_HOME"
    export PATH="$VOLTA_HOME/bin:$PATH"
    
    return 0
}

install_volta() {
    log_info "Installing Volta..."
    log_info "Installation directory: $VOLTA_HOME"
    
    # インストールスクリプトの実行
    if ! curl -fsSL "$VOLTA_INSTALL_URL" | bash -s -- --skip-setup; then
        log_error "Failed to install Volta"
        return 1
    fi
    
    # パス設定
    if ! setup_volta_path; then
        return 1
    fi
    
    log_success "Volta installation completed"
    return 0
}

show_usage_examples() {
    log_info ""
    log_info "Volta usage examples:"
    log_info "  volta install node@latest    # Install latest Node.js"
    log_info "  volta install node@18        # Install Node.js v18"
    log_info "  volta pin node@18            # Pin Node.js v18 for project"
    log_info "  volta list                   # List installed tools"
    log_info "  volta install yarn           # Install Yarn"
    log_info "  volta install pnpm           # Install pnpm"
}

verify_installation() {
    log_info "Verifying $FEATURE_NAME installation..."
    
    if command_exists volta; then
        log_info "Volta installation verified"
        
        # バージョン表示
        volta --version
        
        # インストール済みツールの確認
        log_info ""
        log_info "Checking installed tools..."
        volta list 2>/dev/null || log_info "No tools installed yet"
        
        return 0
    else
        log_error "Volta is not properly installed"
        log_info "Please open a new terminal session and try again"
        return 1
    fi
}

# メイン処理
main() {
    log_section "$FEATURE_NAME Setup"
    
    # curlの確認
    if ! require_command curl "Please install curl first"; then
        return 1
    fi
    
    # Voltaの確認とインストール
    if ! check_volta; then
        if ! install_volta; then
            log_error "Failed to install Volta"
            return 1
        fi
        
        # インストール後の再確認
        if ! check_volta; then
            log_error "Failed to verify Volta installation"
            return 1
        fi
    fi
    
    if ! verify_installation; then
        log_error "Failed to verify $FEATURE_NAME"
        return 1
    fi
    
    # 使用例の表示
    show_usage_examples
    
    log_success "$FEATURE_NAME setup completed!"
    return 0
}

main "$@"