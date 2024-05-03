return {
  vim.cmd("source ~/dotfiles/.vimrc"),
  lsp = {
    formatting = {
      format_on_save = {
        enabled = true,     -- enable format on save
        allow_filetypes = { -- only allow formatting on save for these filetypes
          "go",
          "lua",
        },
        ignore_filetypes = { -- disable format on save for specified filetypes
          "python",
        },
      },
    },
  },
}
