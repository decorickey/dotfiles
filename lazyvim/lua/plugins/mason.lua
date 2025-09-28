return {
  "mason-org/mason.nvim",
  opts = {
    ensure_installed = {
      -- Go
      "delve",
      -- Docker
      "hadolint",
      -- Markdown
      "markdownlint-cli2",
      "markdown-toc",
      -- Terraform
      "tflint",
    },
  },
}
