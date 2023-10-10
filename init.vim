let mapleader = "\<Space>"

set clipboard=unnamed,unnamedplus  " クリップボードと共有
set ignorecase                     " 検索時に大文字と小文字を区別しない 
set smartcase                      " 検索時に大文字と小文字を混在させると考慮する

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

