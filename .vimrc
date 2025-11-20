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

" optional settings -----------------------------------------
" 外部でファイルが変更されたら自動で再読み込み
set autoread

" Neovim/Vim にフォーカスが戻ったりバッファを移動したときにチェック
autocmd FocusGained,BufEnter * checktime

" 一定時間ごとに自動チェック（CursorHoldイベント）
set updatetime=1000
autocmd CursorHold,CursorHoldI * checktime

" 外部更新時の長いメッセージを抑制
set shortmess+=A

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

  " Comment
  map gcc <Action>(CommentByLineComment)

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

  " aerial.nvim
  map <leader>cs <Action>(ActivateStructureToolWindow)

  " snacks.nvim 
  map <leader>e <Action>(ActivateProjectToolWindow)

  " IDEA Original
  map gsm <Action>(GotoSuperMethod)
  map gne <Action>(GotoNextError)
  map gnc <Action>(VcsShowNextChangeMarker)
  map gpc <Action>(VcsShowPrevChangeMarker)
  map <leader>ch <Action>(CallHierarchy)
  " map <leader>| <Action>(MoveTabRight)

elseif exists('g:vscode')
  " VSCode NeoVim Extension -----------------------------------------
  " Basic
  map L <Cmd>call VSCodeNotify('workbench.action.nextEditor')<CR>
  map H <Cmd>call VSCodeNotify('workbench.action.previousEditor')<CR>
  map <C-h> <Cmd>call VSCodeNotify('workbench.action.focusLeftGroup')<CR>
  map <C-j> <Cmd>call VSCodeNotify('workbench.action.focusBelowGroup')<CR>
  map <C-k> <Cmd>call VSCodeNotify('workbench.action.focusAboveGroup')<CR>
  map <C-l> <Cmd>call VSCodeNotify('workbench.action.focusRightGroup')<CR>
  map <C-i> <Cmd>call VSCodeNotify('workbench.action.navigateForward')<CR>
  map <C-o> <Cmd>call VSCodeNotify('workbench.action.navigateBack')<CR>
  " Line end (Ctrl+E) - directly map $ to avoid VSCode command mismatch
  nnoremap <silent> <C-e> $
  xnoremap <silent> <C-e> $

  " Buffers(Tabs)
  map <leader>bd <Cmd>call VSCodeNotify('workbench.action.closeActiveEditor')<CR>
  map <leader>ft <Cmd>call VSCodeNotify('workbench.action.terminal.toggleTerminal')<CR>

  " Code
  map <leader>cr <Cmd>call VSCodeNotify('editor.action.rename')<CR>
  map <leader>ca <Cmd>call VSCodeNotify('editor.action.quickFix')<CR>
  map <leader>cf <Cmd>call VSCodeNotify('editor.action.formatDocument')<CR>
  map <leader>cd <Cmd>call VSCodeNotify('editor.action.showHover')<CR>

  " Fold
  map zc <Cmd>call VSCodeNotify('editor.fold')<CR>
  map zC <Cmd>call VSCodeNotify('editor.foldAll')<CR>
  map zo <Cmd>call VSCodeNotify('editor.unfold')<CR>
  map zO <Cmd>call VSCodeNotify('editor.unfoldAll')<CR>

  " Comment
  map gcc <Cmd>call VSCodeNotify('editor.action.commentLine')<CR>

  " LSP
  " Goto Implementation
  map gI <Cmd>call VSCodeNotify('editor.action.goToImplementation')<CR>
  " Goto References
  map gr <Cmd>call VSCodeNotify('references-view.findReferences')<CR>
  " Goto T[y]pe Definition
  map gy <Cmd>call VSCodeNotify('editor.action.goToTypeDefinition')<CR>

  " telescope.nvim equivalent
  map <leader>/ <Cmd>call VSCodeNotify('workbench.action.findInFiles')<CR>
  map <leader>ff <Cmd>call VSCodeNotify('workbench.action.quickOpen')<CR>
  map <leader>fr <Cmd>call VSCodeNotify('workbench.action.openRecent')<CR>

  " aerial.nvim/trouble.nvim equivalent
  map <leader>co <Cmd>call VSCodeNotify('outline.focus')<CR>
  map <leader>cs <Cmd>call VSCodeNotify('workbench.action.gotoSymbol')<CR>

  " neo-tree.nvim equivalent
  map <leader>e <Cmd>call VSCodeNotify('workbench.view.explorer')<CR>

  " VSCode Original
  map gne <Cmd>call VSCodeNotify('editor.action.marker.nextInFiles')<CR>
  map gnc <Cmd>call VSCodeNotify('workbench.action.editor.nextChange')<CR>
  map gpc <Cmd>call VSCodeNotify('workbench.action.editor.previousChange')<CR>
  map <leader>ch <Cmd>call VSCodeNotify('references-view.showCallHierarchy')<CR>

endif
