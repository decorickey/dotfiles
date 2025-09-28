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
      -- Markdown
      marksman = {},
      -- Terraform
      terraformls = {},
      -- Docker
      dockerls = {},
      docker_compose_language_service = {},
      -- JSON
      jsonls = {},
    },
  },
}
