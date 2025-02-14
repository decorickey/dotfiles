#!/bin/bash

# Detect the operating system
OS=$(uname)
INSTALL_CMD=""
UPDATE_CMD=""

if [ "$OS" == "Darwin" ]; then
  # macOS specific commands
  if ! which brew &>/dev/null; then
    echo "***** Install Homebrew *****"
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    echo >>~/.zprofile
    echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >>~/.zprofile
    eval "$(/opt/homebrew/bin/brew shellenv)"
  else
    echo "***** Update Homebrew *****"
    brew update
  fi
  INSTALL_CMD="brew install"
  UPDATE_CMD="brew upgrade"
  SHELL_CONFIG="~/.zprofile"

elif [ -f /etc/debian_version ]; then
  # Debian-based Linux distributions
  if ! which apt &>/dev/null; then
    echo "***** apt package manager not found, installing... *****"
    sudo apt-get update
    sudo apt-get install -y apt
  fi
  sudo apt update
  INSTALL_CMD="sudo apt-get install -y"
  UPDATE_CMD="sudo apt-get upgrade -y"
  SHELL_CONFIG="~/.bashrc"
elif [ -f /etc/redhat-release ]; then
  # RedHat-based Linux distributions
  if ! which yum &>/dev/null; then
    echo "***** yum package manager not found, installing... *****"
    sudo yum update
    sudo yum install -y yum
  fi
  INSTALL_CMD="sudo yum install -y"
  UPDATE_CMD="sudo yum upgrade -y"
  SHELL_CONFIG="~/.bashrc"
else
  echo "***** Unsupported OS *****"
  exit 1
fi

echo
source ./_install-packages.sh
echo

echo
source ./_install-fzf.sh
echo

echo
source ./_install-oh-my-zsh.sh
echo

echo
source ./_setup-neovim.sh
echo

chsh -s $(which zsh)
exit
