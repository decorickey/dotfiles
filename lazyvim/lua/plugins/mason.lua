return {
  "mason-org/mason.nvim",
  opts = {
    ensure_installed = {
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
