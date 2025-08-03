#!/bin/bash

set -euo pipefail

# 共通ライブラリの読み込み
if [[ -z "${SCRIPT_DIR:-}" ]]; then
    readonly SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
fi
source "$SCRIPT_DIR/_common.sh"

# 定数定義
readonly FZF_DIR="$HOME/.fzf"
readonly FZF_REPO="https://github.com/junegunn/fzf.git"

# fzfのインストール関数
install_fzf() {
    log_info "fzfをインストールします..."
    
    # リポジトリのクローン
    if ! git clone --depth 1 "$FZF_REPO" "$FZF_DIR"; then
        log_error "fzfのクローンに失敗しました"
        return 1
    fi
    
    # インストールスクリプトの実行
    if ! (cd "$FZF_DIR" && ./install --all --no-update-rc); then
        log_error "fzfのインストールに失敗しました"
        return 1
    fi
    
    log_success "fzfのインストールが完了しました"
}

# fzfの更新関数
update_fzf() {
    log_info "fzfを更新します..."
    
    # 作業ディレクトリの保存
    local current_dir=$(pwd)
    
    # fzfディレクトリへ移動
    cd "$FZF_DIR" || {
        log_error "fzfディレクトリへの移動に失敗しました"
        return 1
    }
    
    # 更新の実行
    if git pull; then
        log_info "リポジトリを更新しました"
    else
        log_error "リポジトリの更新に失敗しました"
        cd "$current_dir"
        return 1
    fi
    
    # インストールスクリプトの再実行
    if ./install --all --no-update-rc; then
        log_success "fzfの更新が完了しました"
    else
        log_error "fzfの更新に失敗しました"
        cd "$current_dir"
        return 1
    fi
    
    # 元のディレクトリに戻る
    cd "$current_dir"
}

# シェル設定の確認
check_shell_integration() {
    local integrated=false
    
    for config in "${SHELL_CONFIG_FILES[@]}"; do
        if [[ -f "$config" ]] && grep -q "\.fzf\." "$config"; then
            integrated=true
            log_info "fzfの設定が $config に含まれています"
        fi
    done
    
    if [[ "$integrated" == false ]]; then
        log_warn "fzfのシェル統合が設定されていない可能性があります"
        log_info "手動で以下のコマンドを実行してください:"
        log_info "  ~/.fzf/install"
    fi
}

# メイン処理
main() {
    print_section "fzfセットアップ"
    
    # gitの確認
    require_command git "先にパッケージのセットアップを実行してください" || exit 1
    
    # fzfのインストールまたは更新
    if [[ ! -d "$FZF_DIR" ]]; then
        install_fzf || exit 1
    else
        log_info "fzfは既にインストールされています"
        update_fzf || log_warn "fzfの更新をスキップします"
    fi
    
    # シェル統合の確認
    check_shell_integration
    
    # バージョン情報の表示
    if [[ -f "$FZF_DIR/bin/fzf" ]]; then
        local version=$("$FZF_DIR/bin/fzf" --version 2>/dev/null | head -n1)
        log_info "fzfバージョン: $version"
    fi
    
    print_completion "fzfセットアップ"
}

# スクリプト実行
main "$@"