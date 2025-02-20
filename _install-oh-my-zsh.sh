#!/bin/bash

if ! which zsh &>/dev/null; then
  echo "***** Install zsh *****"
  $INSTALL_CMD zsh
  chsh -s $(which zsh)
  echo "Restart Terminal"
else
  echo "***** Skip zsh *****"
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
