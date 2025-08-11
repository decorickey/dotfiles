#!/usr/bin/env bash
#
# 02_shell.sh - シェル環境のセットアップ
# Oh My Zshとfzfのインストール・設定を行います
# 依存: 01_packages.sh (gitコマンドが必要)
#

set -euo pipefail

readonly SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
readonly ROOT_DIR="$(dirname "$SCRIPT_DIR")"

# 必要なライブラリを読み込む
source "$ROOT_DIR/scripts/common.sh"
source "$ROOT_DIR/scripts/logging.sh"

# 定数定義
readonly FEATURE_NAME="Shell Environment"
readonly OH_MY_ZSH_DIR="$HOME/.oh-my-zsh"
readonly FZF_DIR="$HOME/.fzf"

# Oh My Zshのインストール
install_oh_my_zsh() {
    log_info "Installing Oh My Zsh..."
    
    if [[ -d "$OH_MY_ZSH_DIR" ]]; then
        log_info "Oh My Zsh is already installed"
        return 0
    fi
    
    # インストールスクリプトの実行（対話モードを無効化）
    if sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended; then
        log_success "Oh My Zsh installed successfully"
        
        # デフォルトシェルをzshに変更する提案
        if [[ "$SHELL" != *"zsh"* ]]; then
            log_info "To change your default shell to zsh, run: chsh -s $(which zsh)"
        fi
    else
        log_error "Failed to install Oh My Zsh"
        return 1
    fi
}

# fzfのインストール
install_fzf() {
    log_info "Installing fzf..."
    
    if [[ -d "$FZF_DIR" ]]; then
        log_info "fzf is already installed"
        # 最新版に更新
        (cd "$FZF_DIR" && git pull)
    else
        # GitHubからクローン
        if ! git clone --depth 1 https://github.com/junegunn/fzf.git "$FZF_DIR"; then
            log_error "Failed to clone fzf repository"
            return 1
        fi
    fi
    
    # インストールスクリプトの実行
    if "$FZF_DIR/install" --all --no-bash --no-fish >/dev/null 2>&1; then
        log_success "fzf installed successfully"
    else
        log_error "Failed to install fzf"
        return 1
    fi
}

# fzf設定の追加
setup_fzf_config() {
    log_info "Setting up fzf configuration..."
    
    # fzfのデフォルトオプション設定
    local fzf_config='# fzf configuration
export FZF_DEFAULT_OPTS="--height 40% --layout=reverse --border"
export FZF_DEFAULT_COMMAND="fd --type f --hidden --follow --exclude .git"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"'
    
    # zshrcに設定を追加
    local zshrc="$HOME/.zshrc"
    if [[ -f "$zshrc" ]]; then
        if ! grep -q "FZF_DEFAULT_OPTS" "$zshrc"; then
            echo "" >> "$zshrc"
            echo "$fzf_config" >> "$zshrc"
            log_info "Added fzf configuration to .zshrc"
        fi
    fi
}

# シェル環境の検証
verify_installation() {
    log_info "Verifying shell environment setup..."
    
    local has_error=false
    
    # Oh My Zshの確認
    if [[ ! -d "$OH_MY_ZSH_DIR" ]]; then
        log_error "Oh My Zsh directory not found"
        has_error=true
    fi
    
    # fzfの確認
    if [[ ! -d "$FZF_DIR" ]]; then
        log_error "fzf directory not found"
        has_error=true
    fi
    
    # fzfコマンドの確認
    if ! command_exists fzf; then
        log_warn "fzf command not found in PATH"
        log_info "You may need to restart your shell or source ~/.zshrc"
    fi
    
    if [[ "$has_error" == true ]]; then
        return 1
    fi
    
    return 0
}

# メイン処理
main() {
    log_section "$FEATURE_NAME Setup"
    
    # 依存関係の確認
    if ! command_exists git; then
        log_error "git is required but not installed"
        log_info "Please run 01_packages.sh first"
        return 1
    fi
    
    # Oh My Zshのインストール
    if ! install_oh_my_zsh; then
        log_error "Failed to install Oh My Zsh"
        return 1
    fi
    
    # fzfのインストール
    if ! install_fzf; then
        log_error "Failed to install fzf"
        return 1
    fi
    
    # fzf設定の追加
    setup_fzf_config
    
    # インストール検証
    if ! verify_installation; then
        log_error "Installation verification failed"
        return 1
    fi
    
    log_success "$FEATURE_NAME setup completed!"
    log_info "Please restart your shell to apply changes"
    return 0
}

main "$@"