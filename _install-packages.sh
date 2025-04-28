#!/bin/bash

if ! which brew &>/dev/null; then
  echo "***** homebrew package manager not found, installing... *****"
  NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  echo >>~/.zprofile
  echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >>~/.zprofile
  eval "$(/opt/homebrew/bin/brew shellenv)"
else
  echo "***** homebrew package manager found, updating... *****"
  brew update
fi
INSTALL_CMD="brew install"
UPDATE_CMD="brew upgrade"
SHELL_CONFIG="~/.zprofile"

brew bundle install --file Brewfile
