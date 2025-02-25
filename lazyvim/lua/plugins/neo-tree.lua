return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    keys = {
      {
        "<leader>1",
        function()
          require("neo-tree.command").execute({ toggle = true, dir = vim.uv.cwd() })
        end,
        desc = "Explorer NeoTree",
      },
      { "<leader>fe", false },
      { "<leader>fE", false },
      { "<leader>e", false },
      { "<leader>E", false },
    },
  },
}
