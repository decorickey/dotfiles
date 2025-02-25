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

  " Telescope
  map <leader>/ <Action>(FindInPath)
  map <leader>ff <Action>(GotoFile)
  map <leader>fr <Action>(RecentFiles)

  " Neo-Tree
  map <leader>1 <Action>(ActivateProjectToolWindow)

  " Aerial
  map <leader>2 <Action>(ActivateStructureToolWindow)

  " Fold
  map zc <Action>(CollapseRegion)
  map zC <Action>(CollapseAllRegions)
  map zo <Action>(ExpandRegion)
  map zO <Action>(ExpandAllRegions)

  " LSP
  map <leader>la <Action>(ShowIntentionActions)
  map <leader>ld <Action>(ShowErrorDescription)
  map <leader>lf <Action>(ReformatCode)
  map <leader>lR <Action>(FindUsages)
  map <leader>lr <Action>(RenameElement)
  map gI <Action>(GotoImplementation)
  map gr <Action>(FindUsages)
  map gy <Action>(GotoTypeDeclaration)

  " IDEA Original
  map gsm <Action>(GotoSuperMethod)
  map gne <Action>(GotoNextError)
  map gnc <Action>(VcsShowNextChangeMarker)
  map gpc <Action>(VcsShowPrevChangeMarker)
  map <leader>ch <Action>(CallHierarchy)
  map <leader>sp <Action>(MoveTabRight)
  map <leader>usp <Action>(Unsplit)

endif

