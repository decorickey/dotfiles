return {
  {
    "ibhagwan/fzf-lua",
    keys = {
      { "<leader>ff", LazyVim.pick("files", { root = false }), desc = "Find Files (cwd)" },
      { "<leader>fF", false },
      { "<leader>fr", LazyVim.pick("oldfiles", { cwd = vim.uv.cwd() }), desc = "Recent (cwd)" },
      { "<leader>fR", false },
    },
  },
}
