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
  map <leader>bd <Action>(CloseEditor)
  map <leader>ft <Action>(ActivateTerminalToolWindow)

  " Code
  map <leader>cr <Action>(RenameElement)
  map <leader>ca <Action>(ShowIntentionActions)
  map <leader>cf <Action>(ReformatCode)
  map <leader>cd <Action>(ShowErrorDescription)

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

  " telescope.nvim
  map <leader>/ <Action>(FindInPath)
  map <leader>ff <Action>(GotoFile)
  map <leader>fr <Action>(RecentFiles)

  " aerial.nvim/trouble.nvim
  map <leader>co <Action>(ActivateStructureToolWindow)
  map <leader>cs <Action>(ActivateStructureToolWindow)

  " neo-tree.nvim
  map <leader>e <Action>(ActivateProjectToolWindow)

  " IDEA Original
  map gsm <Action>(GotoSuperMethod)
  map gne <Action>(GotoNextError)
  map gnc <Action>(VcsShowNextChangeMarker)
  map gpc <Action>(VcsShowPrevChangeMarker)
  map <leader>ch <Action>(CallHierarchy)
  map <leader>sp <Action>(MoveTabRight)
  map <leader>usp <Action>(Unsplit)

endif

