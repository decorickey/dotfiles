-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

vim.keymap.set("n", "<leader>/", "<leader>sG", {
  remap = true,
  silent = true,
  desc = "Grep (cwd)",
})

vim.keymap.set("n", "<leader>e", "<leader>E", {
  remap = true,
  silent = true,
  desc = "Explorer (cwd)",
})

vim.keymap.set("n", "<leader>ff", "<leader>fF", {
  remap = true,
  silent = true,
  desc = "Find Files (cwd)",
})
