return {
  "neovim/nvim-lspconfig",
  opts = {
    servers = {
      -- Lua
      lua_ls = {},

      -- Go
      gopls = {
        settings = {
          gopls = {},
        },
      },
    },
  },
}
