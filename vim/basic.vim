"行番号を表示する
set number

"カーソル行の背景色を変える
set cursorline

"ステータス行を常に表示する
set laststatus=2

"対応する括弧を強調する
set showmatch

"不可視文字を表示する
set list
set listchars=tab:»-

"勝手に折りたたみを禁止
set nofoldenable

"swapファイルを作らない
set noswapfile

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

"検索文字列をハイライト
set hlsearch

"検索時に大文字と小文字を区別しない
set ignorecase

"インクリメンタルサーチを行う
set incsearch

"検索時に大文字と小文字を混在させると考慮する
set smartcase

"最後まで検索したら先頭に戻る
set wrapscan

"改行時に前の行のインデントを継続する
set autoindent

"autoindentと合わせてインデント増減の微調整も行う
set smartindent

"行単位でインデント(>)する際にshiftwidthの分のスペースを入力する
set smarttab
set shiftwidth=4

"1つのtab文字としてカウントするスペース数
set tabstop=4

"tab入力時に挿入するスペース数
set softtabstop=4

"tab文字をスペースに置き換える（:set noet , set et で切り替え可能）
set expandtab

"markdownではtab文字を2スペースとして扱う
autocmd FileType markdown setlocal softtabstop=2 shiftwidth=2

"クリップボードとyank,putを連携
set clipboard+=unnamed,unnamedplus

"insertモードを抜けると自動でIMEオフ
set iminsert=2

" コマンドラインモードでTABキーによるファイル名補完を有効にする
set wildmenu wildmode=list:longest,full

"ファイル形式の検出、プラグインやインデントのロードを有効にする
filetype plugin indent on

"grep系実行時に自動でQuickFixを開く
autocmd QuickFixCmdPost *grep* cwindow

"シンタックスハイライトをonにする
syntax on

