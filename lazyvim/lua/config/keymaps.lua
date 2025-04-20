-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local map = vim.keymap.set

map("n", "gn", "<Nop>")

-- Buffers
map("n", "<leader>d", "<leader>bd", { remap = true, desc = "Delete Buffer" })
map("n", "<leader>t", "<leader>ft", { remap = true, desc = "Terminal" })

-- Comment
map("n", "<C-/>", "gcc", { remap = true, desc = "Comment" })
map("v", "<C-/>", "gc", { remap = true, desc = "Comment" })
