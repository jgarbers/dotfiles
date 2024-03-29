" My working vimrc
" 
" Trying to reduce overhead and increase speed, I'm dropping as many plugins
" and options as possible, and building back up with must-haves.
"
" Using tpope/vim-sensible as a base for typical options.
"
" Also using Neovim native plugin support rather than a manager:
"
" 	tpope/vim-sensible: sensible defaults
"
" 	vim-syntastic/syntastic: multilanguage syntax checking
" 	junegunn/fzf.vim: FZF-based fuzzy finder
"   tpope/vim-vinegar: netrw enhancement
" 	tpope/vim-commentary : commenting/uncommenting code blocks
"   preservim/tagbar: ctags display
" 	ronakg/quickr-cscope: cscope bindings and quickfix management
" 	sirver/ultisnips: snippet manager
" 	dbakker/vim-projectroot: easy access to project root directory
" 	editorconfig/editorconfig-vim: support EditorConfig protocol
"   justinmk/vim-sneak: rapid motion
"
" On probation:
" 	tpope/vim-unimpaired : pairwise motions, etc.
"

" Appearance.

" Highlight overrides
function! MyHighlights() abort
    highlight Comment cterm=italic
    highlight MatchParen cterm=bold ctermbg=none ctermfg=magenta
    highlight link markdownItalic Normal
endfunction

augroup MyColors
    autocmd!
    autocmd ColorScheme * call MyHighlights()
augroup END

colorscheme solarized
set listchars=tab:▸\ ,eol:¬,trail:·

"" Tabstops
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab
set smarttab
set ignorecase
set smartcase

" Helpful things on screen.
set relativenumber
set nowrap

" Persistent undo
set undofile
set undodir=~/.vim/undodir
set undolevels=1000
set undoreload=10000

" Enable mouse.
set mouse=a

" Allow hidden buffers.
set hidden

set statusline=%y\ %F\ %h%w%m%r\ %=%(%l,%c%V\ %=\ %P%)

" ######################################################################## 
"  Key mappings.
" ######################################################################## 

" Window navigation with ctrl keys
nmap <C-j> <C-w>j
nmap <C-h> <C-w>h
nmap <C-k> <C-w>k
nmap <C-l> <C-w>l

" Buffer nav with tab/shift-tab
nnoremap <Tab> :bprev<CR>
nnoremap <S-Tab> :bnext<CR>

" Open netrw in project root.
nnoremap <expr> _ ':edit '.projectroot#guess().'/<CR>'
nnoremap <expr> <F2> ':20Lexplore '.projectroot#guess().'/<CR>'

" Write file
nnoremap <leader>w :w<CR>

" Close buffer, leaving window
nnoremap <leader>c :bp\|bd #<CR>

" Clear search term highlight
nnoremap <leader><space> :noh<CR>

" Toggle netrw left explorer
nnoremap <leader>f :20Lexplore<CR>

" Freed <C-l> in Netrw
nmap <leader>l <Plug>NetrwRefresh

" Load notes
nnoremap <leader>n :ProjectRootExe edit docs/notes.md<CR>:set wfh<CR>'.

" Load notes and split
nnoremap <leader>N :ProjectRootExe edit docs/notes.md<CR>'.:set wfh<CR><C-W>s<C-W>20+:ProjectRootExe edit .<CR><C-W>j

" Toggle right tagbar
nnoremap <leader>t :TagbarToggle<CR>

" Toggle Syntastic check
nnoremap <leader>S :SyntasticToggleMode<CR>

" Toggle quickfix
nnoremap <leader>q :call ToggleQuickFix()<CR>

" Update copyright
nnoremap <leader>C :call UpdateCopyright()<CR>

" Black reformat
nnoremap <leader>B :call black#Black()<CR>

" Open twf
nnoremap <leader>e :call Twf()<CR>

" fzf mappings and options
nnoremap <C-P> :ProjectRootExe Files<CR>
nnoremap <leader>a :Ag 
nnoremap <leader>b :Buffers<CR>
nnoremap <leader>A :Ag <C-R><C-W><CR>

function! s:build_quickfix_list(lines)
    call setqflist(map(copy(a:lines), '{ "filename": v:val }'))
    copen
    cc
endfunction

 let g:fzf_action = {
   \ 'ctrl-t': 'tab split',
   \ 'ctrl-x': 'split',
   \ 'ctrl-v': 'vsplit' }

let $FZF_DEFAULT_OPTS = '--bind ctrl-l:select-all'

" quickr_cscope mappings; we use a subset
let g:quickr_cscope_keymaps = 0
nmap <leader>s <plug>(quickr_cscope_symbols)

" ######################################################################## 
"  Snippet-related
" ######################################################################## 
let g:ultisnips_python_style="sphinx"

" ######################################################################## 
"  Abbreviations
" ######################################################################## 

iab <expr> ddln strftime("------------------------------------------------------------------------<CR>%Y-%m-%d")
iab <expr> ddt strftime("%A %b %d, %Y %T %Z")
iab ddp print(f"*** HEY")<C-o>F"
iab <expr> gtc strftime("# Copyright (c) %Y Georgia Tech Research Corporation. All rights reserved.")
"
" ######################################################################## 
"  Special handling for selected file types.
" ######################################################################## 

" Always use sphinx for .rst files
" au BufRead,BufNewFile *.rst set filetype=sphinx

" ######################################################################## 
"  Plugin and environment options
" ######################################################################## 

" ------------------------------------------------------------------------ 
" cscope and quickr-cscope

set cscopetag
set csto=0
set cscopequickfix=s-,c-,d-,i-,t-,e-

if filereadable("cscope.out")
    silent cs add cscope.out  
    elseif $CSCOPE_DB != ""
        silent cs add $CSCOPE_DB
    endif

let g:quickr_cscope_keymaps = 0


" ------------------------------------------------------------------------ 
"  netrw 

autocmd FileType netrw setl bufhidden=delete
autocmd FileType netrw nnoremap ? :help netrw-quickmap<CR>
let g:netrw_keepdir=0
let g:netrw_altv=1
let g:netrw_winsize = 80

" ------------------------------------------------------------------------ 
"  Syntastic

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_javascript_checkers = ['eslint']
let g:syntastic_python_checkers = ['flake8']
let g:syntastic_rst_checkers=['sphinx']
let g:syntastic_sh_shellcheck_args="-x -P SCRIPTDIR"

let g:syntastic_html_tidy_ignore_errors = [
  \'proprietary attribute "required',
  \'proprietary attribute "autofocus',
\]

let g:syntastic_mode_map = {
    \ "mode": "active",
    \ "passive_filetypes": ["jinja", "rst"] }


" ------------------------------------------------------------------------ 
"  Polyglot

" Disable polyglot for Markdown, as I use it more for note-taking
" that doesn't really follow Markdown rules.
let g:polyglot_disabled = ['markdown']

" ------------------------------------------------------------------------ 
" Jedi
let g:jedi#completions_command = "<C-N>"

" ######################################################################## 
"  Language specific options
" ######################################################################## 

autocmd FileType javascript setlocal shiftwidth=2 tabstop=2 softtabstop=2
autocmd FileType java setlocal shiftwidth=2 tabstop=2 softtabstop=2
autocmd FileType json setlocal shiftwidth=2 tabstop=2 softtabstop=2
autocmd FileType html setlocal shiftwidth=2 tabstop=2 softtabstop=2
autocmd FileType htmldjango setlocal shiftwidth=2 tabstop=2 softtabstop=2
autocmd FileType jinja.html setlocal shiftwidth=2 tabstop=2 softtabstop=2
autocmd FileType yaml setlocal shiftwidth=2 tabstop=2 softtabstop=2

" ######################################################################## 
"  Custom functions
" ######################################################################## 

" For twf
function! TwfExit(path)
  function! TwfExitClosure(job_id, data, event) closure
    bd!
    try
      let out = filereadable(a:path) ? readfile(a:path) : []
    finally
      silent! call delete(a:path)
    endtry
    if !empty(out)
      execute 'edit! ' . out[0]
    endif
  endfunction
  return funcref('TwfExitClosure')
endfunction

function! Twf()
  let temp = tempname()
  call termopen('twf ' . @% . ' > ' . temp, { 'on_exit': TwfExit(temp) })
  startinsert
endfunction

" Toggle quick fix window.
function! ToggleQuickFix()
    if empty(filter(getwininfo(), 'v:val.quickfix'))
        copen
    else
        cclose
    endif
endfunction

" Update copyright
function! UpdateCopyright()
    exe "g#\\cCopyright \(c\) \\(".strftime("%Y")."\\)\\@![0-9]\\{4\\}\\(-".strftime("%Y")."\\)\\@!#s#\\([0-9]\\{4\\}\\)\\(-[0-9]\\{4\\}\\)\\?#\\1-".strftime("%Y") |
endfunction

