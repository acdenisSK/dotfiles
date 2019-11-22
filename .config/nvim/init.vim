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

call plug#begin()

Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'

Plug 'autozimu/LanguageClient-neovim', { 'branch': 'next', 'do': 'bash install.sh' }
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'junegunn/fzf'
Plug 'jansenm/vim-cmake'

Plug 'scrooloose/nerdtree'

Plug 'sheerun/vim-polyglot'
Plug 'matthewbdaly/vim-filetype-settings'

Plug 'itchyny/lightline.vim' 
Plug 'flrnd/plastic.vim'

Plug 'majutsushi/tagbar'

call plug#end()

set hidden

let g:LanguageClient_serverCommands = { 'rust': ['ra_lsp_server'], 'cpp': ['clangd'] }

nnoremap <silent> <F5> :call LanguageClient_contextMenu()<CR>
nnoremap <silent> <F2> :call LanguageClient#textDocument_rename()<CR>
nnoremap <silent> <F8> :TagbarToggle<CR>

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

noremap <C-n> :NERDTreeToggle<CR>

let g:netrw_banner = 0
let g:netrw_liststyle = 3
let g:netrw_winsize = 20

let g:deoplete#enable_at_startup = 1

set background=dark
syntax on
colorscheme plastic

let g:lightline = { 'colorscheme': 'plastic' }
