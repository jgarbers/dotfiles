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
set mouse=a
set noswapfile
set nowrap
set rnu
set shortmess+=I
set showcmd
set statusline=%<\ %F%m%r%=\ %{&fileformat}\ \|\ %{fugitive#statusline()}\ \|\ %{&filetype}\ \|\ LN\ %l:%c
set title
set ttimeout
set ttimeoutlen=100

set wildchar=<Tab>
set wildmenu
set wildmode=full

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
set smarttab

" Searching
set ignorecase
set smartcase
set incsearch
set showmatch
set hlsearch

packadd! matchit

" Vundle setup.
 set rtp+=~/.vim/bundle/vundle/
 call vundle#rc()

" Plugins
Plugin 'gmarik/vundle'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'altercation/vim-colors-solarized'
Plugin 'tpope/vim-commentary'
Plugin 'tpope/vim-unimpaired'
Plugin 'tpope/vim-surround'
Plugin 'scrooloose/nerdtree'
Plugin 'scrooloose/syntastic'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'kana/vim-arpeggio'
Plugin 'Chiel92/vim-autoformat'

" Python-dev specific
" Plugin 'nvie/vim-flake8'
Plugin 'andviro/flake8-vim'
Plugin 'Glench/Vim-Jinja2-Syntax'


" Web-dev specific
" Plugin 'pangloss/vim-javascript'
" Plugin 'mxw/vim-jsx'
" let g:jsx_ext_required = 0
" Plugin 'chemzqm/vim-jsx-improve'
autocmd FileType javascript setlocal shiftwidth=2 tabstop=2 softtabstop=2
autocmd FileType html setlocal shiftwidth=2 tabstop=2 softtabstop=2


" Snippets
" Plugin 'sirver/ultisnips'
" Plugin 'honza/vim-snippets'

" Appearance
let g:airline_powerline_fonts=1
let g:solarized_termtrans = 1
colorscheme solarized
set background=dark
set t_Co=256

highlight Comment cterm=italic
highlight NonText guifg=#d0d0d0
highlight SpecialKey guifg=#d0d0d0
highlight MatchParen cterm=bold ctermbg=none ctermfg=magenta

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
nnoremap <leader>b :ls<CR>:b 
nnoremap <leader>d :call BufferDelete()<CR>
nnoremap <leader>2 :NERDTreeToggle<CR>
nnoremap <leader>7 :call flake8#Flake8()<CR>
nnoremap <leader>q :q<CR>
nnoremap <leader>w :w<CR>
nnoremap <leader>f :Autoformat<CR>
nnoremap <leader>5 :let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar><CR>
nnoremap <leader>X ^iNO <Esc>j^
nnoremap <Leader>c :r ~/.dotfiles/snippets/docstring.txt<CR><C-j>C
nnoremap <Leader>C :call <SID>ToggleColorColumn()<CR>

nnoremap <F2> :NERDTreeToggle<CR>
nnoremap <F5> :let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar><CR>

" Arpeggio mappings
call arpeggio#load()
Arpeggio inoremap jk <Esc>

" Exit insert mode when switching away
au FocusLost * call feedkeys("\<C-\>\<C-n>")

" Netrw options
let g:netrw_banner=0        " disable annoying banner
let g:netrw_browse_split=4  " open in prior window
let g:netrw_altv=1          " open splits to the right
let g:netrw_winsize=25      " 25% of window width
let g:netrw_liststyle=3     " tree view
let g:netrw_list_hide=netrw_gitignore#Hide()
let g:netrw_list_hide.=',\(^\|\s\s\)\zs\.\S\+'

" NERDTree options
let NERDTreeMapOpenVSplit="<C-v>"
let NERDTreeMapOpenSplit="<C-s>"
let NERDTreeIgnore = ['\.pyc$']
let NERDTreeHijackNetrw=1
let NERDTreeMinimalUI=1

" CtrlP options
 let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files -co --exclude-standard']

" Syntastic options
let g:syntastic_javascript_checkers = ['eslint']

" Abbreviations.
iab <expr> isod strftime("%Y-%m-%d")
iab <expr> ddln strftime("------------------------------------------------------------------------<CR>%Y-%m-%d")
iab <expr> isot strftime("%H:%M")
iab <expr> gtc strftime("# Copyright (c) %Y Georgia Tech Research Corporation. All rights reserved.")

" Enable pane dragging via mouse under Tmux
set ttymouse=xterm2

" Functions.

" Toggle colored right border
let s:color_column_old = 80
function! s:ToggleColorColumn()
    if s:color_column_old == 0
        let s:color_column_old = &colorcolumn
        let &colorcolumn = 0
    else
        let &colorcolumn=s:color_column_old
        let s:color_column_old = 0
    endif
endfunction

" Safe buffer delete.
function! BufferDelete()
    if &modified
        echohl ErrorMsg
        echomsg "No write since last change. Not closing buffer."
        echohl NONE
    else
        let s:total_nr_buffers = len(filter(range(1, bufnr('$')), 'buflisted(v:val)'))

        if s:total_nr_buffers == 1
            bdelete
            echo "Buffer deleted. Created new buffer."
        else
            bprevious
            bdelete #
            echo "Buffer deleted."
        endif
    endif
endfunction
