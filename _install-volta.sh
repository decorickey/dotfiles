#!/bin/bash

set -euo pipefail

# 定数定義
if [[ -z "${SCRIPT_DIR:-}" ]]; then
  readonly SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
fi
readonly VOLTA_HOME="${VOLTA_HOME:-$HOME/.volta}"
readonly VOLTA_BIN="$VOLTA_HOME/bin"
readonly VOLTA_INSTALL_URL="https://get.volta.sh"

# 色付きログ出力（親スクリプトから継承されない場合のフォールバック）
if ! type log_info &>/dev/null; then
  log_info() { echo -e "\033[0;32m[INFO]\033[0m $1"; }
  log_warn() { echo -e "\033[0;33m[WARN]\033[0m $1"; }
  log_error() { echo -e "\033[0;31m[ERROR]\033[0m $1"; }
  log_success() { echo -e "\033[0;36m[SUCCESS]\033[0m $1"; }
fi

# curlの存在確認
check_curl() {
  if ! command -v curl &>/dev/null; then
    log_error "curlがインストールされていません"
    log_info "先にパッケージのセットアップを実行してください"
    return 1
  fi
  return 0
}

# Voltaの存在確認
check_volta() {
  if command -v volta &>/dev/null; then
    log_info "Voltaは既にインストールされています"
    log_info "Voltaバージョン: $(volta --version)"
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
  local shell_configs=(
    "$HOME/.bashrc"
    "$HOME/.zshrc"
    "$HOME/.profile"
    "$HOME/.bash_profile"
  )

  local volta_path_export="export VOLTA_HOME=\"$VOLTA_HOME\""
  local volta_bin_export="export PATH=\"\$VOLTA_HOME/bin:\$PATH\""

  log_info "Voltaのパスを設定します..."

  for config in "${shell_configs[@]}"; do
    if [[ -f "$config" ]]; then
      local updated=false

      # VOLTA_HOMEの設定確認
      if ! grep -q "VOLTA_HOME" "$config"; then
        echo "" >>"$config"
        echo "# Volta configuration" >>"$config"
        echo "$volta_path_export" >>"$config"
        updated=true
      fi

      # PATHの設定確認
      if ! grep -q "\$VOLTA_HOME/bin" "$config"; then
        echo "$volta_bin_export" >>"$config"
        updated=true
      fi

      if [[ "$updated" == true ]]; then
        log_info "$config にVoltaのパスを追加しました"
      else
        log_info "$config には既にVoltaのパスが設定されています"
      fi
    fi
  done

  # 現在のシェルに反映
  export VOLTA_HOME="$VOLTA_HOME"
  export PATH="$VOLTA_HOME/bin:$PATH"
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
  if command -v volta &>/dev/null; then
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
  log_info "Voltaセットアップを開始します..."

  # curlの確認
  check_curl || exit 1

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

  log_success "Voltaセットアップが完了しました"
}

# スクリプト実行
main "$@"

