" Vim Plugによるプラグインの設定
call plug#begin()
    " ファイルツリー
    Plug 'preservim/nerdtree'

    " ファイル検索
    " brew install fzf
    Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }

    " gitのプラグイン（git blameなど）
    " neovimだとインストール先が違うので注意
    " https://github.com/tpope/vim-fugitive

    " gitのプラグイン（変更点表示）
    " https://github.com/airblade/vim-gitgutter

    " シンタックスハイライトの拡張
    " Plug 'sheerun/vim-polyglot'

    " コード補完（node.jsが必要）
    Plug 'neoclide/coc.nvim', {'branch': 'release'}

    " 複数行コメント（gc）
    " https://github.com/tpope/vim-commentary

    Plug 'nathanaelkane/vim-indent-guides'

call plug#end()

" nerdtreeのキーマップ
nnoremap <C-n> :NERDTreeToggle<CR>

" インデント色付け
let g:indent_guides_enable_on_vim_startup = 1
