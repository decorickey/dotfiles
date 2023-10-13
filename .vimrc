let mapleader = "\<Space>"
let maplocalleader = ","

set clipboard=unnamed,unnamedplus  " クリップボードと共有 "
set ignorecase                     " 検索時に大文字と小文字を区別しない "
set smartcase                      " 検索時に大文字と小文字を混在させると考慮する "

inoremap jj <esc>
inoremap <C-j> <esc>
vnoremap <C-j> <esc>
noremap <C-a> ^
noremap <C-e> $

" idea用Neovimデフォルト設定 "
set hlsearch
set incsearch

