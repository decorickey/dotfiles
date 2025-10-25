return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    keys = {
      {
        "<leader>e",
        function()
          require("neo-tree.command").execute({ toggle = true, dir = vim.uv.cwd() })
        end,
        desc = "Explorer",
      },
      { "<leader>fE", false },
      { "<leader>fe", false },
      { "<leader>E", false },
    },
  },
}
