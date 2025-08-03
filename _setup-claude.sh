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

# エージェントファイルのシンボリックリンク作成
setup_agent_symlinks() {
    if [ ! -d "$SOURCE_AGENTS_DIR" ]; then
        log_warn "エージェントディレクトリが見つかりません: $SOURCE_AGENTS_DIR"
        return 0
    fi
    
    local agent_files=("$SOURCE_AGENTS_DIR"/*.md)
    
    # ファイルが存在しない場合の処理
    if [ ! -e "${agent_files[0]}" ]; then
        log_warn "エージェントファイルが見つかりません: $SOURCE_AGENTS_DIR/*.md"
        return 0
    fi
    
    for agent_file in "${agent_files[@]}"; do
        if [ -f "$agent_file" ]; then
            local filename=$(basename "$agent_file")
            local target_file="$AGENTS_DIR/$filename"
            create_symlink "$agent_file" "$target_file" "エージェント"
        fi
    done
}

# メイン処理
main() {
    print_section "Claude Code セットアップ"
    
    # 必要なディレクトリの作成
    create_directory "$CLAUDE_DIR"
    create_directory "$AGENTS_DIR"
    
    # 設定ファイルのシンボリックリンク作成
    create_symlink "$DOTFILES_CLAUDE_DIR/CLAUDE.md" "$CLAUDE_DIR/CLAUDE.md" "CLAUDE.md"
    create_symlink "$DOTFILES_CLAUDE_DIR/settings.json" "$CLAUDE_DIR/settings.json" "settings.json"
    
    # エージェントファイルのシンボリックリンク作成
    setup_agent_symlinks
    
    print_completion "Claude Code セットアップ"
}

# スクリプト実行
main "$@"