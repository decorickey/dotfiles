return {
  "mfussenegger/nvim-lint",
  opts = {
    linters_by_ft = {
      markdown = { "markdownlint-cli2" },
    },
    linters = {
      markdownlint = {
        cmd = "markdownlint-cli2",
        stdin = true,
        args = {
          "--config",
          "~/.config/nvim/.markdownlint.json",
        },
        ignore_exitcode = true, -- エラーで処理が停止しないようにする
      },
    },
  },
}
