#!/bin/bash

if ! which brew &>/dev/null; then
  echo "***** homebrew package manager not found, installing... *****"
  NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

  if [[ "$(uname)" == "Darwin" ]]; then
    echo >>~/.zshrc
    echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >>~/.zshrc
    eval "$(/opt/homebrew/bin/brew shellenv)"
  elif [[ "$(uname)" == "Linux" ]]; then
    echo >>~/.bashrc
    echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"' >>~/.bashrc
    echo >>~/.zshrc
    echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"' >>~/.zshrc
    eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
  fi
else
  echo "***** homebrew package manager found, updating... *****"
  brew update
fi
INSTALL_CMD="brew install"
UPDATE_CMD="brew upgrade"
SHELL_CONFIG="~/.zprofile"

brew bundle install --file Brewfile
