return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    keys = {
      {
        "<leader>e",
        function()
          require("neo-tree.command").execute({ toggle = true, dir = vim.uv.cwd() })
        end,
        desc = "Explorer NeoTree",
      },
      { "<leader>fe", false },
      { "<leader>fE", false },
      { "<leader>E", false },
    },
  },
}
