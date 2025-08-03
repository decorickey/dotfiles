#!/bin/bash

set -euo pipefail

# 共通ライブラリの読み込み
if [[ -z "${SCRIPT_DIR:-}" ]]; then
    readonly SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
fi
source "$SCRIPT_DIR/_common.sh"

# 定数定義
readonly CONFIG_DIR="$HOME/.config"
readonly NVIM_DIR="$CONFIG_DIR/nvim"
readonly LAZYVIM_DIR="$SCRIPT_DIR/lazyvim"
readonly VIMRC_FILE="$SCRIPT_DIR/.vimrc"
readonly IDEAVIMRC_FILE="$HOME/.ideavimrc"

# Neovim関連のディレクトリ
readonly NVIM_DATA_DIR="$HOME/.local/share/nvim"
readonly NVIM_STATE_DIR="$HOME/.local/state/nvim"
readonly NVIM_CACHE_DIR="$HOME/.cache/nvim"

# Neovim関連ディレクトリのクリーンアップ
cleanup_neovim() {
    log_info "Neovim関連ファイルをリセットします..."
    
    local dirs=(
        "$NVIM_DATA_DIR"
        "$NVIM_STATE_DIR"
        "$NVIM_CACHE_DIR"
    )
    
    for dir in "${dirs[@]}"; do
        if [[ -d "$dir" ]]; then
            rm -rf "$dir"
            log_info "削除しました: $dir"
        fi
    done
    
    # 既存のnvim設定ディレクトリの削除
    if [[ -e "$NVIM_DIR" ]]; then
        if [[ -L "$NVIM_DIR" ]]; then
            rm "$NVIM_DIR"
            log_info "既存のシンボリックリンクを削除しました: $NVIM_DIR"
        else
            rm -rf "$NVIM_DIR"
            log_info "既存のディレクトリを削除しました: $NVIM_DIR"
        fi
    fi
}

# LazyVimのセットアップ
setup_lazyvim() {
    if [[ ! -d "$LAZYVIM_DIR" ]]; then
        log_error "LazyVim設定ディレクトリが見つかりません: $LAZYVIM_DIR"
        return 1
    fi
    
    log_info "LazyVimを初期化します..."
    
    # シンボリックリンクの作成
    create_symlink "$LAZYVIM_DIR" "$NVIM_DIR" "LazyVim設定"
}

# IdeaVimのセットアップ
setup_ideavim() {
    if [[ ! -f "$VIMRC_FILE" ]]; then
        log_warn ".vimrcファイルが見つかりません: $VIMRC_FILE"
        log_info "IdeaVimの設定をスキップします"
        return 0
    fi
    
    log_info "IdeaVimを初期化します..."
    
    # 既存のファイルをバックアップ
    backup_file "$IDEAVIMRC_FILE"
    
    # シンボリックリンクの作成
    create_symlink "$VIMRC_FILE" "$IDEAVIMRC_FILE" "IdeaVim設定"
}

# Neovimの初回起動と確認
verify_neovim_setup() {
    log_info "Neovimの設定を確認します..."
    
    # 設定ファイルの存在確認
    if [[ ! -e "$NVIM_DIR/init.lua" ]]; then
        log_error "init.luaが見つかりません"
        return 1
    fi
    
    log_info ""
    log_info "Neovimのセットアップが完了しました！"
    log_info ""
    log_info "初回起動時の注意事項:"
    log_info "  1. nvimを起動すると、LazyVimが自動的にプラグインをインストールします"
    log_info "  2. インストールには時間がかかる場合があります"
    log_info "  3. エラーが表示された場合は、:checkhealth で診断できます"
    log_info ""
    log_info "推奨コマンド:"
    log_info "  nvim              # Neovimを起動"
    log_info "  :LazySync         # プラグインの同期"
    log_info "  :checkhealth      # 健全性チェック"
}

# メイン処理
main() {
    print_section "Neovimセットアップ"
    
    # Neovimの確認
    require_command nvim "先にパッケージのセットアップを実行してください" || exit 1
    show_command_version nvim "--version | head -n1"
    
    # クリーンアップ
    cleanup_neovim
    
    # 設定ディレクトリの準備
    create_directory "$CONFIG_DIR"
    
    # LazyVimのセットアップ
    setup_lazyvim || exit 1
    
    # IdeaVimのセットアップ
    setup_ideavim || log_warn "IdeaVimのセットアップをスキップしました"
    
    # セットアップの確認
    verify_neovim_setup
    
    print_completion "Neovimセットアップ"
}

# スクリプト実行
main "$@"