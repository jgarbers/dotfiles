" Garbs' vim configuration. 
"
" This is a more minimal config; let's see if we can clean things up.
"
syntax enable
filetype plugin indent on

set nocompatible
set autoread
set autoindent
set backspace=indent,eol,start
set encoding=utf-8
set guitablabel=%N/\ %t\ %M
set hidden
set history=1000
set laststatus=2
set mouse=nicr
set noswapfile
set nowrap
set rnu
set shortmess+=I
set showcmd
set statusline=%<\ %F%m%r%=\ %{&fileformat}\ \|\ %{fugitive#statusline()}\ \|\ %{&filetype}\ \|\ LN\ %l:%c
set title
set ttimeout
set ttimeoutlen=100
set wildmenu

" We avoid using backup to get good filesystem events on changes.
set nobackup
set nowritebackup

" Persistent undo
set undofile
set undodir=~/.vim/undodir
set undolevels=1000
set undoreload=10000
 
" Tabstops
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab

" Searching
set ignorecase
set smartcase
set incsearch
set showmatch
set hlsearch

" Vundle setup.
 set rtp+=~/.vim/bundle/vundle/
 call vundle#rc()

" Plugins
Plugin 'gmarik/vundle'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'altercation/vim-colors-solarized'

" Appearance
let g:airline_powerline_fonts=1
let g:solarized_termtrans = 1
colorscheme solarized
set background=dark
set t_Co=256

highlight Comment cterm=italic
highlight NonText guifg=#d0d0d0
highlight SpecialKey guifg=#d0d0d0

" Prettier tab/EOL chars
set listchars=tab:▸\ ,eol:¬,trail:·

if has("gui_running")
    set guioptions=egmrt
    set guifont=Inconsolata-dz\ for\ Powerline:h12
    set linespace=2
endif

" Printing
set printoptions=paper:letter

" My mappings
inoremap kj <Esc>

nmap <C-j> <C-w>j
nmap <C-h> <C-w>h
nmap <C-k> <C-w>k
nmap <C-l> <C-w>l

nnoremap <leader><space> :noh<CR>
nnoremap <leader>x ^iOK <Esc>j^
nnoremap <leader>X ^iNO <Esc>j^

" Exit insert mode when switching away
au FocusLost * call feedkeys("\<C-\>\<C-n>")

" Netrw options
let g:netrw_banner=0        " disable annoying banner
let g:netrw_browse_split=4  " open in prior window
let g:netrw_altv=1          " open splits to the right
let g:netrw_liststyle=3     " tree view
let g:netrw_list_hide=netrw_gitignore#Hide()
let g:netrw_list_hide.=',\(^\|\s\s\)\zs\.\S\+'

" Abbreviations.
iab <expr> isod strftime("%Y-%m-%d")
iab <expr> ddln strftime("------------------------------------------------------------------------<CR>%Y-%m-%d")
iab <expr> isot strftime("%H:%M")

