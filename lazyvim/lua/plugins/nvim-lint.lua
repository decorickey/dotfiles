return {
  "mfussenegger/nvim-lint",
  opts = {
    linters_by_ft = {
      markdown = { "markdownlint-cli2" },
    },
    linters = {
      ["markdownlint-cli2"] = {
        -- 独自の設定のために必要
        args = { "--config", vim.fn.expand("~/dotfiles/.markdownlint.yaml"), "--" },
      },
      ["go"] = { "golangci_lint" },
    },
  },
}
