return {
  "stevearc/aerial.nvim",
  keys = {
    { "<leader>co", "<cmd>AerialToggle<cr>", desc = "Code Outline" },
  },
  opts = function()
    local opts = {
      layout = {
        min_width = 0.15,
      },
    }
    return opts
  end,
}
