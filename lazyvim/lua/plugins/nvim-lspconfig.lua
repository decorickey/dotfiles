return {
  "neovim/nvim-lspconfig",
  dependencies = {
    "mason-org/mason.nvim",
    { "mason-org/mason-lspconfig.nvim", config = function() end },
  },
  opts = {
    ensure_installed = {
      -- Lua
      "lua_ls",
      -- Docker
      "hadolint",
      -- Markdown
      "markdownlint-cli2",
      "markdown-toc",
      -- Terraform
      "tflint",
    },
    servers = {
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
      jsonls = {
        settings = {
          json = {
            format = {
              enable = true,
            },
          },
        },
      },
    },
  },
}
