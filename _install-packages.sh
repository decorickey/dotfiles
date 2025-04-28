#!/bin/bash

set -e

echo "Homebrewインストールスクリプト（修正版・sudo許可版）を開始します..."

OS="$(uname)"

if [[ "$OS" == "Darwin" ]]; then
    echo "macOS (Apple Silicon) が検出されました。"

    if ! command -v brew >/dev/null 2>&1; then
        echo "Homebrewをインストールします（sudoパスワード入力が必要になる場合があります）..."
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    else
        echo "Homebrewはすでにインストールされています。"
    fi

    BREW_ENV='eval "$(/opt/homebrew/bin/brew shellenv)"'

elif [[ "$OS" == "Linux" ]]; then
    echo "Linuxが検出されました。"

    if ! command -v brew >/dev/null 2>&1; then
        echo "必須パッケージをインストールします..."
        sudo apt-get update
        sudo apt-get install -y build-essential curl file git

        echo "Homebrewをインストールします..."
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    else
        echo "Homebrewはすでにインストールされています。"
    fi

    BREW_ENV='eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"'

else
    echo "未対応のOSです: $OS"
    exit 1
fi

# パスを追記する対象ファイルリスト
TARGET_FILES=(
    "$HOME/.profile"
    "$HOME/.bash_profile"
    "$HOME/.zprofile"
    "$HOME/.zshrc"
)

echo "brewパスを設定します..."

for file in "${TARGET_FILES[@]}"; do
    if [ -f "$file" ]; then
        if ! grep -Fxq "$BREW_ENV" "$file"; then
            echo "$BREW_ENV" >> "$file"
            echo "$file にbrewパスを追記しました。"
        else
            echo "$file にはすでにbrewパスが存在します。"
        fi
    fi
done

# 現在のシェル環境にも即反映
echo "現在のシェルにbrewパスを適用します..."
eval "$BREW_ENV"

echo "Homebrewインストールスクリプトが完了しました。"

INSTALL_CMD="brew install"
UPDATE_CMD="brew upgrade"
SHELL_CONFIG="~/.zprofile"

brew bundle install --file Brewfile
