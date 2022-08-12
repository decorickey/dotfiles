" Vim Plugによるプラグインの設定
call plug#begin()
  Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
  Plug 'junegunn/fzf.vim'
  Plug 'preservim/nerdtree'
  Plug 'neoclide/coc.nvim', {'branch': 'release'}

  " カラースキーム
  Plug 'joshdick/onedark.vim'

  " インデント可視化
  Plug 'Yggdroot/indentLine'

call plug#end()

" カラースキーム
colorscheme onedark

" nerdtreeのキーマップ
nnoremap <C-n> :NERDTreeMirror<CR>:NERDTreeFocus<CR>
nnoremap <C-t> :NERDTreeToggle<CR>
nnoremap <C-f> :NERDTreeFind<CR>

" nerdtreeでデフォルト隠しファイル表示
let NERDTreeShowHidden = 1

" Exit Vim if NERDTree is the only window remaining in the only tab.
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif

" Close the tab if NERDTree is the only window remaining in it.
autocmd BufEnter * if winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif

" Open the existing NERDTree on each new tab.
autocmd BufWinEnter * if getcmdwintype() == '' | silent NERDTreeMirror | endif

" coc-nvimの拡張機能管理
let g:coc_global_extensions = 
\[
\ 'coc-cfn-lint',
\ 'coc-eslint',
\ 'coc-json',
\ 'coc-markdownlint',
\ 'coc-pairs',
\ 'coc-prettier',
\ 'coc-pyright',
\ 'coc-spell-checker',
\ 'coc-stylelint',
\ 'coc-stylelintplus',
\ 'coc-yaml',
\]

" coc-nvimのキーマップ
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
vmap <leader>a <Plug>(coc-codeaction-selected)
nmap <leader>a <Plug>(coc-codeaction-selected)
