return {
  {
    "saghen/blink.cmp",
    opts = {
      keymap = {
        ["<Tab>"] = { "select_next", "fallback" },
        ["<S-Tab>"] = { "select_prev", "fallback" },
      },
      completion = {
        list = {
          selection = {
            -- 自動補完候補がデフォルトで選択されないようにするための設定
            preselect = false,
            auto_insert = false,
          },
        },
      },
    },
  },
}
