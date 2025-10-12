#!/usr/bin/env bash
#
# os.sh - OS判定
# macOSとLinuxの判定機能を提供
#

# OS判定
readonly OS="$(uname)"

# OS判定関数
is_macos() {
  [[ "$OS" == "Darwin" ]]
}

is_linux() {
  [[ "$OS" == "Linux" ]]
}

