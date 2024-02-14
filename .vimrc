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
set clipboard=unnamed,unnamedplus
set ignorecase
set smartcase

" Neovim default -----------------------------------------
set hlsearch
set incsearch

" .ideavimrc -----------------------------------------
if has('ide')
  " Completed Version -----------------------------------------
  " Original
  map <leader>sp <Action>(MoveTabRight)
  map <leader>usp <Action>(Unsplit)
  map <leader>fu <Action>(FindUsages)
  map gsm <Action>(GotoSuperMethod)
  map nt <Action>(NextTab)
  map pt <Action>(PreviousTab)

  " AstroNvim
  " Comment
  map <leader>/ <Action>(CommentByLineComment)
  
  " Buffers
  map <leader>c <Action>(CloseEditor)
  map <C-h> <Action>(PrevSplitter)
  map <C-j> <Action>(NextSplitter)
  map <C-k> <Action>(PrevSplitter)
  map <C-l> <Action>(NextSplitter)
  
  " Neo-Tree
  map <leader>e <Action>(HideAllWindows)
  map <leader>o <Action>(ActivateProjectToolWindow)
  
  " LSP

  " Telescope
  map <leader>ff <Action>(GotoFile)
  map <leader>fw <Action>(FindInPath)
  map <leader>fo <Action>(RecentFiles)

  " Terminal
  map <leader>th <Action>(ActivateTerminalToolWindow)
  
  " AstroNvim -----------------------------------------
  " Buffer
  map ]b <Action>(NextTab)
  map [b <Action>(PreviousTab)

  " LSP
  map <leader>la <Action>(ShowIntentionActions)
  map <leader>ld <Action>(ShowErrorDescription)
  map <leader>lf <Action>(ReformatCode)
  map gI <Action>(GotoImplementation)
  
  " Telescope
  map <leader>fo <Action>(RecentFiles)
  
  " Fold
  map zf <Action>(CollapseRegion)
  map zaf <Action>(CollapseAllRegions)
  map zd <Action>(ExpandRegion)
  map zad <Action>(ExpandAllRegions)
endif

