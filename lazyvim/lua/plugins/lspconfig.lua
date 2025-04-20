return {
  {
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "neovim/nvim-lspconfig",
    opts = {
      ensure_installed = {
        "lua_ls",
        "gopls",
        "eslint",
        "ts_ls",
        "terraformls",
        "markdownlint-cli2",
        "markdown-toc",
      },
    },
  },
}
