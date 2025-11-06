#!/usr/bin/env bash
#
# codex.sh - Codex 用個人ガイダンスのセットアップ
# Codex グローバルガイダンスファイルのシンボリックリンクをホームディレクトリに作成します
# 依存: なし
#

set -euo pipefail

readonly SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
readonly ROOT_DIR="$(dirname "$SCRIPT_DIR")"

# 共通関数の読み込み
source "$ROOT_DIR/scripts/common.sh"
source "$ROOT_DIR/scripts/logging.sh"

# 定数定義
readonly FEATURE_NAME="Codex Guidance"
readonly CODEX_DIR="$HOME/.codex"
readonly SOURCE_CODEX_DIR="$ROOT_DIR/.codex"
readonly GUIDANCE_FILENAME="AGENTS.md"
readonly SOURCE_GUIDANCE_FILE="$SOURCE_CODEX_DIR/$GUIDANCE_FILENAME"
readonly TARGET_GUIDANCE_FILE="$CODEX_DIR/$GUIDANCE_FILENAME"

setup_codex_guidance() {
  log_info "Codex ガイダンスファイルをセットアップしています..."

  create_directory "$CODEX_DIR"

  if [[ ! -f "$SOURCE_GUIDANCE_FILE" ]]; then
    log_error "ガイダンスファイルが見つかりません: $SOURCE_GUIDANCE_FILE"
    return 1
  fi

  create_symlink "$SOURCE_GUIDANCE_FILE" "$TARGET_GUIDANCE_FILE" "Codex guidance"
}

verify_installation() {
  log_info "$FEATURE_NAME を検証しています..."

  if [[ ! -d "$CODEX_DIR" ]]; then
    log_error "Codex ディレクトリが存在しません: $CODEX_DIR"
    return 1
  fi

  if [[ -L "$TARGET_GUIDANCE_FILE" ]] && [[ -f "$TARGET_GUIDANCE_FILE" ]]; then
    log_success "Codex ガイダンスファイルが正しくリンクされています"
  else
    log_error "Codex ガイダンスファイルが正しくリンクされていません: $TARGET_GUIDANCE_FILE"
    return 1
  fi

}

show_usage_info() {
  log_info ""
  log_info "Codex ガイダンスのセットアップが完了しました。"
  log_info ""
  log_info "利用可能なファイル:"
  log_info "  • グローバルガイダンス: $TARGET_GUIDANCE_FILE"
}

cleanup() {
  log_section "Cleaning up $FEATURE_NAME"

  if [[ -L "$TARGET_GUIDANCE_FILE" ]]; then
    rm "$TARGET_GUIDANCE_FILE"
    log_info "Removed Codex guidance symlink: $TARGET_GUIDANCE_FILE"
  fi

  if [[ -d "$CODEX_DIR" ]] && [[ -z "$(ls -A "$CODEX_DIR")" ]]; then
    rmdir "$CODEX_DIR"
    log_info "Removed empty directory: $CODEX_DIR"
  fi

  log_success "$FEATURE_NAME cleanup completed!"
}

main() {
  log_section "$FEATURE_NAME Setup"

  if ! setup_codex_guidance; then
    log_error "$FEATURE_NAME のセットアップに失敗しました"
    return 1
  fi

  if ! verify_installation; then
    log_error "$FEATURE_NAME の検証に失敗しました"
    return 1
  fi

  show_usage_info

  log_success "$FEATURE_NAME setup completed!"
}

main "$@"
