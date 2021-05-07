"dein scripts-----------------------------
if &compatible
  set nocompatible               " be improved
endif

" required:
set runtimepath+=~/.cache/dein/repos/github.com/shougo/dein.vim

" required:
if dein#load_state('~/.cache/dein')
  call dein#begin('~/.cache/dein')

  " let dein manage dein
  " required:
  call dein#add('~/.cache/dein/repos/github.com/shougo/dein.vim')


  "colorscheme（カラースキーム）
  "call dein#add('jpo/vim-railscasts-theme')
  call dein#add('crusoexia/vim-monokai')
  "call dein#add('cohlin/vim-colorschemes')

  "easymotion
  call dein#add('lokaltog/vim-easymotion')

  "マークダウン用プラグイン
  call dein#add('plasticboy/vim-markdown')

  "ステータスバーを綺麗に見せる
  call dein#add('vim-airline/vim-airline')

  "gitの基本プラグイン
  call dein#add('tpope/vim-fugitive')

  "gitの変更点を左に表示
  call dein#add('airblade/vim-gitgutter')

  "何でもインクリメンタルサーチする
  call dein#add('junegunn/fzf', { 'build': './install --all', 'merged': 0 })
  call dein#add('junegunn/fzf.vim', { 'depends': 'fzf' })

  "インデントを可視化する
  call dein#add('nathanaelkane/vim-indent-guides')
  call dein#add('yggdroot/indentline')

  "余計な空白を可視化する
  call dein#add('bronson/vim-trailing-whitespace')

  "ファイルツリー表示を表示する
  call dein#add('scrooloose/nerdtree')

  "タブとファイルツリーを同期する
  call dein#add('jistr/vim-nerdtree-tabs')

  "プラグインのキャッシュクリアを自動で行う
  call dein#add('recache_runtimepath')

  "カッコを自動で閉じる
  call dein#add('jiangmiao/auto-pairs')

  "スクロールをなめらかに見せる
  call dein#add('yuttie/comfortable-motion.vim')

  "tab補完を有効にする
  call dein#add('ervandew/supertab')

  "置換をプレビューする
  call dein#add('osyo-manga/vim-over')

  "HTMLやXMLのタグを自動で閉じる
  call dein#add('alvan/vim-closetag')

  " required:
  call dein#end()
  call dein#save_state()
endif

" required:
filetype plugin indent on
syntax enable

" if you want to install not installed plugins on startup.
if dein#check_install()
  call dein#install()
endif

"end dein scripts-------------------------
