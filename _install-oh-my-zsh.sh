#!/bin/bash

if ! which zsh &>/dev/null; then
  echo "***** Install zsh *****"
  $INSTALL_CMD zsh
else
  echo "***** Skip zsh *****"
fi
echo

DEFAULT_SHELL=$(getent passwd "$USER" | cut -d: -f7)
ZSH_PATH=$(which zsh)
if [ "$DEFAULT_SHELL" != "$ZSH_PATH" ]; then
    echo "***** Change Default Shell to Zsh *****"
    chsh -s "$ZSH_PATH"
fi
echo

if ! [ -d ~/.oh-my-zsh ]; then
  echo "***** Install oh-my-zsh (my favorite theme is kolo) *****"
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
else
  echo "***** Skip oh-my-zsh (my favorite theme is kolo) *****"
fi
echo

# Ensure the ~/.zshrc sources ~/dotfiles/.zshrc
if ! grep -Fxq "source ~/dotfiles/.zshrc" ~/.zshrc; then
  echo 'source ~/dotfiles/.zshrc' >>~/.zshrc
fi
echo
