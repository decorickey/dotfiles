" leaderキー ------------------------------------------
let mapleader = " "
let maplocalleader = ","

" キーマップ ------------------------------------------
inoremap jj <esc>
nnoremap <C-a> ^
vnoremap <C-a> ^
nnoremap <C-e> $
vnoremap <C-e> $

" 基本設定 ------------------------------------------
" OSクリップボードと共有
set clipboard=unnamed,unnamedplus
" 検索時に大文字と小文字を区別しない
set ignorecase
" 検索時に大文字と小文字を混在させると考慮する
set smartcase

" .ideavimrc用設定 -----------------------------------------
if has('ide')
  " Neovimデフォルト -----------------------------------------
  set hlsearch
  set incsearch

  " Idea固有操作 -----------------------------------------
  " 分割（split）
  map <leader>sp <Action>(MoveTabRight)
  map <leader>usp <Action>(Unsplit)

  " AstroNvim -----------------------------------------
  " バッファ
  map <leader>c <Action>(CloseEditor)
  map ]b <Action>(NextTab)
  map [b <Action>(PreviousTab)
  map <C-h> <Action>(PrevSplitter)
  map <C-j> <Action>(NextSplitter)
  map <C-k> <Action>(PrevSplitter)
  map <C-l> <Action>(NextSplitter)

  " LSP
  map <leader>la <Action>(ShowIntentionActions)
  map <leader>ld <Action>(ShowErrorDescription)
  map <leader>lf <Action>(ReformatCode)
  
  " ターミナル
  map <leader>th <Action>(ActivateTerminalToolWindow)
  
  " コメント
  map <leader>/ <Action>(CommentByLineComment)
  
  " Fold
  map zf <Action>(CollapseRegion)
  map zaf <Action>(CollapseAllRegions)
  map zd <Action>(ExpandRegion)
  map zad <Action>(ExpandAllRegions)
  
  " Telescope
  map <leader>ff <Action>(GotoFile)
  map <leader>fw <Action>(FindInPath)
  map <leader>fo <Action>(RecentFiles)
  
  " Neo-Tree
  map <leader>e <Action>(HideAllWindows)
  map <leader>o <Action>(ActivateProjectToolWindow)
endif

