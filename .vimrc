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
call plug#begin("~/.vim/plugged")

Plug 'neoclide/coc.nvim', {'branch': 'release'}

Plug 'jansenm/vim-cmake'

Plug 'scrooloose/nerdtree'

Plug 'sheerun/vim-polyglot'

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

" Limit the amount of lines in the command line.
set cmdheight=2

" How many milliseconds before Vim will write into the swap file of a buffer.
set updatetime=300

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
let g:netrw_browse_split=4
let g:netrw_liststyle = 3
let g:netrw_winsize = 20

""""""""""""""""""""""""""
" Keybindings (and CoC configuration)
""""""""""""""""""""""""""

" Simpler switching between buffers
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

inoremap <silent><expr> <c-space> coc#refresh()

inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

nmap <F2> <Plug>(coc-rename)

nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" File browser
noremap <C-n> :NERDTreeToggle<CR>
