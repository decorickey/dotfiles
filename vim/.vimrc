"markdownではtab文字を2スペースとして扱う
autocmd FileType markdown setlocal softtabstop=2 shiftwidth=2

"grep系実行時に自動でQuickFixを開く
autocmd QuickFixCmdPost *grep* cwindow

