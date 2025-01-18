#!/bin/bash

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

echo

if ! brew list gsed &>/dev/null; then
  echo "Install GNU sed"
  brew install gsed
else
  echo "Update GNU sed"
  brew upgrade gsed
fi

echo

if ! [ -d ~/.oh-my-zsh ]; then
  echo "Manual Install Oh My Zsh"
  echo 'sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"'
  echo
  exit 0
else
  echo "Skip Oh My Zsh (my favorite theme is kolo)"
  gsed -i '/^source ~\/dotfiles\/\.zshrc/d' ~/.zshrc
  echo 'source ~/dotfiles/.zshrc' >>~/.zshrc
fi

echo

if ! brew list git &>/dev/null; then
  echo "Install Git by Homebrew"
  brew install git
else
  echo "Update Git by Homebrew"
  brew upgrade git
fi

echo

if ! brew list nvim &>/dev/null; then
  echo "Install NeoVim"
  brew install nvim
else
  echo "Update NeoVim"
  brew upgrade nvim
fi

echo

if ! brew list fzf &>/dev/null; then
  echo "Install fzf"
  brew install fzf
else
  echo "Update fzf"
  brew upgrade fzf
fi

echo

if ! brew list gh &>/dev/null; then
  echo "Install GitHub CLI"
  brew install gh
else
  echo "Update GitHub CLI"
  brew upgrade gh
fi

echo

if ! brew list volta &>/dev/null; then
  echo "Install Volta"
  brew install volta
else
  echo "Update Volta"
  brew upgrade volta
fi

echo

if ! brew list sqlite &>/dev/null; then
  echo "Install sqlite"
  brew install sqlite
else
  echo "Update sqlite"
  brew upgrade sqlite
fi

echo

if ! brew list yarn &>/dev/null; then
  echo "Install yarn"
  brew install yarn
else
  echo "Update yarn"
  brew upgrade yarn
fi
