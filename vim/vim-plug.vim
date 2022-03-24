" Vim Plugによるプラグインの設定
call plug#begin()
    " ファイルツリー
    Plug 'preservim/nerdtree'

    " ファイル検索
    Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }

    " コード補完（node.jsが必要）
    Plug 'neoclide/coc.nvim', {'branch': 'release'}

    " インデント色付け
    Plug 'nathanaelkane/vim-indent-guides'

    " 括弧などの補完
    Plug 'cohama/lexima.vim'

call plug#end()

" nerdtreeのキーマップ
nnoremap <C-n> :NERDTreeToggle<CR>

" インデント色付け
let g:indent_guides_enable_on_vim_startup = 1

" coc-nvimの拡張機能管理
let g:coc_global_extensions = []

