set nocompatible

" Plugins ====================================================================

call plug#begin('~/.vim/bundle')

" Local plugins
if filereadable(expand('~/.vimrc.plugins'))
    source ~/.vimrc.plugins
endif

" Local plugins
if filereadable(expand('~/.vimrc.plugins.local'))
    source ~/.vimrc.plugins.local
endif

call plug#end()

" Leader
let mapleader = ","
let maplocalleader = "\\"

" General Config =============================================================
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
set colorcolumn=80

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

set backupdir=~/.vim/tmp/backup
set directory=~/.vim/tmp/swap
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

" Easy paragraph formatting
nnoremap Q gqip

" Easy tab navigation
map <S-H> gT
map <S-L> gt

" Clear search highlighting
map <C-l> :nohlsearch<CR>

" Fuck you, help key
noremap  <F1> <NOP>
inoremap <F1> <NOP>

" Close QuickFix window
map <silent> <leader>q :cclose<CR>

" Paste toggle
map <silent> <leader>p :set paste!<CR>

" Wrapping
map <silent> <leader>w :set wrap!<CR>

" Recover from accidental Ctrl-U/Ctrl-W
inoremap <C-U> <C-G>u<C-U>
inoremap <C-W> <C-G>u<C-W>

" Autocommands ===============================================================

if has('autocmd')

  set omnifunc=syntaxcomplete#Complete

  augroup vimrcEx
  au!

  " Remove any trailing whitespace that is in the file
  autocmd BufWrite * if ! &bin | :call setline(1,map(getline(1,"$"),'substitute(v:val,"\\s\\+$","","")')) | endif

  " Filetype-specific settings
  autocmd Filetype ruby set tabstop=2 shiftwidth=2 softtabstop=2
  autocmd Filetype haskell set tabstop=2 shiftwidth=2 softtabstop=2
  autocmd BufRead *.html,*.htm set tabstop=2 shiftwidth=2 softtabstop=2 nowrap
  autocmd BufRead *.txt set tabstop=2 shiftwidth=2 softtabstop=2
  autocmd BufRead *.php set tabstop=4 shiftwidth=4 softtabstop=4
  autocmd BufRead *.php set dictionary=~/.vim/bundle/vim-php-dictionary/dict/PHP.dict

  augroup END

endif " has('autocmd')

" Colors
" =====================================================================
"
syntax on
set background=dark
set t_Co=256
if filereadable(expand("~/.vim/bundle/vim-colors-solarized/colors/solarized.vim"))
    let g:solarized_termcolors=256
    colorscheme solarized
endif

" Term color
set term=screen-256color

function! s:CloseHiddenBuffers()
  " figure out which buffers are visible in any tab
  let visible = {}
  for t in range(1, tabpagenr('$'))
    for b in tabpagebuflist(t)
      let visible[b] = 1
    endfor
  endfor
  " close any buffer that's loaded and not visible
  for b in range(1, bufnr('$'))
    if bufloaded(b) && !has_key(visible, b)
      exe 'bd ' . b
    endif
  endfor
endfun
command! CloseHiddenBuffers call s:CloseHiddenBuffers()

" Show tab number
if exists("+showtabline")
    function! MyTabLine()
        let s = ''
        let t = tabpagenr()
        let i = 1
        while i <= tabpagenr('$')
            let buflist = tabpagebuflist(i)
            let winnr = tabpagewinnr(i)
            let s .= '%' . i . 'T'
            let s .= (i == t ? '%1*' : '%2*')
            let s .= ' '
            let s .= i . ')'
            let s .= ' %*'
            let s .= (i == t ? '%#TabLineSel#' : '%#TabLine#')
            let file = bufname(buflist[winnr - 1])
            let file = fnamemodify(file, ':p:t')
            if file == ''
                let file = '[No Name]'
            endif
            let s .= file
            let i = i + 1
        endwhile
        let s .= '%T%#TabLineFill#%='
        let s .= (tabpagenr('$') > 1 ? '%999XX' : 'X')
        return s
    endfunction
    set stal=2
    set tabline=%!MyTabLine()
endif

" set limit of openable tab to 50
set tabpagemax=50

" Reload file
map <F5> :e<CR>

" Save file
map <A-s> :w<CR>
map <A-k> :w<CR>

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

" Save with ctrl+k
:nnoremap <C-k> :w<CR>
:inoremap <C-k> <Esc>:w<CR>
:vnoremap <C-k> <Esc>:w<CR>

" shortcut to copy on the system clipboard
noremap <Leader>y "+y

" shortcut to create directory of the current file
nnoremap <Leader>k :call mkdir(expand("%:p:h"), "p")<CR>

" Close buffer
noremap <silent> <leader>c :bd<CR>

" remove hypen from iskeyword
set iskeyword-=-

" Open current line on GitHub
noremap ,o :!echo `git url`/blob/`git rev-parse --abbrev-ref HEAD`/%\#L<C-R>=line('.')<CR> \| xargs xdg-open<CR><CR>

" vim-php-namespace
inoremap <Leader>q <C-O>:call PhpExpandClass()<CR>
noremap <Leader>q :call PhpExpandClass()<CR>
autocmd FileType php inoremap <Leader>s <Esc>:call PhpSortUse()<CR>
autocmd FileType php noremap <Leader>s :call PhpSortUse()<CR>
let g:php_namespace_sort_after_insert = 1
" function! IPhpInsertUse()
"     call PhpInsertUse()
"     call feedkeys('a',  'n')
" endfunction
" autocmd FileType php inoremap <Leader>u <Esc>:call IPhpInsertUse()<CR>
" autocmd FileType php noremap <Leader>u :call PhpInsertUse()<CR>

" phpactor
" Include use statement
nmap <Leader>u :call phpactor#UseAdd()<CR>

" Invoke the context menu
nmap <Leader>mm :call phpactor#ContextMenu()<CR>

" Goto definition of class or class member under the cursor
nmap <Leader>o :call phpactor#GotoDefinition()<CR>

" Transform the classes in the current file
nmap <Leader>tt :call phpactor#Transform()<CR>

" Generate a new class (replacing the current file)
nmap <Leader>cc :call phpactor#ClassNew()<CR>

" Extract method from selection
nnoremap <silent><Leader>nn :<C-U>call phpactor#Navigate()<CR>

" Extract method from selection
vmap <silent><Leader>em :<C-U>call phpactor#ExtractMethod()<CR>


" with the following map in normal mode <Leader>a will replace array(...) with [...]
nnoremap <silent> <Leader>A /\<array\>\s*(<CR>:nohl<CR>dwmp%r]`pr[

" transform a json object into a php array
noremap <silent> <Leader>J /{\_[^}{]*}<CR>mo%mpv`o:s/"\s*:\s*"/" => "/g<CR>`o%mpr]`or[`ov`p:s/",[^\n$]/",\r/g<CR>mp`o:s/"/\r"/<CR>`ov`p=:nohl<CR>

" rewrap arguments of a function
noremap <silent> <Leader>n :call argumentrewrap#RewrapArguments()<CR>

" grep.vim
nnoremap <silent> <leader>f :Rgrep<CR>
let Grep_Default_Options = '-IR'

" session management
nnoremap <leader>so :OpenSession
nnoremap <leader>ss :SaveSession
nnoremap <leader>sd :DeleteSession<CR>
nnoremap <leader>sc :CloseSession<CR>
let g:session_autosave=0
let g:session_autosave_periodic=1
let g:session_autosave_silent=1
let g:session_directory='./.vimsessions'
let g:session_autoload =1
let g:session_default_to_last=1

" Map F2 to the list of buffers plus switch tu a number
map <F2> :ls<CR>:b<Space>

" Map ,F to copy the relative filepath on the clipboard
noremap <leader>F :let @+ = expand("%")<CR>

function! CurrentNamespace()
    let path = split(expand("%:p"), "/")
    let pathInverted = copy(path)
    call reverse(pathInverted)
    let rootFolder = -1
    for folder in pathInverted
        let firstCharacter = strpart(folder, 0, 1)
        if (firstCharacter ==# toupper(firstCharacter))
            let rootFolder = rootFolder - 1
        else
            break
        endif
    endfor
    let namespace = join(path[rootFolder+1:-2], "\\")
    return namespace
endfunction

" Plugin settings ============================================================

" Matchit.vim
runtime macros/matchit.vim

" NERD Tree
map <C-e> :NERDTreeToggle<CR>
nnoremap <silent> <Leader>e :NERDTreeFind<CR>

let NERDTreeHighlightCursorline=1
let NERDTreeMinimalUI = 1
let NERDTreeDirArrows = 1
let NERDTreeChDirMode = 2
let g:NERDTreeWinSize = 40
let NERDTreeQuitOnOpen = 1

" Supertab
let g:SuperTabLongestHighlight = 1

" Ack
map <leader>a :Ack!<space>

" CtrlP
let g:ctrlp_working_path_mode = 0
let g:ctrlp_extensions = ['tag']
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\/coverage$',
  \ }

map <C-t> :CtrlPTag<CR>
map <C-b> :CtrlPBuffer<CR>


" Signify
let g:signify_vcs_list = ['git']

" Airline
" if !exists('g:airline_symbols')
"   let g:airline_symbols = {}
" endif
"
" let g:airline_left_sep=''
" let g:airline_right_sep=''
" let g:airline_left_alt_sep='❯'
" let g:airline_right_alt_sep='❮'
" let g:airline_symbols.branch = '⚡'
" let g:airline_theme='kolor'
" let g:airline_powerline_fonts = 1
" let g:airline_left_sep='▶'
" let g:airline_right_sep='◀'
" let g:airline_left_alt_sep='❯'
" let g:airline_right_alt_sep='❮'
" let g:airline_symbols.branch = '⚡'

" Lightline
let g:lightline = {
      \ 'colorscheme': 'powerline',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'gitbranch', 'readonly', 'filename', 'modified', 'cwd'] ]
      \ },
      \ 'component_function': {
      \   'gitbranch': 'fugitive#head',
      \   'cwd': 'CwdForLightline'
      \ },
      \ }

function! CwdForLightline()
    return expand('%:p:h')
endfunction

" TagBar
nnoremap <silent> <leader>@ :TagbarToggle<CR>

" If using go please install the gotags program using the following
" go install github.com/jstemmer/gotags
" And make sure gotags is in your path
let g:tagbar_type_go = {
            \ 'ctagstype' : 'go',
            \ 'kinds' : [ 'p:package', 'i:imports:1', 'c:constants', 'v:variables',
            \ 't:types', 'n:interfaces', 'w:fields', 'e:embedded', 'm:methods',
            \ 'r:constructor', 'f:functions' ],
            \ 'sro' : '.',
            \ 'kind2scope' : { 't' : 'ctype', 'n' : 'ntype' },
            \ 'scope2kind' : { 'ctype' : 't', 'ntype' : 'n' },
            \ 'ctagsbin' : 'gotags',
            \ 'ctagsargs' : '-sort -silent'
            \ }
"}


set nofoldenable                " disable code folding
let g:DisableAutoPHPFolding = 1 " disable PIV's folding

" let g:syntastic_php_checkers=['php', 'phpcs', 'phpmd']
let g:syntastic_php_checkers=['php', 'phpmd']
let g:syntastic_auto_loc_list=1
set colorcolumn=80,120
set nospell

" neosnippet
let g:neosnippet#enable_snipmate_compatibility = 1
let g:neosnippet#snippets_directory='~/.vim/bundle/mysnippets/snippets'
imap <C-j>     <Plug>(neosnippet_expand_or_jump)
nmap <C-j>     i<Plug>(neosnippet_expand_or_jump)

inoremap <expr><\CR> pumvisible() ? "\<c-y>\<cr>" : "\<CR>"
autocmd FileType php setlocal omnifunc=phpactor#Complete

"Gutentag
let g:gutentags_cache_dir = '~/.vim/gutentags'
let g:gutentags_ctags_exclude = [".git", ".work", '*.css', '*.html', '*.js', '*.json', '*.xml',
                            \ '*.phar', '*.ini', '*.rst', '*.md',
                            \ '*vendor/*/test*', '*vendor/*/Test*',
                            \ '*vendor/*/fixture*', '*vendor/*/Fixture*',
                            \ '*var/cache*', '*var/log*']


" Sort a paragraph
function! s:SortLinesOpFunc(...)
    '[,']sort
endfunction,
nnoremap <silent> <leader>z :<C-u>set operatorfunc=<SID>SortLinesOpFunc<CR>g@

" Pdv (php doc generator)
nnoremap <silent> <leader>d mg :call PhpDocSingle()<CR>`g

" Local vimrc ================================================================
if filereadable(expand('~/.vimrc.local'))
    source ~/.vimrc.local
endif

" Drop Vdebug settings at the end of the file "
let g:vdebug_options = {
\ 'break_on_open': 1,
\ 'path_maps': {'/var/www': '/home/danilo/sviluppo/heaven-provisioning/projects'},
\ 'port': '9000',
\ 'watch_window_style': 'compact'
\ }
