#!/bin/bash

set -euo pipefail

# 定数定義
if [[ -z "${SCRIPT_DIR:-}" ]]; then
  readonly SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
fi
readonly BREWFILE="$SCRIPT_DIR/Brewfile"

# OS判定
readonly OS="$(uname)"
readonly IS_MACOS=$([[ "$OS" == "Darwin" ]] && echo true || echo false)
readonly IS_LINUX=$([[ "$OS" == "Linux" ]] && echo true || echo false)

# Homebrewパス設定
if [[ "$IS_MACOS" == true ]]; then
  readonly BREW_PREFIX="/opt/homebrew"
  readonly BREW_PATH="$BREW_PREFIX/bin/brew"
elif [[ "$IS_LINUX" == true ]]; then
  readonly BREW_PREFIX="/home/linuxbrew/.linuxbrew"
  readonly BREW_PATH="$BREW_PREFIX/bin/brew"
else
  echo "エラー: 未対応のOS: $OS" >&2
  exit 1
fi

# 色付きログ出力（親スクリプトから継承されない場合のフォールバック）
if ! type log_info &>/dev/null; then
  log_info() { echo -e "\033[0;32m[INFO]\033[0m $1"; }
  log_warn() { echo -e "\033[0;33m[WARN]\033[0m $1"; }
  log_error() { echo -e "\033[0;31m[ERROR]\033[0m $1"; }
  log_success() { echo -e "\033[0;36m[SUCCESS]\033[0m $1"; }
fi

# Homebrewインストール関数
install_homebrew() {
  log_info "Homebrewをインストールします..."

  if [[ "$IS_LINUX" == true ]]; then
    # Linux用の依存パッケージインストール
    if command -v apt-get &>/dev/null; then
      log_info "必須パッケージをインストールします..."
      sudo apt-get update
      sudo apt-get install -y build-essential curl file git
    elif command -v yum &>/dev/null; then
      log_info "必須パッケージをインストールします..."
      sudo yum groupinstall -y 'Development Tools'
      sudo yum install -y curl file git
    else
      log_warn "パッケージマネージャが見つかりません。手動で依存関係をインストールしてください。"
    fi
  fi

  # Homebrewインストールスクリプトの実行
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
}

# Homebrewパス設定関数
setup_brew_path() {
  local brew_env="eval \"\$(${BREW_PATH} shellenv)\""
  local target_files=(
    "$HOME/.profile"
    "$HOME/.bash_profile"
    "$HOME/.zprofile"
    "$HOME/.zshrc"
  )

  log_info "Homebrewパスを設定します..."

  for file in "${target_files[@]}"; do
    if [[ -f "$file" ]]; then
      if ! grep -Fxq "$brew_env" "$file"; then
        echo "$brew_env" >>"$file"
        log_info "$file にHomebrewパスを追記しました"
      else
        log_info "$file にはすでにHomebrewパスが存在します"
      fi
    fi
  done

  # 現在のシェルにも即座に反映
  eval "$brew_env"
}

# Homebrewの存在確認
check_homebrew() {
  if command -v brew &>/dev/null; then
    log_info "Homebrewは既にインストールされています"
    log_info "Homebrewバージョン: $(brew --version | head -n1)"
    return 0
  elif [[ -x "$BREW_PATH" ]]; then
    log_info "Homebrewが見つかりました: $BREW_PATH"
    setup_brew_path
    return 0
  else
    return 1
  fi
}

# パッケージインストール関数
install_packages() {
  if [[ ! -f "$BREWFILE" ]]; then
    log_error "Brewfileが見つかりません: $BREWFILE"
    return 1
  fi

  log_info "Brewfileからパッケージをインストールします..."

  # Homebrew自体の更新
  log_info "Homebrewを更新しています..."
  brew update

  # Brewfileからインストール
  if brew bundle install --file="$BREWFILE"; then
    log_success "パッケージのインストールが完了しました"
  else
    log_error "一部のパッケージのインストールに失敗しました"
    return 1
  fi

  # クリーンアップ
  log_info "不要なパッケージをクリーンアップしています..."
  brew cleanup
}

# メイン処理
main() {
  log_info "パッケージインストールを開始します..."
  log_info "OS: $OS"

  # Homebrewの確認とインストール
  if ! check_homebrew; then
    install_homebrew
    setup_brew_path

    # インストール後の再確認
    if ! check_homebrew; then
      log_error "Homebrewのインストールに失敗しました"
      exit 1
    fi
  fi

  # パッケージのインストール
  install_packages

  log_success "パッケージインストールが完了しました"
}

# スクリプト実行
main "$@"

