-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local map = vim.keymap.set

map("n", "<leader>d", "<leader>bd", { remap = true, desc = "Delete buffer" })
map("n", "<leader>t", "<leader>ft", { remap = true, desc = "Terminal" })
map("n", "<C-/>", "gcc", { remap = true, desc = "Comment" })
map("v", "<C-/>", "gcc", { remap = true, desc = "Comment" })
map("n", "gn", "<Nop>")
