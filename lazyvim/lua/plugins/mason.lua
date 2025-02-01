return {
  {
    "williamboman/mason-lspconfig.nvim",
    opts = {
      ensure_installed = {
        -- default
        -- "markdownlint-cli2",
        -- "markdown-toc",
        --
        -- optional
        "lua_ls",
        "gopls",
        "eslint",
        "ts_ls",
        "terraformls",
      },
    },
  },
}
