vim.cmd('source ~/dotfiles/vim/base.vim')
vim.cmd('source ~/dotfiles/vim/keymap.vim')

if  vim.g.vscode then
  -- VSCode extension
else
  -- ordinary Neovim
  vim.cmd('source ~/dotfiles/vim/indent.vim')
  vim.cmd('source ~/dotfiles/vim/vim-plug.vim')
  
  vim.opt.cursorline = true -- カーソル行の背景色
  vim.opt.backup = false -- バックアップファイルを作らない
  vim.opt.swapfile = false -- swapファイルを作らない
  vim.opt.writebackup = false -- バックアップファイルを作らない
  vim.opt.number = true -- 行番号表示
  vim.opt.textwidth = 0 -- 自動で改行しない
end
