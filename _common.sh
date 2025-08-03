#!/bin/bash

# ============================================================================
# 共通ライブラリ
# ============================================================================
# このファイルは他のセットアップスクリプトで使用される共通関数を提供します
# 使用方法: source ./_common.sh

# エラーハンドリング設定
set -euo pipefail

# ============================================================================
# 定数定義
# ============================================================================

# OS判定
: ${OS:="$(uname)"}
: ${IS_MACOS:=$([[ "$OS" == "Darwin" ]] && echo true || echo false)}
: ${IS_LINUX:=$([[ "$OS" == "Linux" ]] && echo true || echo false)}

# シェル設定ファイルリスト
SHELL_CONFIG_FILES=(
    "$HOME/.profile"
    "$HOME/.bash_profile"
    "$HOME/.bashrc"
    "$HOME/.zprofile"
    "$HOME/.zshrc"
)

# ============================================================================
# ログ出力関数
# ============================================================================

# 情報メッセージ
log_info() {
    echo -e "\033[0;32m[INFO]\033[0m $*"
}

# 警告メッセージ
log_warn() {
    echo -e "\033[0;33m[WARN]\033[0m $*"
}

# エラーメッセージ
log_error() {
    echo -e "\033[0;31m[ERROR]\033[0m $*"
}

# 成功メッセージ
log_success() {
    echo -e "\033[0;36m[SUCCESS]\033[0m $*"
}

# デバッグメッセージ（DEBUG環境変数が設定されている場合のみ）
log_debug() {
    if [[ -n "${DEBUG:-}" ]]; then
        echo -e "\033[0;35m[DEBUG]\033[0m $*"
    fi
}

# ============================================================================
# OS判定関数
# ============================================================================

# macOSかどうか
is_macos() {
    [[ "$IS_MACOS" == true ]]
}

# Linuxかどうか
is_linux() {
    [[ "$IS_LINUX" == true ]]
}

# サポートされているOSかどうか
is_supported_os() {
    is_macos || is_linux
}

# OS情報を表示
show_os_info() {
    log_info "OS: $OS"
    if is_macos; then
        log_info "macOS バージョン: $(sw_vers -productVersion)"
    elif is_linux; then
        if [[ -f /etc/os-release ]]; then
            log_info "Linux ディストリビューション: $(grep PRETTY_NAME /etc/os-release | cut -d'"' -f2)"
        fi
    fi
}

# ============================================================================
# コマンド存在確認
# ============================================================================

# コマンドが存在するかチェック
command_exists() {
    command -v "$1" &>/dev/null
}

# 必須コマンドの確認（エラーで終了）
require_command() {
    local cmd="$1"
    local message="${2:-}"
    
    if ! command_exists "$cmd"; then
        log_error "$cmd がインストールされていません"
        if [[ -n "$message" ]]; then
            log_info "$message"
        fi
        return 1
    fi
}

# コマンドのバージョンを表示
show_command_version() {
    local cmd="$1"
    local version_flag="${2:---version}"
    
    if command_exists "$cmd"; then
        local version=$("$cmd" "$version_flag" 2>&1 | head -n1)
        log_info "$cmd バージョン: $version"
    fi
}

# ============================================================================
# パッケージマネージャー
# ============================================================================

# 利用可能なパッケージマネージャーを取得
get_package_manager() {
    if command_exists brew; then
        echo "brew"
    elif command_exists apt-get; then
        echo "apt-get"
    elif command_exists yum; then
        echo "yum"
    elif command_exists dnf; then
        echo "dnf"
    else
        echo ""
    fi
}

# パッケージをインストール
install_package() {
    local package="$1"
    local pm=$(get_package_manager)
    
    case "$pm" in
        brew)
            brew install "$package"
            ;;
        apt-get)
            sudo apt-get update && sudo apt-get install -y "$package"
            ;;
        yum)
            sudo yum install -y "$package"
            ;;
        dnf)
            sudo dnf install -y "$package"
            ;;
        *)
            log_error "サポートされているパッケージマネージャーが見つかりません"
            return 1
            ;;
    esac
}

# ============================================================================
# ファイル操作
# ============================================================================

# ディレクトリを作成（既存の場合はスキップ）
create_directory() {
    local dir="$1"
    
    if [[ ! -d "$dir" ]]; then
        mkdir -p "$dir"
        log_info "ディレクトリを作成しました: $dir"
    else
        log_debug "ディレクトリは既に存在します: $dir"
    fi
}

# シンボリックリンクを作成
create_symlink() {
    local source="$1"
    local target="$2"
    local description="${3:-ファイル}"
    
    if [[ ! -e "$source" ]]; then
        log_error "ソースが存在しません: $source"
        return 1
    fi
    
    # 既存のリンクまたはファイルを削除
    if [[ -e "$target" ]] || [[ -L "$target" ]]; then
        rm -rf "$target"
    fi
    
    if ln -sf "$source" "$target"; then
        log_success "${description}のシンボリックリンクを作成しました: $source -> $target"
    else
        log_error "シンボリックリンクの作成に失敗しました"
        return 1
    fi
}

# ファイルのバックアップを作成
backup_file() {
    local file="$1"
    
    if [[ -f "$file" ]] && [[ ! -L "$file" ]]; then
        local backup="${file}.backup.$(date +%Y%m%d_%H%M%S)"
        cp "$file" "$backup"
        log_info "バックアップを作成しました: $backup"
        echo "$backup"
    fi
}

# ============================================================================
# シェル設定
# ============================================================================

# シェル設定ファイルに行を追加
add_to_shell_config() {
    local line="$1"
    local comment="${2:-}"
    local added=false
    
    for config in "${SHELL_CONFIG_FILES[@]}"; do
        if [[ -f "$config" ]]; then
            if ! grep -Fxq "$line" "$config"; then
                if [[ -n "$comment" ]]; then
                    echo "" >> "$config"
                    echo "# $comment" >> "$config"
                fi
                echo "$line" >> "$config"
                log_info "$config に設定を追加しました"
                added=true
            else
                log_debug "$config には既に設定が存在します"
            fi
        fi
    done
    
    if [[ "$added" == false ]]; then
        log_debug "設定の追加対象となるシェル設定ファイルが見つかりませんでした"
    fi
}

# パスを追加
add_to_path() {
    local new_path="$1"
    local comment="${2:-PATH設定}"
    
    add_to_shell_config "export PATH=\"$new_path:\$PATH\"" "$comment"
    
    # 現在のセッションにも反映
    export PATH="$new_path:$PATH"
}

# 環境変数を設定
set_env_var() {
    local var_name="$1"
    local var_value="$2"
    local comment="${3:-環境変数設定}"
    
    add_to_shell_config "export $var_name=\"$var_value\"" "$comment"
    
    # 現在のセッションにも反映
    export "$var_name=$var_value"
}

# ============================================================================
# 依存関係チェック
# ============================================================================

# Homebrewの確認とセットアップ
ensure_homebrew() {
    if is_macos; then
        local brew_prefix="/opt/homebrew"
        local brew_path="$brew_prefix/bin/brew"
    elif is_linux; then
        local brew_prefix="/home/linuxbrew/.linuxbrew"
        local brew_path="$brew_prefix/bin/brew"
    else
        log_error "未対応のOS: $OS"
        return 1
    fi
    
    if command_exists brew; then
        log_debug "Homebrewは既にインストールされています"
        return 0
    elif [[ -x "$brew_path" ]]; then
        log_info "Homebrewが見つかりました: $brew_path"
        eval "$("$brew_path" shellenv)"
        return 0
    else
        log_error "Homebrewがインストールされていません"
        log_info "先にパッケージのセットアップを実行してください"
        return 1
    fi
}

# ============================================================================
# ユーティリティ関数
# ============================================================================

# 確認プロンプト
confirm() {
    local message="${1:-続行しますか？}"
    local default="${2:-n}"
    
    local prompt
    if [[ "$default" == "y" ]]; then
        prompt="$message [Y/n]: "
    else
        prompt="$message [y/N]: "
    fi
    
    read -r -p "$prompt" response
    response=${response:-$default}
    
    [[ "$response" =~ ^[Yy]$ ]]
}

# 一時ディレクトリを作成してクリーンアップ
with_temp_dir() {
    local callback="$1"
    local temp_dir=$(mktemp -d)
    
    log_debug "一時ディレクトリを作成しました: $temp_dir"
    
    # コールバック実行
    if (cd "$temp_dir" && eval "$callback"); then
        rm -rf "$temp_dir"
        log_debug "一時ディレクトリを削除しました: $temp_dir"
        return 0
    else
        rm -rf "$temp_dir"
        log_debug "一時ディレクトリを削除しました: $temp_dir"
        return 1
    fi
}

# スクリプトの実行権限を確認・付与
ensure_executable() {
    local script="$1"
    
    if [[ ! -x "$script" ]]; then
        chmod +x "$script"
        log_debug "実行権限を付与しました: $script"
    fi
}

# ============================================================================
# メッセージ表示
# ============================================================================

# セクション区切り
print_section() {
    local title="$1"
    echo
    echo "========================================"
    echo "  $title"
    echo "========================================"
    echo
}

# 完了メッセージ
print_completion() {
    local task="$1"
    echo
    log_success "$task が完了しました！"
    echo
}

# ============================================================================
# エクスポート
# ============================================================================

# この時点で全ての関数が利用可能になります
log_debug "共通ライブラリをロードしました: _common.sh"