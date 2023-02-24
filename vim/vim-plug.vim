" Vim Plug
call plug#begin()
  Plug 'neoclide/coc.nvim', {'branch': 'release'}

  " Color Scheme
  Plug 'joshdick/onedark.vim'

  " Tree Viewer
  Plug 'lambdalisue/fern.vim'
  Plug 'lambdalisue/fern-git-status.vim'

  " Status Line
  Plug 'itchyny/lightline.vim'

  " Indent
  Plug 'Yggdroot/indentLine'

  " Fuzzy Finder
  Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
  Plug 'junegunn/fzf.vim'

  " Git
  Plug 'tpope/vim-fugitive'

call plug#end()

" Color Scheme
colorscheme onedark

" fern.vim
let g:fern#default_hidden=1
nnoremap <C-n> :Fern . -drawer -toggle -reveal=%<CR>

" coc.nvim
let g:coc_global_extensions = 
\[
\  'coc-git',
\  'coc-spell-checker',
\  'coc-yaml',
\  'coc-json',
\  'coc-eslint',
\]

