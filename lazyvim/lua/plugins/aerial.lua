return {
  "stevearc/aerial.nvim",
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    "nvim-tree/nvim-web-devicons",
  },
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
