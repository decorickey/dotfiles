return {
  "mfussenegger/nvim-lint",
  opts = {
    linters_by_ft = {
      markdown = { "markdownlint" },
    },
    linters = {
      markdownlint = {
        cmd = "markdownlint-cli2",
        stdin = true,
        args = {
          "--config",
          vim.fn.expand("~/.config/nvim/.markdownlint.json"),
        },
        ignore_exitcode = true, -- エラーで処理が停止しないようにする
      },
    },
  },
}
