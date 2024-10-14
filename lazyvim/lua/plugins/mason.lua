return {
  {
    "williamboman/mason-lspconfig.nvim",
    opts = {
      ensure_installed = {
        "lua_ls",
        "gopls",
        "eslint",
        "ts_ls",
        "terraformls",
      },
    },
  },
}
