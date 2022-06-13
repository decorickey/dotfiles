source ~/dotfiles/vim/key-remap.vim
source ~/dotfiles/vim/indent.vim
source ~/dotfiles/vim/vim-plug.vim

" zshを使う
set shell=/bin/zsh

" 行番号を表示する
set number

" カーソル行の背景色を変える
set cursorline

" 検索時に大文字と小文字を区別しない
set ignorecase

" 検索時に大文字と小文字を混在させると考慮する
set smartcase

" swapファイルを作らない
set noswapfile

" 不可視文字を表示する
set list
set listchars=tab:»-,trail:-,

" 自動で改行しない
set textwidth=0

" 自動でインデントする
set autoindent

" 検索結果をハイライトする
set hlsearch

" ヤンクしたテキストをクリップボードにコピーする
set clipboard=unnamed

" デフォルトの設定でハイライトする
syntax on

