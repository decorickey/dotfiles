" leader key ------------------------------------------
let mapleader = " "
let maplocalleader = ","

" key mappings ------------------------------------------
inoremap jj <esc>
nnoremap <C-a> ^
vnoremap <C-a> ^
nnoremap <C-e> $
vnoremap <C-e> $

" basic settings ------------------------------------------
" set clipboard=unnamed,unnamedplus
" set ignorecase
" set smartcase

" Neovim default -----------------------------------------
" set hlsearch
" set incsearch

" .ideavimrc -----------------------------------------
if has('ide')
  " Completed Version -----------------------------------------
  " Original
  map <leader>sp <Action>(MoveTabRight)
  map <leader>usp <Action>(Unsplit)
  map gsm <Action>(GotoSuperMethod)

  " AstroNvim
  " Comment
  map <leader>/ <Action>(CommentByLineComment)
  
  " Buffers(Tabs)
  map <leader>c <Action>(CloseEditor)
  map ]b <Action>(NextTab)
  map [b <Action>(PreviousTab)
  map L <Action>(NextTab)
  map H <Action>(PreviousTab)
  map <C-h> <Action>(PrevSplitter)
  map <C-j> <Action>(NextSplitter)
  map <C-k> <Action>(PrevSplitter)
  map <C-l> <Action>(NextSplitter)
  
  " Neo-Tree
  map <leader>e <Action>(HideAllWindows)
  map <leader>o <Action>(ActivateProjectToolWindow)
  
  " LSP
  map <leader>la <Action>(ShowIntentionActions)
  map <leader>ld <Action>(ShowErrorDescription)
  map <leader>lf <Action>(ReformatCode)
  map <leader>lR <Action>(FindUsages)
  map <leader>lr <Action>(RenameElement)
  map gI <Action>(GotoImplementation)
  map gr <Action>(FindUsages)
  map gy <Action>(GotoTypeDeclaration)

  " Telescope
  map <leader>ff <Action>(GotoFile)
  map <leader>fw <Action>(FindInPath)
  map <leader>fo <Action>(RecentFiles)

  " Terminal
  map <leader>th <Action>(ActivateTerminalToolWindow)
  
  " Fold
  map zc <Action>(CollapseRegion)
  map zC <Action>(CollapseAllRegions)
  map zo <Action>(ExpandRegion)
  map zO <Action>(ExpandAllRegions)
endif

