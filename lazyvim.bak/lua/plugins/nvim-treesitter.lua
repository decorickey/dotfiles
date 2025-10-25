return {
  "nvim-treesitter/nvim-treesitter",
  opts = {
    highlight = { enable = true },
    indent = { enable = true },
    ensure_installed = {
      -- Lua
      "lua",

      -- Go
      "go",
      "gomod",
      "gowork",
      "gosum",
    },
  },
}
