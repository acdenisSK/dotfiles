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

if has("termguicolors")
    set termguicolors
endif

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

if has('python3')
  if has('nvim')
    Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
  else
    Plug 'Shougo/deoplete.nvim'
    Plug 'roxma/nvim-yarp'
    Plug 'roxma/vim-hug-neovim-rpc'
  endif

  Plug 'lighttiger2505/deoplete-vim-lsp'

  Plug 'prabirshrestha/vim-lsp'
  Plug 'mattn/vim-lsp-settings'

  Plug 'thomasfaingnaert/vim-lsp-snippets'
  Plug 'thomasfaingnaert/vim-lsp-ultisnips'
endif

Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'

Plug 'easymotion/vim-easymotion'

Plug 'mattn/emmet-vim'
Plug 'ap/vim-css-color'

Plug 'itchyny/lightline.vim'
Plug 'morhetz/gruvbox'

Plug 'editorconfig/editorconfig-vim'

call plug#end()

""""""""""""""""""""""""""
" Plugin configuration
""""""""""""""""""""""""""
function! s:on_lsp_buffer_enabled() abort
    setlocal omnifunc=lsp#complete
    setlocal signcolumn=yes
    if exists('+tagfunc') | setlocal tagfunc=lsp#tagfunc | endif
    nmap <buffer> gd <plug>(lsp-definition)
    nmap <buffer> <F2> <plug>(lsp-rename)
endfunction

augroup lsp_install
    au!
    " call s:on_lsp_buffer_enabled only for languages that has the server registered.
    autocmd User lsp_buffer_enabled call s:on_lsp_buffer_enabled()
augroup END

autocmd BufReadPost,BufNewFile *.c,*.h,*.cpp,*.hpp,*.rs,*.py,*.html,*.css,*.js,CMakeLists.txt,meson.build,Cargo.toml call deoplete#enable()

let g:UltiSnipsExpandTrigger="<c-j>"
let g:UltiSnipsJumpForwardTrigger="<c-f>"
let g:UltiSnipsJumpBackwardTrigger="<c-b>"

""""""""""""""""""""""""""
" Theming
""""""""""""""""""""""""""
colorscheme gruvbox
let g:lightline = { 'colorscheme': 'gruvbox' }

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

" Do not wrap the line to the next row if it exceeds the column limit.
" Also display a ruler to keep track of the number of characters in a line
set nowrap
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

" Get rid of the clutter in GVim
set guioptions-=m
set guioptions-=T
set guioptions-=r
set guioptions-=e

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
