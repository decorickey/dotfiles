#!/bin/bash

packages=(
  "git"
  "gh"
  "neovim"
  "ripgrep"
  "gopls"
  "sqlite3"
  "yarn"
)

# Install or update packages
manage_package() {
  if ! which $1 &>/dev/null; then
    echo "***** Install $1 *****"
    $INSTALL_CMD $1
  else
    echo "***** Update $1 *****"
    $UPDATE_CMD $1
  fi
  echo
}

for package in "${packages[@]}"; do
  manage_package $package
done
