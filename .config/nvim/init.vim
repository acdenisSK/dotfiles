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
" Absolute line numbering
""""""""""""""""""""""""""
set number

""""""""""""""""""""""""""
" Plugins
""""""""""""""""""""""""""

" Download the plugin manager if needed.
if empty(glob("~/.local/share/nvim/site/autoload/plug.vim"))
    ! curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
endif

call plug#begin(stdpath("data") . "/plugged")

Plug 'sheerun/vim-polyglot'

Plug 'mattn/emmet-vim'
Plug 'ap/vim-css-color'

Plug 'itchyny/lightline.vim'
Plug 'morhetz/gruvbox'

Plug 'editorconfig/editorconfig-vim'

Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/nvim-compe'

call plug#end()

luafile ~/.config/nvim/lsp.lua

""""""""""""""""""""""""""
" Theming
""""""""""""""""""""""""""
set background=dark

if has("termguicolors")
    set termguicolors

    let &t_8f="\<Esc>[38;2;%lu;%lu;%lum"
    let &t_8b="\<Esc>[48;2;%lu;%lu;%lum"

    let g:gruvbox_invert_selection = '0'
    colorscheme gruvbox
    let g:lightline = { 'colorscheme': 'gruvbox' }
endif

""""""""""""""""""""""""""
" Altering defaults
""""""""""""""""""""""""""

" Set the leader key to a space
let mapleader = " "

" Do not show the current mode. The theme already does it for us.
set noshowmode

" Split windows in a sane way, new window on the bottom vertically and right
" horizontally
set splitbelow splitright

set scrolloff=3
set sidescroll=3

" Display a ruler to keep track of the number of characters in a line
set ruler
set cc=80

" Improve regex
set magic
" Ignore the case in a pattern
set ignorecase
set smartcase

""""""""""""""""""""""""""
"" Indenting
""""""""""""""""""""""""""

" Use spaces in lieu of tabs
set expandtab
set smarttab

" A tab is equal to four spaces
set tabstop=4
set shiftwidth=4

" Copy indents when creating new lines
set autoindent

""""""""""""""""""""""""""
" Altering defaults cont.
""""""""""""""""""""""""""

" Always use newlines for delimiting a line
set fileformat=unix

" Always show the statusline
set laststatus=2

" When changing buffers, hide them
set hidden

set backspace=indent,eol,start

" Highlight text when searching
set incsearch
set showmatch
set hlsearch
" Clear the highlighting
nnoremap \\ :noh<cr>

" Allow resizing windows with the mouse
set mouse=a

" Do not make backups each time before overwriting a file
set nobackup
set nowritebackup

" Neither make swaps of currently open files
set noswapfile

" Limit the amount of lines in the command line.
set cmdheight=2

set shortmess+=c
set signcolumn=yes
set lazyredraw

" Disable Ex mode
nnoremap Q <Nop>

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
