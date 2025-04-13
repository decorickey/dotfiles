return {
  "github/copilot.vim",
  init = function()
    -- TabをCopilotに使わせない
    vim.g.copilot_no_tab_map = true

    -- Ctr-L で補完を承認
    vim.cmd([[
      imap <silent><script><expr> <C-l> copilot#Accept("\<CR>")
    ]])
  end,
}
