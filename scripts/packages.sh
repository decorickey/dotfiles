#!/usr/bin/env bash
#
# packages.sh - パッケージマネージャーのセットアップとパッケージインストール
# Homebrewのインストールと、Brewfileを使用したパッケージの一括インストールを行います
# 依存: なし（最初に実行）
#

set -euo pipefail

readonly SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
readonly ROOT_DIR="$(dirname "$SCRIPT_DIR")"

# 必要なライブラリを読み込む
source "$ROOT_DIR/scripts/common.sh"
source "$ROOT_DIR/scripts/logging.sh"
source "$ROOT_DIR/scripts/os.sh"
source "$ROOT_DIR/scripts/shell_utils.sh"

# 定数定義
readonly FEATURE_NAME="Package Manager"
readonly BREWFILE="$ROOT_DIR/Brewfile"

# Homebrewパス設定
if is_macos; then
  readonly BREW_PREFIX="/opt/homebrew"
  readonly BREW_PATH="$BREW_PREFIX/bin/brew"
else
  readonly BREW_PREFIX="/home/linuxbrew/.linuxbrew"
  readonly BREW_PATH="$BREW_PREFIX/bin/brew"
fi

# Homebrewインストール
install_homebrew() {
  log_info "Installing Homebrew..."

  # Homebrewインストールスクリプトの実行
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
}

# Homebrewパス設定
setup_brew_path() {
  local brew_env="eval \"\$(${BREW_PATH} shellenv)\""

  log_info "Setting up Homebrew PATH..."

  # .zshrcに追加
  local zshrc="$HOME/.zshrc"

  if [[ -f "$zshrc" ]]; then
    if ! grep -Fxq "$brew_env" "$zshrc"; then
      echo "$brew_env" >>"$zshrc"
      log_info "Added Homebrew PATH to .zshrc"
    else
      log_info "Homebrew PATH already exists in .zshrc"
    fi
  else
    log_error ".zshrc not found"
    return 1
  fi

  # 現在のシェルにも反映
  eval "$brew_env"
}

# Homebrewの存在確認
check_homebrew() {
  if command_exists brew; then
    log_info "Homebrew is already installed"
    show_command_version brew
    return 0
  elif [[ -x "$BREW_PATH" ]]; then
    log_info "Found Homebrew at: $BREW_PATH"
    setup_brew_path
    return 0
  else
    return 1
  fi
}

# パッケージインストール
install_packages() {
  if [[ ! -f "$BREWFILE" ]]; then
    log_error "Brewfile not found: $BREWFILE"
    return 1
  fi

  log_info "Checking packages from Brewfile..."
  if brew bundle check --file="$BREWFILE" &>/dev/null; then
    log_success "All packages are already installed."
    return 0
  fi

  log_info "Installing packages from Brewfile..."

  # Homebrew自体の更新
  log_info "Updating Homebrew..."
  brew update

  # Brewfileからインストール
  if brew bundle install --file="$BREWFILE"; then
    log_success "Package installation completed"
  else
    log_error "Some packages failed to install"
    return 1
  fi

  # クリーンアップ
  log_info "Cleaning up..."
  brew cleanup
}

# インストール検証
verify_installation() {
  log_info "Verifying Homebrew installation..."

  if ! command_exists brew; then
    log_error "Homebrew command not found"
    return 1
  fi

  # 基本的なコマンドの確認
  local essential_commands=(git tmux nvim)
  local missing_commands=()

  for cmd in "${essential_commands[@]}"; do
    if ! command_exists "$cmd"; then
      missing_commands+=("$cmd")
    fi
  done

  if [[ ${#missing_commands[@]} -gt 0 ]]; then
    log_warn "Some essential commands are missing: ${missing_commands[*]}"
    log_info "Please check the Brewfile and installation logs"
  fi

  return 0
}

# クリーンアップ処理
cleanup() {
  log_section "Cleaning up $FEATURE_NAME"

  if ! command_exists brew; then
    log_warn "brew command not found, skipping cleanup."
    return 0
  fi

  # .zshrcからHomebrewのPATH設定を削除
  remove_from_shell_config "shellenv"

  # パッケージのアンインストール確認
  log_warn "This will uninstall all packages listed in the Brewfile."
  log_warn "This action cannot be undone."
  read -p "Type 'yes' to continue: " -r
  echo
  if [[ "$REPLY" != "yes" ]]; then
    log_info "Skipping package uninstallation."
    return 0
  fi

  log_info "Uninstalling packages from Brewfile..."

  local formulas=$(brew bundle list --file="$BREWFILE" --formula)
  if [[ -n "$formulas" ]]; then
    # shellcheck disable=SC2086
    brew uninstall $formulas
  fi

  local casks=$(brew bundle list --file="$BREWFILE" --cask)
  if [[ -n "$casks" ]]; then
    # shellcheck disable=SC2086
    brew uninstall --cask $casks
  fi

  log_success "$FEATURE_NAME cleanup completed!"
}

# メイン処理
main() {
  log_section "$FEATURE_NAME Setup"

  # Homebrewの確認とインストール
  if ! check_homebrew; then
    if ! install_homebrew; then
      log_error "Failed to install Homebrew"
      return 1
    fi

    setup_brew_path

    # インストール後の再確認
    if ! check_homebrew; then
      log_error "Homebrew installation verification failed"
      return 1
    fi
  fi

  # Homebrew環境のチェック
  log_info "Checking Homebrew environment with 'brew doctor'..."
  if ! brew doctor; then
    log_warn "brew doctor found some issues. Please review them."
    # エラーがあっても続行するが、警告は出す
  fi

  # パッケージのインストール
  if ! install_packages; then
    log_error "Failed to install packages"
    return 1
  fi

  # インストール検証
  if ! verify_installation; then
    log_error "Installation verification failed"
    return 1
  fi

  log_success "$FEATURE_NAME setup completed!"
  return 0
}

main "$@"
