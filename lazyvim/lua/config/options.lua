-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
vim.cmd("source ~/dotfiles/.vimrc")

if vim.g.vscode then
  local vscode = require("vscode")
  vim.keymap.set("n", "<leader>e", function()
    vscode.action("workbench.view.explorer")
  end, { remap = true })
end
