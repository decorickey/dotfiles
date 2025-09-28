return {
  "neovim/nvim-lspconfig",
  opts = {
    servers = {
      gopls = {
        settings = {
          gopls = {
            hints = {
              assignVariableTypes = false,
              compositeLiteralFields = false,
              compositeLiteralTypes = false,
              functionTypeParameters = false,
              ignoreError = true,
              parameterNames = false,
              rangeVariableTypes = false,
            },
          },
        },
      },
    },
  },
}
