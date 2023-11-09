if vim.g.vscode then
  -- VSCode extension
  return {
    vim.cmd("source ~/dotfiles/.vimrc"),
  }
else
  -- ordinary Neovim
  return {
    vim.cmd("source ~/dotfiles/.vimrc"),
  }
end

