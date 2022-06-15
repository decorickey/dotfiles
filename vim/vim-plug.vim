" Vim Plugによるプラグインの設定
call plug#begin()
    " ファイルツリー
    Plug 'preservim/nerdtree'

    " fzf
    Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }

    " 括弧などの補完
    Plug 'cohama/lexima.vim'

    " コード補完（node.jsが必要）
    Plug 'neoclide/coc.nvim', {'branch': 'release'}

call plug#end()

" nerdtreeのキーマップ
nnoremap <C-n> :NERDTreeMirror<CR>:NERDTreeFocus<CR>
nnoremap <C-t> :NERDTreeToggle<CR>
nnoremap <C-f> :NERDTreeFind<CR>

" nerdtreeでデフォルト隠しファイル表示
let NERDTreeShowHidden = 1

" Start NERDTree when Vim is started without file arguments.
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists('s:std_in') | NERDTree | endif

" Exit Vim if NERDTree is the only window remaining in the only tab.
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif

" Close the tab if NERDTree is the only window remaining in it.
autocmd BufEnter * if winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif

" Open the existing NERDTree on each new tab.
autocmd BufWinEnter * if getcmdwintype() == '' | silent NERDTreeMirror | endif

" coc-nvimの拡張機能管理
let g:coc_global_extensions = 
\[
\   'coc-json',
\   'coc-yaml',
\   'coc-markdownlint',
\   'coc-pyright',
\   'coc-eslint',
\   'coc-stylelint',
\   'coc-stylelintplus',
\]

" coc-nvimのキーマップ
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

