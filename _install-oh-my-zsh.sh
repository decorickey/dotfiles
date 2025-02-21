#!/bin/bash

if ! which zsh &>/dev/null; then
  echo "***** Install zsh *****"
  $INSTALL_CMD zsh
else
  echo "***** Skip zsh *****"
fi
echo

if [ -n "$SHELL" ]; then
  CURRENT_SHELL="$SHELL"
elif command -v getent >/dev/null 2>&1; then
  CURRENT_SHELL=$(getent passwd "$USER" | cut -d: -f7)
elif command -v dscl >/dev/null 2>&1; then
  CURRENT_SHELL=$(dscl . -read ~/ UserShell | awk '{print $2}')
else
  "Error: shell not found"
  exit 1
fi
ZSH_PATH=$(command -v zsh)
if [ "$CURRENT_SHELL" != "$ZSH_PATH" ]; then
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
