return {
  "saghen/blink.cmp",
  opts = {
    sources = {
      compat = {},
      default = { "lsp", "path", "snippets", "buffer" },
    },
    completion = {
      list = {
        selection = { preselect = false, auto_insert = false },
      },
    },
    keymap = {
      ["<CR>"] = { "accept", "fallback" },
    },
  },
}
