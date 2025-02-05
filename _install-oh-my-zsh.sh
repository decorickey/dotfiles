#!/bin/bash

echo "***** Oh My Zsh *****"
if ! [ -d ~/.oh-my-zsh ]; then
  echo "Install (my favorite theme is kolo)"
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
else
  echo "Skip (my favorite theme is kolo)"
fi

# Ensure the ~/.zshrc sources ~/dotfiles/.zshrc
if ! grep -Fxq "source ~/dotfiles/.zshrc" ~/.zshrc; then
  echo 'source ~/dotfiles/.zshrc' >>~/.zshrc
fi
echo
