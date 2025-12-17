#!/bin/bash

# 色の定義
MAGENTA=$(tput setaf 5)
GREEN=$(tput setaf 2)
YELLOW=$(tput setaf 3)
RED=$(tput setaf 1)
CYAN=$(tput setaf 6)
BOLD=$(tput bold)
RESET=$(tput sgr0)

# カレントディレクトリのベース名を取得
current_dir=$(basename "$(pwd)")

# モデル名を取得
model_name=""
if [[ -f "$HOME/.claude/settings.json" ]]; then
    model_name=$(grep -o '"model"[[:space:]]*:[[:space:]]*"[^"]*"' "$HOME/.claude/settings.json" | sed 's/.*"model"[[:space:]]*:[[:space:]]*"\([^"]*\)".*/\1/')
fi

# git情報を取得
if git rev-parse --git-dir > /dev/null 2>&1; then
    # ブランチ名を取得
    branch=$(git branch --show-current 2>/dev/null || git rev-parse --short HEAD 2>/dev/null)

    # 変更状態を確認
    staged=""
    unstaged=""
    untracked=""

    # ステージング済みの変更
    if ! git diff --cached --quiet --no-optional-locks 2>/dev/null; then
        staged="${GREEN}●"
    fi

    # 未ステージングの変更
    if ! git diff --quiet --no-optional-locks 2>/dev/null; then
        unstaged="${YELLOW}●"
    fi

    # 未追跡ファイル
    if [ -n "$(git ls-files --other --exclude-standard 2>/dev/null)" ]; then
        untracked="${RED}●"
    fi

    # git情報を組み立て
    git_info=" ${GREEN}[${branch}${staged}${unstaged}${untracked}${GREEN}]"
else
    git_info=""
fi

# モデル情報を組み立て
model_info=""
if [[ -n "$model_name" ]]; then
    model_info=" ${CYAN}[${model_name}]"
fi

# プロンプトを出力（末尾の%は削除）
printf "%s%s%s%s%s%s%s" "${BOLD}${MAGENTA}" "${current_dir}" "${RESET}" "${git_info}" "${model_info}" "${RESET}"
