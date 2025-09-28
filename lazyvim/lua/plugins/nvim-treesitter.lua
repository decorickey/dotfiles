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

      -- Docker
      "dockerfile",

      -- JSON
      "json",
      "json5",

      -- SQL
      "sql",

      -- Terraform
      "terraform",
      "hcl",
    },
  },
}
