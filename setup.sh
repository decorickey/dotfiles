#!/bin/bash

packages=(
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

manage_package() {
  if ! brew list $1 &>/dev/null; then
    echo "Install $1"
    brew install $1
  else
    echo "Update $1"
    brew upgrade $1
  fi
  echo
}

for package in "${packages[@]}"; do
  manage_package $package
done

echo

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
