source ~/dotfiles/vim/key-remap.vim
source ~/dotfiles/vim/vim-plug.vim

" zshを使う
set shell=/bin/zsh

" インデントは4
set shiftwidth=4

" tab文字は4スペース
set tabstop=4

" tab文字はスペースに置き換える 
set expandtab

set textwidth=0
set autoindent
set hlsearch
set clipboard=unnamed
syntax on

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

