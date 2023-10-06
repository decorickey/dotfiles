if exists('g:vscode')
  " VSCode extension
  source ~/dotfiles/vim/key-remap.vim
else
  " ordinary Neovim
  source ~/dotfiles/vim/base.vim
  source ~/dotfiles/vim/indent.vim
  source ~/dotfiles/vim/key-remap.vim
  source ~/dotfiles/vim/vim-plug.vim
endif