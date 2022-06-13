" インデントとタブの個別設定
" shiftwidth: インデントのスペース数
" expandtab/noexpandtab: タブ入力時のスペース切り替え
" tabstop: タブのスペース数
autocmd FileType markdown   setlocal shiftwidth=4 expandtab tabstop=4
autocmd FileType html       setlocal shiftwidth=2 expandtab tabstop=2
autocmd FileType css        setlocal shiftwidth=2 expandtab tabstop=2
autocmd FileType javascript setlocal shiftwidth=2 expandtab tabstop=2
autocmd FileType vue        setlocal shiftwidth=2 expandtab tabstop=2
autocmd FileType python     setlocal shiftwidth=4 expandtab tabstop=4

