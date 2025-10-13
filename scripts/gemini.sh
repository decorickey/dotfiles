#!/usr/bin/env bash
#
# gemini.sh - Gemini CLI 用個人ガイダンスのセットアップ
# Gemini CLI のグローバルガイダンスファイルをホームディレクトリにシンボリックリンクします
# 依存: なし
#

set -euo pipefail

readonly SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
readonly ROOT_DIR="$(dirname "$SCRIPT_DIR")"

source "$ROOT_DIR/scripts/common.sh"
source "$ROOT_DIR/scripts/logging.sh"

readonly FEATURE_NAME="Gemini Guidance"
readonly GEMINI_DIR="$HOME/.gemini"
readonly SOURCE_GEMINI_DIR="$ROOT_DIR/.gemini"
readonly GUIDANCE_FILENAME="GEMINI.md"
readonly SOURCE_GUIDANCE_FILE="$SOURCE_GEMINI_DIR/$GUIDANCE_FILENAME"
readonly TARGET_GUIDANCE_FILE="$GEMINI_DIR/$GUIDANCE_FILENAME"

setup_gemini_guidance() {
  log_info "Gemini ガイダンスファイルをセットアップしています..."

  create_directory "$GEMINI_DIR"

  if [[ ! -f "$SOURCE_GUIDANCE_FILE" ]]; then
    log_error "ガイダンスファイルが見つかりません: $SOURCE_GUIDANCE_FILE"
    return 1
  fi

  create_symlink "$SOURCE_GUIDANCE_FILE" "$TARGET_GUIDANCE_FILE" "Gemini guidance"
}

verify_installation() {
  log_info "$FEATURE_NAME を検証しています..."

  if [[ ! -d "$GEMINI_DIR" ]]; then
    log_error "Gemini ディレクトリが存在しません: $GEMINI_DIR"
    return 1
  fi

  if [[ -L "$TARGET_GUIDANCE_FILE" ]] && [[ -f "$TARGET_GUIDANCE_FILE" ]]; then
    log_success "Gemini ガイダンスファイルが正しくリンクされています"
  else
    log_error "Gemini ガイダンスファイルが正しくリンクされていません: $TARGET_GUIDANCE_FILE"
    return 1
  fi
}

show_usage_info() {
  log_info ""
  log_info "Gemini ガイダンスのセットアップが完了しました。"
  log_info ""
  log_info "利用可能なファイル:"
  log_info "  • グローバルガイダンス: $TARGET_GUIDANCE_FILE"
}

cleanup() {
  log_section "Cleaning up $FEATURE_NAME"

  if [[ -L "$TARGET_GUIDANCE_FILE" ]]; then
    rm "$TARGET_GUIDANCE_FILE"
    log_info "Removed Gemini guidance symlink: $TARGET_GUIDANCE_FILE"
  fi

  # ディレクトリが空であれば削除
  if [[ -d "$GEMINI_DIR" ]] && [[ -z "$(ls -A "$GEMINI_DIR")" ]]; then
    rmdir "$GEMINI_DIR"
    log_info "Removed empty directory: $GEMINI_DIR"
  fi

  log_success "$FEATURE_NAME cleanup completed!"
}

main() {
  log_section "$FEATURE_NAME Setup"

  if ! setup_gemini_guidance; then
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
