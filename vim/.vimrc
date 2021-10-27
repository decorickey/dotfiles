"ステータス行を常に表示する
set laststatus=2

"対応する括弧を強調する
set showmatch

"勝手に折りたたみを禁止
set nofoldenable

"タブページ（タブ情報）を表示）
set showtabline=2

" Backspaceキーがどこでも使えるようにする
set backspace=indent,eol,start

" 行頭行末の左右移動で行をまたぐ
set whichwrap=b,s,h,l,<,>,[,]

"編集中でも他のファイルを開ける
"set hidden

"編集中のファイルが変更されたら自動で読み込む
set autoread

"バックアップファイルを作らない
set nobackup

"インクリメンタルサーチを行う
set incsearch

"最後まで検索したら先頭に戻る
set wrapscan

"autoindentと合わせてインデント増減の微調整も行う
set smartindent
set smarttab

"markdownではtab文字を2スペースとして扱う
autocmd FileType markdown setlocal softtabstop=2 shiftwidth=2

"クリップボードとyank,putを連携
set clipboard+=unnamed,unnamedplus

" コマンドラインモードでTABキーによるファイル名補完を有効にする
set wildmenu wildmode=list:longest,full

"ファイル形式の検出、プラグインやインデントのロードを有効にする
filetype plugin indent on

"grep系実行時に自動でQuickFixを開く
autocmd QuickFixCmdPost *grep* cwindow

