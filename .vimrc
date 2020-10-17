""""""""""""""""""""""""""
" Embrace unicode
""""""""""""""""""""""""""
language en_US.UTF-8
set encoding=utf-8

""""""""""""""""""""""""""
" Vim-exclusive config
""""""""""""""""""""""""""
set nocompatible
filetype off

""""""""""""""""""""""""""
" Syntax highlighting
""""""""""""""""""""""""""
syntax on
filetype plugin on

""""""""""""""""""""""""""
" Colouring
""""""""""""""""""""""""""

" These two lines are required to enable colours in the alacritty terminal.
" Don't ask me what they do; I don't have a clue either.
let &t_8f="\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b="\<Esc>[48;2;%lu;%lu;%lum"

set termguicolors
set background=dark

""""""""""""""""""""""""""
" Absolute line numbering
""""""""""""""""""""""""""
set number

""""""""""""""""""""""""""
" Plugins
""""""""""""""""""""""""""

" Download the plugin manager if needed.
if empty(glob("~/.vim/autoload/plug.vim"))
    ! curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
endif

call plug#begin("~/.vim/plugged")

Plug 'sheerun/vim-polyglot'

Plug 'ycm-core/YouCompleteMe'
Plug 'mattn/emmet-vim'

Plug 'easymotion/vim-easymotion'

Plug 'ap/vim-css-color'

Plug 'itchyny/lightline.vim'
Plug 'joshdick/onedark.vim'

Plug 'editorconfig/editorconfig-vim'

call plug#end()

""""""""""""""""""""""""""
" Theming
""""""""""""""""""""""""""
colorscheme onedark
let g:lightline = { 'colorscheme': 'onedark' }

""""""""""""""""""""""""""
" Altering defaults
""""""""""""""""""""""""""

" Set the leader key to a space
let mapleader = " "

" Do not show the current mode. The theme already does it for us.
set noshowmode

set splitbelow splitright

" Do not wrap the line to the next row if it exceeds the column limit.
set nowrap

""""""""""""""""""""""""""
"" Indenting
""""""""""""""""""""""""""

" Use spaces in lieu of tabs
set expandtab
set smarttab

" A tab is equal to four spaces
set tabstop=4
set shiftwidth=4

""""""""""""""""""""""""""
" Altering defaults cont.
""""""""""""""""""""""""""

" Always show the statusline
set laststatus=2

" When changing buffers, hide them
set hidden

" Do not highlight the text when searching
set nohlsearch

" Do not make backups each time before overwriting a file
set nobackup
set nowritebackup

" Neither make swaps of currently open files
set noswapfile

" Limit the amount of lines in the command line.
set cmdheight=2

set shortmess+=c

set signcolumn=yes

" Searching for files easier
" credit: https://youtu.be/XA2WjJbmmoM?t=425
set path+=**
set wildmenu

" Strip trailing whitespace on save
autocmd BufWritePre * %s/\s\+$//e

" Configure netrw
let g:netrw_banner = 0
let g:netrw_browse_split=0
let g:netrw_liststyle = 3
let g:netrw_winsize = 20
let g:netrw_keepdir=0

""""""""""""""""""""""""""
" Keybindings
""""""""""""""""""""""""""

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

" Utilise builtin autocompletion
inoremap <expr> <tab> InsertTabWrapper()

" Open the builtin explorer (netrw)
nnoremap <C-D> :Explore<CR>
