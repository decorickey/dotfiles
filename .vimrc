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
  " Basic
  map L <Action>(NextTab)
  map H <Action>(PreviousTab)
  map <C-h> <Action>(PrevSplitter)
  map <C-j> <Action>(NextSplitter)
  map <C-k> <Action>(PrevSplitter)
  map <C-l> <Action>(NextSplitter)
  map <C-i> <Action>(Forward)
  map <C-o> <Action>(Back)

  " Buffers(Tabs)
  map <leader>d <Action>(CloseEditor)
  map <leader>t <Action>(ActivateTerminalToolWindow)

  " Comment
  map <C-/> <Action>(CommentByLineComment)

  " telescope.nvim
  map <leader>/ <Action>(FindInPath)
  map <leader>ff <Action>(GotoFile)
  map <leader>fr <Action>(RecentFiles)

  " neo-tree.nvim
  " Explorer
  map <leader>e <Action>(ActivateProjectToolWindow)

  " aerial.nvim/trouble.nvim
  " Code Outline
  map <leader>co <Action>(ActivateStructureToolWindow)
  " Code Symbols
  map <leader>cs <Action>(ActivateStructureToolWindow)

  " Fold
  map zc <Action>(CollapseRegion)
  map zC <Action>(CollapseAllRegions)
  map zo <Action>(ExpandRegion)
  map zO <Action>(ExpandAllRegions)

  " LSP
  " Goto Implementation
  map gI <Action>(GotoImplementation)
  " Goto References
  map gr <Action>(FindUsages)
  " Goto T[y]pe Definition
  map gy <Action>(GotoTypeDeclaration)
  "
  map <leader>la <Action>(ShowIntentionActions)
  map <leader>ld <Action>(ShowErrorDescription)
  map <leader>lf <Action>(ReformatCode)
  map <leader>lR <Action>(FindUsages)
  map <leader>lr <Action>(RenameElement)

  " IDEA Original
  map gsm <Action>(GotoSuperMethod)
  map gne <Action>(GotoNextError)
  map gnc <Action>(VcsShowNextChangeMarker)
  map gpc <Action>(VcsShowPrevChangeMarker)
  map <leader>ch <Action>(CallHierarchy)
  map <leader>sp <Action>(MoveTabRight)
  map <leader>usp <Action>(Unsplit)

endif

