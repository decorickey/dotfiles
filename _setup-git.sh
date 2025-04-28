#!/bin/bash

echo "***** Setup git config *****"
git config --global commit.template ~/dotfiles/.gitmessage.txt
git config --global push.autoSetupRemote true
git config --global core.editor nvim
