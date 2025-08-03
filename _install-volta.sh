#!/bin/bash

set -euo pipefail

# 共通ライブラリの読み込み
if [[ -z "${SCRIPT_DIR:-}" ]]; then
    readonly SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
fi
source "$SCRIPT_DIR/_common.sh"

# 定数定義
readonly VOLTA_HOME="${VOLTA_HOME:-$HOME/.volta}"
readonly VOLTA_BIN="$VOLTA_HOME/bin"
readonly VOLTA_INSTALL_URL="https://get.volta.sh"

# Voltaの存在確認
check_volta() {
    if command_exists volta; then
        log_info "Voltaは既にインストールされています"
        show_command_version volta
        return 0
    elif [[ -x "$VOLTA_BIN/volta" ]]; then
        log_info "Voltaが見つかりました: $VOLTA_BIN/volta"
        setup_volta_path
        return 0
    else
        return 1
    fi
}

# Voltaのパス設定
setup_volta_path() {
    log_info "Voltaのパスを設定します..."
    
    # 環境変数の設定
    set_env_var "VOLTA_HOME" "$VOLTA_HOME" "Volta configuration"
    add_to_path "\$VOLTA_HOME/bin" "Volta binary path"
}

# Voltaのインストール
install_volta() {
    log_info "Voltaをインストールします..."
    log_info "インストール先: $VOLTA_HOME"
    
    # インストールスクリプトの実行
    if ! curl -fsSL "$VOLTA_INSTALL_URL" | bash -s -- --skip-setup; then
        log_error "Voltaのインストールに失敗しました"
        return 1
    fi
    
    # パス設定
    setup_volta_path
    
    log_success "Voltaのインストールが完了しました"
}

# Voltaの動作確認
verify_volta() {
    if command_exists volta; then
        log_info "Voltaのインストールを確認しました"
        
        # バージョン表示
        volta --version
        
        # 使用方法の案内
        log_info ""
        log_info "Voltaの使用例:"
        log_info "  volta install node@latest    # 最新のNode.jsをインストール"
        log_info "  volta install node@18        # Node.js v18をインストール"
        log_info "  volta pin node@18            # プロジェクトでNode.js v18を固定"
        log_info "  volta list                   # インストール済みツールの一覧"
        
        return 0
    else
        log_error "Voltaが正しくインストールされていません"
        log_info "新しいターミナルセッションで再度確認してください"
        return 1
    fi
}

# メイン処理
main() {
    print_section "Voltaセットアップ"
    
    # curlの確認
    require_command curl "先にパッケージのセットアップを実行してください" || exit 1
    
    # Voltaの確認とインストール
    if ! check_volta; then
        install_volta || exit 1
        
        # インストール後の再確認
        if ! check_volta; then
            log_error "Voltaのインストールに失敗しました"
            exit 1
        fi
    fi
    
    # 動作確認
    verify_volta || log_warn "Voltaの動作確認に失敗しました"
    
    print_completion "Voltaセットアップ"
}

# スクリプト実行
main "$@"