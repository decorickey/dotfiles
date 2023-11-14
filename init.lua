if vim.g.vscode then
  -- VSCode extension
  return {
    vim.cmd("source ~/dotfiles/.vimrc"),

    -- ターミナル
    vim.keymap.set(
      { "n" }, "<leader>th", "workbench.action.terminal.new", { noremap = true }
    ),

    -- コメント
    vim.keymap.set(
      { "n" }, "<leader>/", "<Cmd>call VSCodeNotify('editor.action.commentLine')<CR>", { noremap = true }
    ),

    -- fold
    vim.keymap.set({ "n" }, "zf", "<Cmd>call VSCodeNotify('editor.fold')<CR>", { noremap = true }),
    vim.keymap.set({ "n" }, "zd", "<Cmd>call VSCodeNotify('editor.unfold')<CR>", { noremap = true }),
    -- カーソル移動時にfoldをスキップ（VSCodeの挙動変更）
    vim.keymap.set(
      { "n" }, "j",
      "<Cmd>call VSCodeCall('cursorMove', { 'to': 'down', 'by': 'wrappedLine', 'value': v:count ? v:count : 1 })<CR>",
      { noremap = true }
    ),
    vim.keymap.set(
      { "n" }, "k",
      "<Cmd>call VSCodeCall('cursorMove', { 'to': 'up', 'by': 'wrappedLine', 'value': v:count ? v:count : 1 })<CR>",
      { noremap = true }
    ),

    -- Telescope
    vim.keymap.set(
      { "n" }, "<leader>ff", "<Cmd>call VSCodeNotify('workbench.action.quickOpen')<CR>", { noremap = true }
    ),
    vim.keymap.set(
      { "n" }, "<leader>fw", "<Cmd>call VSCodeNotify('workbench.action.findInFiles')<CR>", { noremap = true }
    ),
    vim.keymap.set(
      { "n" }, "<leader>fo", "<Cmd>call VSCodeNotify('workbench.action.findInFiles')<CR>", { noremap = true }
    ),

    -- Neo-Tree
    vim.keymap.set(
      { "n" }, "<leader>e", "<Cmd>call VSCodeNotify('workbench.action.toggleSidebarVisibility')<CR>", { noremap = true }
    ),
    vim.keymap.set(
      { "n" }, "<leader>o", "<Cmd>call VSCodeNotify('workbench.view.explorer')<CR>", { noremap = true }
    ),
  }
else
  -- ordinary Neovim
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
end
