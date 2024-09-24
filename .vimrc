" leader key ------------------------------------------
let mapleader = " "

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
set norelativenumber

" basic settings (Neovim default) -----------------------------------------
set hlsearch
set incsearch

" .ideavimrc -----------------------------------------
if has('ide')
  " IDEA Original
  map <leader>sp <Action>(MoveTabRight)
  map <leader>usp <Action>(Unsplit)
  map <leader>h <Action>(CallHierarchy)
  map gsm <Action>(GotoSuperMethod)

  " General
  map <C-o> <Action>(Back)
  map <C-i> <Action>(Forward)

  " Buffers(Tabs)
  map <leader>bd <Action>(CloseEditor)
  map <leader>w <Action>(CloseEditor)
  map L <Action>(NextTab)
  map H <Action>(PreviousTab)
  map <C-h> <Action>(PrevSplitter)
  map <C-j> <Action>(NextSplitter)
  map <C-k> <Action>(PrevSplitter)
  map <C-l> <Action>(NextSplitter)

  " Neo-Tree
  map <leader>e <Action>(ActivateProjectToolWindow)

  " ----------------------------------------------------------------------------------

  " Original
  map gnc <Action>(VcsShowNextChangeMarker)
  map gpc <Action>(VcsShowPrevChangeMarker)

  " AstroNvim
  " Comment
  map <leader>/ <Action>(CommentByLineComment)
  
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

