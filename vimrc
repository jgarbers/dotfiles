" Garbs' vim configuration. 
"
syntax on
set nocompatible
set nobackup
set noswapfile
set history=1000
set undolevels=1000
set title
set encoding=utf-8
set hidden
set showcmd
set nowrap
set laststatus=2
" set autoindent
set wildmenu
set autoread
set t_Co=256
set rnu
set shortmess+=I
set guitablabel=%N/\ %t\ %M
set statusline=%<\ %F%m%r%=\ %{&fileformat}\ \|\ %{fugitive#statusline()}\ \|\ %{&filetype}\ \|\ LN\ %l:%c
set mouse=nicr

" We avoid using backup to get good filesystem events on changes.
set nobackup
set nowritebackup

" Persistent undo
set undofile
set undodir=~/.vim/undodir
set undolevels=1000
set undoreload=10000

filetype plugin on
filetype indent on
set omnifunc=syntaxcomplete#Complete

" runtime macros/matchit.vim

" Abbreviations.
iab <expr> isod strftime("%Y-%m-%d")
iab <expr> ddln strftime("------------------------------------------------------------------------<CR>%Y-%m-%d")
iab <expr> isot strftime("%H:%M")

" Tags stuff
" let g:autotagVerbosityLevel=9

" Use space for easymotion leader
let g:EasyMotion_leader_key = '<Space>'

" Vundle setup.
 set rtp+=~/.vim/bundle/vundle/
 call vundle#rc()

" Plugins
Plugin 'gmarik/vundle'
Plugin 'Lokaltog/vim-easymotion'
" Plugin 'Lokaltog/vim-powerline'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'edkolev/tmuxline.vim'
Plugin 'rking/ag.vim'
Plugin 'scrooloose/nerdtree'
Plugin 'scrooloose/syntastic'
Plugin 'tomtom/tcomment_vim'
Plugin 'kien/ctrlp.vim'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-surround'
Plugin 'sandeepcr529/Buffet.vim'
Plugin 'Chiel92/vim-autoformat'
Plugin 'altercation/vim-colors-solarized'

" XML folding
:let g:xml_syntax_folding = 1
:set foldmethod=syntax

" No Markdown folding
let g:vim_markdown_folding_disabled = 1

" Airline fonts
let g:airline_powerline_fonts=1


let g:solarized_termtrans = 1
colorscheme solarized
set background=dark

highlight NonText guifg=#d0d0d0
highlight SpecialKey guifg=#d0d0d0
highlight Comment cterm=italic

if has("gui_running")
    set guioptions=egmrt
    set guifont=Inconsolata-dz\ for\ Powerline:h12
    set linespace=2
endif

" Autoformat stuff.
let g:formatprg_arduino = "astyle"
let g:formatprg_args_arduino = "--style=ansi -pcHs2"

let g:formatprg_c = "astyle"
let g:formatprg_args_c = "--style=ansi -pcHs2"

" Tabstop stuff.
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

" Prettier tab/EOL chars
set listchars=tab:▸\ ,eol:¬,trail:·

" Source the vimrc file after saving it, and other autocommands.
if has("autocmd")
  autocmd BufWritePost .vimrc source $MYVIMRC
endif

" My mappings
inoremap kj <Esc>

nmap <C-j> <C-w>j
nmap <C-h> <C-w>h
nmap <C-k> <C-w>k
nmap <C-l> <C-w>l

nnoremap <leader><space> :noh<CR>
nnoremap <leader>a :Ag
nnoremap <leader>B :Bufferlist<cr>
nnoremap <Leader>C :call <SID>ToggleColorColumn()<cr>
nnoremap <leader>d :call BufferDelete()<CR>
nnoremap <leader>D :cd ~/Desktop/<CR>
nnoremap <leader>eV <C-w><C-v><C-l>:e $MYVIMRC<CR>
nnoremap <leader>gl :Glog<CR>
nnoremap <leader>gs :Gstatus<CR>
nnoremap <leader>gg :GitGutterToggle<CR>
nnoremap <leader>o :CtrlPMRUFiles<CR>
nnoremap <leader>j :%! python -mjson.tool<CR>
nnoremap <leader>L :set nu! \| set list!<CR>
nnoremap <leader>N :set rnu!<CR>
" nnoremap <leader>M :silent !open -a Marked.app '%:p'<cr>
nnoremap <leader>n :cn<CR>
nnoremap <leader>p :cp<CR>
" nnoremap <leader>t :VimwikiToggleListItem<cr>
nnoremap <leader>w :wa<CR>
nnoremap <leader>x ^iOK <Esc>j^
nnoremap <leader>X ^iNO <Esc>j^
nnoremap <leader>z :ZoomWin<CR>

"Remove all trailing whitespace by pressing F5
nnoremap <F5> :let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar><CR>

map <F1> :help 
map <F2> :NERDTreeToggle<CR>
map <S-F2> :NERDTreeFind<CR>
map <F3> :Autoformat<CR>

"
" map <F5> :!ano build && ano upload<CR>
" map <F3> :call ToggleQuickfixList()<CR>
" map <F4> :TlistToggle<CR>
" map <F5> :GundoToggle<CR>

" Exit insert mode when switching away
au FocusLost * call feedkeys("\<C-\>\<C-n>")

" Drew's edit-from-here mappings from vimcasts.org
map <leader>ew :e <C-R>=expand("%:p:h") . "/" <CR>
map <leader>es :sp <C-R>=expand("%:p:h") . "/" <CR>
map <leader>ev :vsp <C-R>=expand("%:p:h") . "/" <CR>
map <leader>et :tabe <C-R>=expand("%:p:h") . "/" <CR>

" Cscope stuff.
:set cscopequickfix=g-,s-,c-,d-,i-,t-,e-

" Java stuff.
" if has("autocmd")
"   autocmd Filetype java setlocal omnifunc=javacomplete#Complete
"   autocmd BufRead *.java set makeprg=vimant
"   autocmd BufRead *.java set efm=\ %#[javac]\ %#%f:%l:%c:%*\\d:%*\\d:\ %t%[%^:]%#:%m,
"            \%A\ %#[javac]\ %f:%l:\ %m,%-Z\ %#[javac]\ %p^,%-C%.%#
" endif
" setlocal completefunc=javacomplete#CompleteParamsInfo
:set completeopt-=preview

" Open the quickfix window after a Make.
autocmd QuickFixCmdPost [^l]* nested cwindow
autocmd QuickFixCmdPost    l* nested lwindow

" Settings for plugins.

" CtrlP stuff
set wildignore+=*.o,*.obj,.git,.svn,*.pyc,*.pyo,*.png,*.jpg,build,venv
let g:ctrlp_working_path_mode = 'ra'
let g:ctrlp_extensions = ['tag', 'buffertag', 'quickfix', 'dir', 'rtscript',
                      \ 'undo', 'line', 'changes', 'mixed', 'bookmarkdir']

" Taglist stuff
let Tlist_Ctags_Cmd = "/usr/local/bin/ctags"
let Tlist_WinWidth = 50
let Tlist_GainFocus_On_ToggleOpen = 1
let Tlist_Close_On_Select = 1
let Tlist_Use_Right_Window = 1
let Tlist_File_Fold_Auto_Close = 1

" vcscommand stuff
let VCSCommandMapPrefix = "<leader>C"

" Syntastic stuff.
let g:syntastic_javascript_checker = "jshint"
let g:syntastic_javascript_jsl_conf = "-conf /Users/jgarbers/.jsl"
" let g:syntastic_javascript_jshint_conf = "-conf /Users/jgarbers/.jshint"

" JavaScript indenter stuff.
let g:SimpleJsIndenter_BriefMode = 1

" NERDTree stuff.
let NERDTreeMapOpenVSplit="<C-v>"
let NERDTreeMapOpenSplit="<C-s>"
let NERDTreeIgnore = ['\.pyc$']
let NERDTreeHijackNetrw=1

" For Python autocomplete.
" let g:pydiction_location = '/Users/jgarbers/.vim/bundle/pydiction-1.2/complete-dict'

" Some utility functions.

" toggle colored right border
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


" Stuff borrowed from Bram's example vimrc. 
"

" Don't use Ex mode, use Q for formatting
map Q gq

" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>

" Put these in an autocmd group, so that we can delete them easily.
augroup vimrcEx
au!

" For all text files set 'textwidth' to 78 characters.
autocmd FileType text setlocal textwidth=78

" JavaScript files get 2-character "tabs".
autocmd FileType javascript setlocal shiftwidth=2 tabstop=2

" HTML and Handlebars files get 2-character "tabs"
autocmd FileType html setlocal shiftwidth=2 tabstop=2
autocmd FileType handlebars setlocal shiftwidth=2 tabstop=2

" Arduino stuff
au BufRead,BufNewFile *.pde set filetype=arduino
au BufRead,BufNewFile *.ino set filetype=arduino

" For cosa builds. Comment these out to default back to ino.
" let g:vim_arduino_build_command = "cosa uno"
" let g:vim_arduino_deploy_command = "cosa uno && cosa uno upload"


" When editing a file, always jump to the last known cursor position.
" Don't do it when the position is invalid or when inside an event handler
" (happens when dropping a file on gvim).
" Also don't do it when the mark is in the first line, that is the default
" position when opening a file.
autocmd BufReadPost *
\ if line("'\"") > 1 && line("'\"") <= line("$") |
\   exe "normal! g`\"" |
\ endif

augroup END

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis
		  \ | wincmd p | diffthis
endif
