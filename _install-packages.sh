#!/bin/bash

set -euo pipefail

# 共通ライブラリの読み込み
if [[ -z "${SCRIPT_DIR:-}" ]]; then
    readonly SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
fi
source "$SCRIPT_DIR/_common.sh"

# 定数定義
readonly BREWFILE="$SCRIPT_DIR/Brewfile"

# Homebrewパス設定
if is_macos; then
    readonly BREW_PREFIX="/opt/homebrew"
    readonly BREW_PATH="$BREW_PREFIX/bin/brew"
elif is_linux; then
    readonly BREW_PREFIX="/home/linuxbrew/.linuxbrew"
    readonly BREW_PATH="$BREW_PREFIX/bin/brew"
else
    log_error "未対応のOS: $OS"
    exit 1
fi

# Homebrewインストール関数
install_homebrew() {
    log_info "Homebrewをインストールします..."
    
    if is_linux; then
        # Linux用の依存パッケージインストール
        local pm=$(get_package_manager)
        case "$pm" in
            apt-get)
                log_info "必須パッケージをインストールします..."
                sudo apt-get update
                sudo apt-get install -y build-essential curl file git
                ;;
            yum|dnf)
                log_info "必須パッケージをインストールします..."
                sudo "$pm" groupinstall -y 'Development Tools'
                sudo "$pm" install -y curl file git
                ;;
            *)
                log_warn "パッケージマネージャが見つかりません。手動で依存関係をインストールしてください。"
                ;;
        esac
    fi
    
    # Homebrewインストールスクリプトの実行
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
}

# Homebrewパス設定関数
setup_brew_path() {
    local brew_env="eval \"\$(${BREW_PATH} shellenv)\""
    
    log_info "Homebrewパスを設定します..."
    
    for file in "${SHELL_CONFIG_FILES[@]}"; do
        if [[ -f "$file" ]]; then
            if ! grep -Fxq "$brew_env" "$file"; then
                echo "$brew_env" >> "$file"
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
    if command_exists brew; then
        log_info "Homebrewは既にインストールされています"
        show_command_version brew
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
    print_section "パッケージインストール"
    
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
    
    print_completion "パッケージインストール"
}

# スクリプト実行
main "$@"