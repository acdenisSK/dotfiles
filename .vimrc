" Embrace unicode
language en_US.UTF-8
set encoding=utf-8

" Syntax highlighting
syntax on
filetype plugin on

set nocompatible

set number

" Colouring
set termguicolors
set background=dark

" Alter the defaults
set splitbelow
set splitright
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab
set laststatus=2
set signcolumn=yes
set hidden

" Plugins
call plug#begin("$HOME/.vim/plugged")

Plug 'jansenm/vim-cmake'

Plug 'scrooloose/nerdtree'

Plug 'sheerun/vim-polyglot'

Plug 'itchyny/lightline.vim'
Plug 'flrnd/plastic.vim'

Plug 'majutsushi/tagbar'

call plug#end()

tnoremap <Esc> <C-\><C-n>

" Simpler switching between buffers
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

" Utilise built-in autocompletion
inoremap <expr> <tab> InsertTabWrapper()
inoremap <s-tab> <c-n>

" Searching for files easier
" credit: https://youtu.be/XA2WjJbmmoM?t=425
set path+=**
set wildmenu

" Tags
nnoremap <F8> :TagbarToggle<CR>

" File browser
noremap <C-n> :NERDTreeToggle<CR>

" Strip trailing whitespace on save
autocmd BufWritePre * %s/\s\+$//e

" Configure netrw a bit
let g:netrw_banner = 0
let g:netrw_browse_split=4
let g:netrw_liststyle = 3
let g:netrw_winsize = 20

" Theme
colorscheme plastic

let g:lightline = { 'colorscheme': 'plastic' }
