return {
  -- 必須：dap本体を追加
  {
    "mfussenegger/nvim-dap",
    lazy = true,
  },
  -- デバッグ用：nvim-dap-go (Delve を自動設定)
  {
    "leoluz/nvim-dap-go",
    ft = "go",
    config = function()
      require("dap-go").setup()
    end,
  },
}
