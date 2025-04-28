#!/bin/bash

# Detect the operating system
OS=$(uname)
INSTALL_CMD=""
UPDATE_CMD=""

if [ "$OS" == "Darwin" ]; then
  # macOS specific commands
  if ! which brew &>/dev/null; then
    echo "***** homebrew package manager not found, installing... *****"
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
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
  echo

elif [ -f /etc/debian_version ]; then
  # Debian-based Linux distributions
  sudo apt-get update
  sudo apt-get upgrade
  INSTALL_CMD="sudo apt-get install -y"
  UPDATE_CMD="sudo apt-get upgrade -y"
  SHELL_CONFIG="~/.bashrc"
  echo

elif [ -f /etc/redhat-release ]; then
  # RedHat-based Linux distributions
  sudo yum check-update
  sudo yum update
  INSTALL_CMD="sudo yum install -y"
  UPDATE_CMD="sudo yum upgrade -y"
  SHELL_CONFIG="~/.bashrc"
  echo

else
  echo "***** Unsupported OS *****"
  exit 1
fi
echo

source ./_install-packages.sh
source ./_install-oh-my-zsh.sh
source ./_install-fzf.sh
source ./_install-volta.sh
source ./_setup-git.sh
source ./_setup-neovim.sh
