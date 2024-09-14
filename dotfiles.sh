#!/bin/zsh
ln -sf ~/dotfiles/.vimrc ~/.ideavimrc
echo "created symbolic link for IdeaVim"

ln -sf ~/dotfiles/astronvim/lua/plugins/astrocore.lua ~/.config/nvim/lua/plugins/astrocore.lua
ln -sf ~/dotfiles/astronvim/lua/plugins/astrolsp.lua ~/.config/nvim/lua/plugins/astrolsp.lua
ln -sf ~/dotfiles/astronvim/lua/plugins/mason.lua ~/.config/nvim/lua/plugins/mason.lua
ln -sf ~/dotfiles/astronvim/lua/plugins/user.lua ~/.config/nvim/lua/plugins/user.lua
ln -sf ~/dotfiles/astronvim/lua/plugins/go.lua ~/.config/nvim/lua/plugins/go.lua
echo "created symbolic link for AstroNvim"
