source ~/dotfiles/vim/base.vim
source ~/dotfiles/vim/key-remap.vim

if exists('g:vscode')
  " VSCode extension
else
  " ordinary Neovim
  set cursorline                     " カーソル業の背景色
  set nobackup                       " バックアップファイルを作らない
  set noswapfile                     " swapファイルを作らない
  set nowritebackup                  " バックアップファイルを作らない
  set number                         " 行番号表示
  set textwidth=0                    " 自動で改行しない

  source ~/dotfiles/vim/indent.vim
  source ~/dotfiles/vim/vim-plug.vim
endif

