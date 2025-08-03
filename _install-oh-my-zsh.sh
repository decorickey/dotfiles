#!/bin/bash

set -euo pipefail

# 定数定義
if [[ -z "${SCRIPT_DIR:-}" ]]; then
  readonly SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
fi
readonly OH_MY_ZSH_DIR="$HOME/.oh-my-zsh"
readonly ZSHRC_FILE="$HOME/.zshrc"
readonly DOTFILES_ZSHRC="$HOME/dotfiles/.zshrc"

# 色付きログ出力（親スクリプトから継承されない場合のフォールバック）
if ! type log_info &>/dev/null; then
  log_info() { echo -e "\033[0;32m[INFO]\033[0m $1"; }
  log_warn() { echo -e "\033[0;33m[WARN]\033[0m $1"; }
  log_error() { echo -e "\033[0;31m[ERROR]\033[0m $1"; }
  log_success() { echo -e "\033[0;36m[SUCCESS]\033[0m $1"; }
fi

# zshインストール確認関数
check_and_install_zsh() {
  if command -v zsh &>/dev/null; then
    log_info "zshは既にインストールされています"
    log_info "zshバージョン: $(zsh --version)"
    return 0
  fi

  log_info "zshをインストールします..."

  if command -v brew &>/dev/null; then
    brew install zsh
  elif command -v apt-get &>/dev/null; then
    sudo apt-get update && sudo apt-get install -y zsh
  elif command -v yum &>/dev/null; then
    sudo yum install -y zsh
  else
    log_error "適切なパッケージマネージャが見つかりません"
    return 1
  fi

  log_success "zshのインストールが完了しました"
}

# 現在のシェルを取得する関数
get_current_shell() {
  local current_shell=""

  if [[ -n "${SHELL:-}" ]]; then
    current_shell="$SHELL"
  elif command -v getent &>/dev/null; then
    current_shell=$(getent passwd "$USER" | cut -d: -f7)
  elif command -v dscl &>/dev/null; then
    current_shell=$(dscl . -read ~/ UserShell | awk '{print $2}')
  else
    log_error "現在のシェルを特定できません"
    return 1
  fi

  echo "$current_shell"
}

# デフォルトシェルをzshに変更する関数
set_default_shell_to_zsh() {
  local current_shell
  local zsh_path

  current_shell=$(get_current_shell) || return 1
  zsh_path=$(command -v zsh)

  if [[ "$current_shell" == "$zsh_path" ]]; then
    log_info "デフォルトシェルは既にzshです"
    return 0
  fi

  log_info "デフォルトシェルをzshに変更します..."
  log_info "現在のシェル: $current_shell"
  log_info "変更先: $zsh_path"

  # /etc/shellsにzshが登録されているか確認
  if [[ -f /etc/shells ]] && ! grep -q "^$zsh_path$" /etc/shells; then
    log_warn "$zsh_path が /etc/shells に登録されていません"
    log_info "管理者権限で登録を試みます..."
    echo "$zsh_path" | sudo tee -a /etc/shells
  fi

  # シェルの変更
  if chsh -s "$zsh_path"; then
    log_success "デフォルトシェルをzshに変更しました"
    log_info "変更を反映するには、一度ログアウトしてください"
  else
    log_error "デフォルトシェルの変更に失敗しました"
    return 1
  fi
}

# Oh My Zshをインストールする関数
install_oh_my_zsh() {
  if [[ -d "$OH_MY_ZSH_DIR" ]]; then
    log_info "Oh My Zshは既にインストールされています"
    return 0
  fi

  log_info "Oh My Zshをインストールします..."
  log_info "推奨テーマ: kolo"

  # 非対話的インストール
  RUNZSH=no sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" || {
    log_error "Oh My Zshのインストールに失敗しました"
    return 1
  }

  log_success "Oh My Zshのインストールが完了しました"
}

# dotfiles/.zshrcの読み込み設定
setup_dotfiles_zshrc() {
  if [[ ! -f "$DOTFILES_ZSHRC" ]]; then
    log_warn "dotfiles/.zshrcが見つかりません: $DOTFILES_ZSHRC"
    return 0
  fi

  if [[ ! -f "$ZSHRC_FILE" ]]; then
    log_error ".zshrcが見つかりません: $ZSHRC_FILE"
    return 1
  fi

  local source_line="source $DOTFILES_ZSHRC"

  if grep -Fxq "$source_line" "$ZSHRC_FILE"; then
    log_info ".zshrcには既にdotfiles/.zshrcの読み込み設定があります"
  else
    log_info ".zshrcにdotfiles/.zshrcの読み込み設定を追加します..."
    echo "" >>"$ZSHRC_FILE"
    echo "# Load custom zsh configuration from dotfiles" >>"$ZSHRC_FILE"
    echo "$source_line" >>"$ZSHRC_FILE"
    log_success "設定を追加しました"
  fi
}

# メイン処理
main() {
  log_info "Oh My Zshセットアップを開始します..."

  # zshのインストール確認
  check_and_install_zsh || exit 1

  # デフォルトシェルの変更
  set_default_shell_to_zsh || log_warn "デフォルトシェルの変更をスキップします"

  # Oh My Zshのインストール
  install_oh_my_zsh || exit 1

  # dotfiles/.zshrcの設定
  setup_dotfiles_zshrc || log_warn "dotfiles/.zshrcの設定をスキップします"

  log_success "Oh My Zshセットアップが完了しました"
}

# スクリプト実行
main "$@"

