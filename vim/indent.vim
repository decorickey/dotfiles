" インデントとタブの個別設定
" shiftwidth: インデントのスペース数
" expandtab/noexpandtab: タブ入力時のスペース切り替え
" tabstop: タブのスペース数
set shiftwidth=2
set expandtab
set tabstop=2
autocmd FileType python   setlocal shiftwidth=4 expandtab tabstop=4
autocmd FileType markdown setlocal shiftwidth=4 expandtab tabstop=4
autocmd FileType groovy   setlocal shiftwidth=4 expandtab tabstop=4

