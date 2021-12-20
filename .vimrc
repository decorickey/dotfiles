source ~/dotfiles/vim/key-remap.vim
source ~/dotfiles/vim/vim-plug.vim

" zshを使う
set shell=/bin/zsh

" インデントとタブの個別設定
" shiftwidth: インデントのスペース数
" expandtab/noexpandtab: タブ入力時のスペース切り替え
" tabstop: タブのスペース数
autocmd FileType markdown setlocal shiftwidth=4 expandtab tabstop=4
autocmd FileType html setlocal shiftwidth=2 expandtab tabstop=2
autocmd FileType css setlocal shiftwidth=2 expandtab tabstop=2
autocmd FileType javascript setlocal shiftwidth=2 expandtab tabstop=2
autocmd FileType vue setlocal shiftwidth=2 expandtab tabstop=2
autocmd FileType python setlocal shiftwidth=4 expandtab tabstop=4

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

set textwidth=0
set autoindent
set hlsearch
set clipboard=unnamed
syntax on

