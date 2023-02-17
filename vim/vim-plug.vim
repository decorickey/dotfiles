" Vim Plug
call plug#begin()
  Plug 'neoclide/coc.nvim', {'branch': 'release'}

  " Coloer Scheme
  Plug 'joshdick/onedark.vim'

  " Tree Viewer
  Plug 'lambdalisue/fern.vim'

  " Status Line
  Plug 'itchyny/lightline.vim'

  " Indent
  Plug 'Yggdroot/indentLine'

  " Fuzzy Finder
  Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
  Plug 'junegunn/fzf.vim'

call plug#end()

colorscheme onedark

let g:coc_global_extensions = 
\[
\  'coc-git',
\]

