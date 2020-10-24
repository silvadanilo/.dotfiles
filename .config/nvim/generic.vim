" Leader
let mapleader = ","
let maplocalleader = "\\"

" General Config =============================================================
set timeoutlen=400
set autoread
set backspace=indent,eol,start
set cursorline
set encoding=utf-8
set hidden
set history=1000
set laststatus=2
set lazyredraw
set modelines=0
set number
set numberwidth=5
set showcmd
set showmatch
set showmode
set splitbelow
set splitright
set title
set ttyfast
set visualbell
set clipboard=unnamed
set colorcolumn=80,120

" Search Settings ============================================================
set incsearch
set hlsearch
set ignorecase
set smartcase

" Persistent undo and backups ================================================
if has('persistent_undo')
    set undodir=~/.vim/tmp/undo
    set undoreload=10000
    set undofile
endif

set backupdir=~/.vim/backup
set directory=~/.vim/swap
set backup

" Indentation ================================================================
set autoindent
set smartindent
set smarttab
set shiftwidth=4
set softtabstop=4
set tabstop=4
set expandtab
set shiftround

filetype plugin on
filetype indent on

set list listchars=tab:»·,trail:·
set showbreak=↪

" Completion =================================================================
set wildmode=list:longest
set wildmenu

" cycle through completion entries with tab/shift+tab
inoremap <expr> <TAB> pumvisible() ? "\<c-n>" : "\<Tab>"
inoremap <expr> <s-tab> pumvisible() ? "\<c-p>" : "\<S-Tab>"
inoremap <expr> <cr> pumvisible() ? "\<c-y>" : "\<cr>"

" Scrolling ==================================================================
set scrolloff=3
set sidescrolloff=15
set sidescroll=1

" Convenience mappings =======================================================
set complete+=k

" Make Y behave
nnoremap Y y$

" It's 2015.
" noremap j gj
" noremap k gk

" Easy buffer close
" nnoremap Q :lclose<CR>:cclose<CR>:bd<CR>
nnoremap Q :bd<CR>

" Easy paragraph formatting
nnoremap <leader>Q gqip

" Easy tab navigation
map <S-H> gT
map <S-L> gt
nnoremap <silent> <C-LEFT> :execute 'silent! tabmove ' . (tabpagenr()-2)<CR>
nnoremap <silent> <C-RIGHT> :execute 'silent! tabmove ' . (tabpagenr()+1)<CR>

" Clear search highlighting
map <C-l> :nohlsearch<CR>

" Fuck you, help key
noremap  <F1> <NOP>
inoremap <F1> <NOP>

" Close QuickFix window
map <silent> <leader>q :lclose<CR>:cclose<CR>

" Paste toggle
map <silent> <leader>p :set paste!<CR>

" Wrapping
map <silent> <leader>w :set wrap!<CR>

" Recover from accidental Ctrl-U/Ctrl-W
inoremap <C-U> <C-G>u<C-U>
inoremap <C-W> <C-G>u<C-W>

" Save file with ctrl+k
:nnoremap <C-k> :w<CR>
:inoremap <C-k> <Esc>:w<CR>
:vnoremap <C-k> <Esc>:w<CR>

" set limit of openable tab to 50
set tabpagemax=50

" Reload file
map <F5> :e<CR>

" Copy filename in clipboard
nmap ,cs :let @+=expand("%")<CR>

" Copy filepath in clipboard
nmap ,cl :let @+=expand("%:p")<CR>

" Disble highlight of cursor line
" set nocursorline

" siwtch to alternate file
map <C-\> <C-^>

" substitute selected text
vnoremap <C-r> "hy:%s/<C-r>h//gc<left><left><left>

" shortcut to copy on the system clipboard
noremap <Leader>y "+y

" shortcut to create directory of the current file
nnoremap <Leader>k :call mkdir(expand("%:p:h"), "p")<CR>

" Close buffer
noremap <silent> <leader>c :bd<CR>

" remove hypen from iskeyword
set iskeyword-=-

" Map F2 to the list of buffers plus switch tu a number
map <F2> :ls<CR>:b<Space>

" Open current line on GitHub
noremap <Leader>g :!echo `git url`/blob/`git rev-parse --abbrev-ref HEAD`/%\#L<C-R>=line('.')<CR> \| xargs xdg-open<CR><CR>

" with the following map in normal mode <Leader>a will replace array(...) with [...]
nnoremap <silent> <Leader>A /\<array\>\s*(<CR>:nohl<CR>dwmp%r]`pr[

" transform a json object into a php array
noremap <silent> <Leader>J /{\_[^}{]*}<CR>mo%mpv`o:s/"\s*:\s*"/" => "/g<CR>`o%mpr]`or[`ov`p:s/",[^\n$]/",\r/g<CR>mp`o:s/"/\r"/<CR>`ov`p=:nohl<CR>

" transform snake case var into camel case
nnoremap _ f_x~

" Sort a paragraph
function! s:SortLinesOpFunc(...)
    '[,']sort
endfunction,
nnoremap <silent> <leader>z :<C-u>set operatorfunc=<SID>SortLinesOpFunc<CR>g@

" quickfix always at full width
" au FileType qf resize 5<Bar>wincmd J

" skip quickfix windows when cycling through splits
:nnoremap <silent> <C-w><C-w> <C-w><C-w>:while &buftype ==# 'quickfix'<Bar>wincmd w<Bar>endwhile<CR>

" comment like phpstorm
if !hasmapto('<Plug>Commentary') || maparg('gc','n') ==# ''
  nmap <C-_> <Plug>CommentaryLine
  xmap <C-_>  <Plug>Commentary
endif

" reindent the entire file
map <F7> gg=G<C-o>
""""""" END PERSONAL CONFIGURATION

let s:grep_default_exe="/usr/bin/rg"
