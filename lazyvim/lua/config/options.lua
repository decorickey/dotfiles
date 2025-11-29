-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

vim.cmd("source ~/dotfiles/.vimrc")

-- foldはデフォルトで展開した状態にし、必要に応じて手動で切り替えられるようにする
local opt = vim.opt
opt.foldenable = false
opt.foldlevel = 99
opt.foldlevelstart = 99
