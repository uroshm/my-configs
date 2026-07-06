nmap ; :
syntax on
set clipboard=unnamed
set number
set relativenumber
set tabstop=4
set shiftwidth=4
set expandtab
set autoindent
set smartindent
syntax on
filetype plugin indent on

" Search improvements
set ignorecase
set smartcase

inoremap jj <ESC>


" Toggle file tree
nnoremap <C-n> :NERDTreeToggle<CR>
" "
" " " FZF file search
nnoremap <C-p> :Files<CR>

"autocmd VimEnter * NERDTree

" Tab navigation
nnoremap <Tab> gt
nnoremap <S-Tab> gT
"
" " New tab
nnoremap <leader>t :tabnew<CR>
"
" " Close tab
nnoremap <leader>q :tabclose<CR>


call plug#begin()

" File explorer
Plug 'preservim/nerdtree'

" Fuzzy search
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }

" Java LSP support
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'junegunn/fzf.vim'
call plug#end()
