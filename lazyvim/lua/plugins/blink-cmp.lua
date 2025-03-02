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
      ["<S-Tab>"] = { "select_prev", "fallback" },
      ["<Tab>"] = { "select_next", "fallback" },
      ["<CR>"] = { "accept", "fallback" },
    },
  },
}
