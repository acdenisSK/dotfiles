language en_US.UTF-8

filetype plugin indent on

set encoding=utf-8
set number
set termguicolors
set splitbelow
set splitright
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab
set laststatus=2
set signcolumn=yes

call plug#begin("$HOME/.vim/plugged")

Plug 'jansenm/vim-cmake'

Plug 'scrooloose/nerdtree'

Plug 'sheerun/vim-polyglot'

Plug 'itchyny/lightline.vim' 
Plug 'flrnd/plastic.vim'

Plug 'majutsushi/tagbar'

call plug#end()

set hidden

tnoremap <Esc> <C-\><C-n>

nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

function! InsertTabWrapper()
    let col = col('.') - 1
    if !col || getline('.')[col - 1] !~ '\k'
        return "\<tab>"
    else
        return "\<c-n>"
    endif
endfunction

inoremap <expr> <tab> InsertTabWrapper()
inoremap <s-tab> <c-n>

nnoremap <F8> :TagbarToggle<CR>
noremap <C-n> :NERDTreeToggle<CR>

autocmd BufWritePre * %s/\s\+$//e

let g:netrw_banner = 0
let g:netrw_liststyle = 3
let g:netrw_winsize = 20

set background=dark
syntax on
colorscheme plastic

let g:lightline = { 'colorscheme': 'plastic' }
