#!/bin/bash

set -euo pipefail

# 共通ライブラリの読み込み
if [[ -z "${SCRIPT_DIR:-}" ]]; then
    readonly SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
fi
source "$SCRIPT_DIR/_common.sh"

# 定数定義
readonly CLAUDE_DIR="$HOME/.claude"
readonly DOTFILES_CLAUDE_DIR="$SCRIPT_DIR/claude"
readonly AGENTS_DIR="$CLAUDE_DIR/agents"
readonly SOURCE_AGENTS_DIR="$DOTFILES_CLAUDE_DIR/agents"

# エージェントディレクトリのシンボリックリンク作成
setup_agent_symlinks() {
    if [ ! -d "$SOURCE_AGENTS_DIR" ]; then
        log_warn "エージェントディレクトリが見つかりません: $SOURCE_AGENTS_DIR"
        return 0
    fi
    
    # 既存のagentsディレクトリを削除
    if [ -e "$AGENTS_DIR" ]; then
        log_info "既存のagentsディレクトリを削除: $AGENTS_DIR"
        rm -rf "$AGENTS_DIR"
    fi
    
    # agentsディレクトリ自体をシンボリックリンクとして作成
    create_symlink "$SOURCE_AGENTS_DIR" "$AGENTS_DIR" "agentsディレクトリ"
}

# メイン処理
main() {
    print_section "Claude Code セットアップ"
    
    # 必要なディレクトリの作成
    create_directory "$CLAUDE_DIR"
    
    # 設定ファイルのシンボリックリンク作成
    create_symlink "$DOTFILES_CLAUDE_DIR/CLAUDE.md" "$CLAUDE_DIR/CLAUDE.md" "CLAUDE.md"
    create_symlink "$DOTFILES_CLAUDE_DIR/settings.json" "$CLAUDE_DIR/settings.json" "settings.json"
    
    # エージェントファイルのシンボリックリンク作成
    setup_agent_symlinks
    
    print_completion "Claude Code セットアップ"
}

# スクリプト実行
main "$@"