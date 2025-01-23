#!/bin/bash

# List of packages to install or update
packages=(
  "zsh"
  "gsed"
  "git"
  "nvim"
  "fzf"
  "gh"
  "volta"
  "sqlite"
  "yarn"
  "gopls"
  "golangci-lint"
  "lazygit"
  "repgrep"
)

# Detect the operating system
OS=$(uname)
INSTALL_CMD=""
UPDATE_CMD=""

if [ "$OS" == "Darwin" ]; then
  # macOS specific commands
  if ! which brew &>/dev/null; then
    echo "Install Homebrew"
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    echo >>~/.zprofile
    echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >>~/.zprofile
    eval "$(/opt/homebrew/bin/brew shellenv)"
  else
    echo "Update Homebrew"
    brew update
  fi
  INSTALL_CMD="brew install"
  UPDATE_CMD="brew upgrade"
  SHELL_CONFIG="~/.zprofile"
elif [ -f /etc/debian_version ]; then
  # Debian-based Linux distributions
  if ! which apt &>/dev/null; then
    echo "apt package manager not found, installing..."
    sudo apt-get update
    sudo apt-get install -y apt
  fi
  INSTALL_CMD="sudo apt-get install -y"
  UPDATE_CMD="sudo apt-get upgrade -y"
  SHELL_CONFIG="~/.bashrc"
elif [ -f /etc/redhat-release ]; then
  # RedHat-based Linux distributions
  if ! which yum &>/dev/null; then
    echo "yum package manager not found, installing..."
    sudo yum update
    sudo yum install -y yum
  fi
  INSTALL_CMD="sudo yum install -y"
  UPDATE_CMD="sudo yum upgrade -y"
  SHELL_CONFIG="~/.bashrc"
else
  echo "Unsupported OS"
  exit 1
fi

echo
echo "***** Operating System: $OS *****"
echo

# Install or update packages
manage_package() {
  if ! which $1 &>/dev/null; then
    echo "Install $1"
    $INSTALL_CMD $1
  else
    echo "Update $1"
    $UPDATE_CMD $1
  fi
  echo
}

for package in "${packages[@]}"; do
  manage_package $package
done

echo

# Install Oh My Zsh
if ! [ -d ~/.oh-my-zsh ]; then
  echo "Manual Install Oh My Zsh"
  echo 'sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"'
  echo
  exit 0
else
  echo "Skip Oh My Zsh (my favorite theme is kolo)"
  sed -i '/^source ~\/dotfiles\/\.zshrc/d' ~/.zshrc
  echo 'source ~/dotfiles/.zshrc' >>~/.zshrc
fi

echo

# NeoVim Configuration
CONFIG_DIR=~/.config
NVIM_DIR=${CONFIG_DIR}/nvim

echo "***** Reset NeoVim *****"
rm -rf ~/.local/share/nvim
rm -rf ~/.local/state/nvim
rm -rf ~/.cache/nvim
rm -rf $CONFIG_DIR
mkdir -p $CONFIG_DIR

echo "***** Initialize LazyVim *****"
rm ~/dotfiles/lazyvim/lazy-lock.json
ln -s ~/dotfiles/lazyvim $NVIM_DIR
echo

echo "***** Initialize IdeaVim *****"
ln -sf ~/dotfiles/.vimrc ~/.ideavimrc
echo
