set nocompatible

" Plugins ====================================================================
if empty(glob('~/.config/nvim/autoload/plug.vim'))
    silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
                \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd!
    autocmd VimEnter * PlugInstall
endif

call plug#begin('~/.config/nvim/plugged')

if filereadable(expand('~/.config/nvim/plugin.vim'))
    source ~/.config/nvim/plugin.vim
endif

call plug#end()

""""""" START PERSONAL CONFIGURATION
if filereadable(expand('~/.config/nvim/custom-functions.vim'))
    source ~/.config/nvim/custom-functions.vim
endif


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
if !has('nvim')
set term=screen-256color
endif

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
""""""" END PERSONAL CONFIGURATION

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
  autocmd FileType php setlocal omnifunc=phpactor#Complete
  " autocmd BufRead *.php set dictionary=~/.vim/bundle/vim-php-dictionary/dict/PHP.dict

  augroup END

endif " has('autocmd')

""" UtilSnip
set runtimepath+=~/.config/nvim/plugged/mysnippets
let g:UltiSnipsExpandTrigger="<c-j>"
let g:UltiSnipsJumpForwardTrigger="<c-j>"
let g:UltiSnipsJumpBackwardTrigger="<c-b>"
let g:UltiSnipsSnippetDirectories=["UltiSnips", "mysnippets"]
let g:ultisnips_php_scalar_types = 1 " PHP7

""" NCM2
augroup ncm2
  au!
  autocmd BufEnter * call ncm2#enable_for_buffer()
  au User Ncm2PopupOpen set completeopt=noinsert,menuone,noselect
  au User Ncm2PopupClose set completeopt=menuone
augroup END

" parameter expansion for selected entry via Enter
inoremap <silent> <expr> <CR> (pumvisible() ? ncm2_ultisnips#expand_or("\<CR>", 'n') : "\<CR>")

" cycle through completion entries with tab/shift+tab
inoremap <expr> <TAB> pumvisible() ? "\<c-n>" : "\<TAB>"
inoremap <expr> <s-tab> pumvisible() ? "\<c-p>" : "\<TAB>"

"""ALE
" disable linting while typing
let g:ale_lint_on_text_changed = 'never'
let g:ale_lint_on_enter = 0
let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'
let g:ale_open_list = 1
let g:ale_keep_list_window_open=0
let g:ale_set_quickfix=1
let g:ale_list_window_size = 5
let g:ale_php_phpcbf_standard='PSR2'
let g:ale_php_phpcs_standard='phpcs.xml.dist'
" let g:ale_php_phpmd_ruleset='phpmd.xml'
let g:ale_php_phpmd_ruleset='cleancode,codesize,controversial,design,unusedcode'
let g:ale_fixers = {
  \ '*': ['remove_trailing_lines', 'trim_whitespace'],
  \ 'php': ['phpcbf', 'php_cs_fixer', 'remove_trailing_lines', 'trim_whitespace'],
  \}
let g:ale_fix_on_save = 1

augroup CloseLoclistWindowGroup
    autocmd!
    autocmd QuitPre * if empty(&buftype) | lclose | endif
augroup END

augroup CloseQuickfixWindowGroup
    autocmd!
    autocmd QuitPre * if empty(&buftype) | cclose | endif
augroup END

""" PHPACTOR
let g:phpactor_executable = '~/.config/nvim/plugged/phpactor/bin/phpactor'

" Include use statement
nmap <Leader>u :call phpactor#UseAdd()<CR>

" Invoke the context menu
nmap <Leader>mm :call phpactor#ContextMenu()<CR>
nnoremap <m-m> :call phpactor#ContextMenu()<cr>

" Invoke the navigation menu
nmap <Leader>nn :call phpactor#Navigate()<CR>

" Goto definition of class or class member under the cursor
nmap <Leader>o :call phpactor#GotoDefinition()<CR>
nnoremap gd :call phpactor#GotoDefinition()<CR>
nnoremap gr :call phpactor#FindReferences()<CR>

" Show brief information about the symbol under the cursor
nmap <Leader>K :call phpactor#Hover()<CR>

" Transform the classes in the current file
nmap <Leader>tt :call phpactor#Transform()<CR>

" Generate a new class (replacing the current file)
nmap <Leader>cc :call phpactor#ClassNew()<CR>

" extract interface
nnoremap <silent><Leader>rei :call phpactor#ClassInflect()<CR>

" Extract expression (normal mode)
nmap <silent><Leader>ee :call phpactor#ExtractExpression(v:false)<CR>

" Extract expression from selection
vmap <silent><Leader>ee :<C-U>call phpactor#ExtractExpression(v:true)<CR>

" Extract method from selection
vmap <silent><Leader>em :<C-U>call phpactor#ExtractMethod()<CR>

nnoremap <leader>ric :call PHPModify("implement_contracts")<cr>

nnoremap <leader>raa :call PHPModify("add_missing_properties")<cr>

function! PHPModify(transformer)
    :update
    let l:cmd = "silent !".g:phpactor_executable." class:transform ".expand('%').' --transform='.a:transformer
    execute l:cmd
endfunction

nnoremap <leader>rcc :call PhpConstructorArgumentMagic()<cr>
function! PhpConstructorArgumentMagic()
    " update phpdoc
    if exists("*UpdatePhpDocIfExists")
        normal! gg
        /__construct
        normal! n
        :call UpdatePhpDocIfExists()
        :w
    endif
    :call PHPModify("complete_constructor")
endfunction

nnoremap <leader>rmc :call PHPMoveClass()<cr>
function! PHPMoveClass()
    :w
    let l:oldPath = expand('%')
    let l:newPath = input("New path: ", l:oldPath)
    execute "!".g:phpactor_executable." class:move ".l:oldPath.' '.l:newPath
    execute "bd ".l:oldPath
    execute "e ". l:newPath
endfunction

""" php-doc-modded
nnoremap <silent> <leader>d mg :call PhpDocSingle()<CR>`g
nnoremap <silent> <leader>h mg :call UpdatePhpDocIfExists()<CR>`g
function! UpdatePhpDocIfExists()
    normal! k
    if getline('.') =~ '/'
        normal! V%d
    else
        normal! j
    endif
    call PhpDocSingle()
    normal! k^%k$
    if getline('.') =~ ';'
        exe "normal! $svoid"
    endif
endfunction

" """ php-cs-fixer
" command! -nargs=1 Silent execute ':silent !'.<q-args> | execute ':redraw!'
" map <c-s> <esc>:w<cr>:Silent php-cs-fixer fix %:p --level=symfony<cr>
" let g:php_cs_fixer_path = "/usr/local/bin/php-cs-fixer.phar" " define the path to the php-cs-fixer.phar
" let g:php_cs_fixer_enable_default_mapping = 1     " Enable the mapping by default (<leader>pcd)
" let g:php_cs_fixer_dry_run = 1                    " Call command with dry-run option
" let g:php_cs_fixer_verbose = 1                    " Return the output of command if 1, else an inline information.

""" NERD Tree
map <C-e> :NERDTreeToggle<CR>
nnoremap <silent> <Leader>e :NERDTreeFind<CR>
let NERDTreeHighlightCursorline=1
let NERDTreeMinimalUI = 1
let NERDTreeDirArrows = 1
let NERDTreeChDirMode = 2
let g:NERDTreeWinSize = 40
let NERDTreeQuitOnOpen = 1

""" CtrlP
let g:ctrlp_working_path_mode = 0
let g:ctrlp_extensions = ['tag']
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\/coverage$',
  \ }

map <C-t> :CtrlPTag<CR>
map <C-b> :CtrlPBuffer<CR>
map <C-A-m> :CtrlPMRUFiles<CR>

if executable('rg')
  let g:ctrlp_user_command = 'rg --files %s'
  let g:ctrlp_use_caching = 0
  let g:ctrlp_working_path_mode = 'ra'
  let g:ctrlp_switch_buffer = 'et'
endif

""" TagBar
nnoremap <silent> <leader>@ :TagbarOpenAutoClose<CR>
nnoremap <silent> <leader><leader>@ :TagbarToggle<CR>
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


""" vim-php-namespace
inoremap <Leader>ec <C-O>:call PhpExpandClass()<CR>
noremap <Leader>ec :call PhpExpandClass()<CR>
autocmd FileType php inoremap <Leader>su <Esc>:call PhpSortUse()<CR>
autocmd FileType php noremap <Leader>su :call PhpSortUse()<CR>
let g:php_namespace_sort_after_insert = 1

""" grep.vim
nnoremap <silent> <leader>f :Rgrep<CR>
let Grep_Default_Options = '-IR'

""" Ack
map <leader>aa :Ack!<space>
map <leader>a :Ack! <cword><cr>
nnoremap <silent> <Leader>r :Rg <C-R><C-W><CR>
" if executable('rg')
"     let g:ackprg = 'rg -S --no-heading --vimgrep'
" endif

""" session management
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

""" Matchit.vim
runtime macros/matchit.vim

""" Signify
let g:signify_vcs_list = ['git']

""" Lightline
let g:lightline = {
      \ 'colorscheme': 'powerline',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'gitbranch', 'readonly', 'filename', 'modified', 'cwd'] ],
      \   'right': [ [ 'lineinfo' ], [ 'percent' ], [ 'fileformat', 'fileencoding', 'filetype' ] ]
      \ },
      \ 'inactive': {
      \   'left': [ [ 'filename', 'modified' ] ],
      \   'right': [ [ 'lineinfo' ], [ 'percent' ] ]
      \ },
      \ 'component': {
      \   'lineinfo': '%3l:%-2c',
      \ },
      \ 'component_function': {
      \   'gitbranch': 'fugitive#head',
      \   'cwd': 'CwdForLightline'
      \ },
      \ 'component_function_visible_condition': {
      \   'cwd': 'get(b:,"lightline_filename","")!=#""',
      \   'filename': 'get(b:,"lightline_filename","")!=#""',
      \   'mode': '1',
      \ },
      \ }

function! CwdForLightline()
    return expand('%:p:h')
    " return 'xx'
endfunction


""" Gutentag
let g:gutentags_trace = 0
let g:gutentags_cache_dir = '~/.vim/gutentags'
let g:gutentags_ctags_exclude = [".git", ".work", '*.css', '*.html', '*.js', '*.json', '*.xml',
                            \ '*.phar', '*.ini', '*.rst',
                            \ '*vendor/*/test*', '*vendor/*/Test*',
                            \ '*vendor/*/fixture*', '*vendor/*/Fixture*',
                            \ '*var/cache*', '*var/log*']


"" Pdv (php doc generator)
"let g:pdv_cfg_Author = 'Danilo Silva <danilo.silva@qwentes.it>'
"let g:pdv_cfg_autoEndFunction=0
"let g:pdv_cfg_autoEndClass=0
"let g:pdv_cfg_php4always=0
"let g:pdv_cfg_annotation_License=0
"let g:pdv_cfg_annotation_Copyright=0
"let g:pdv_cfg_annotation_Package=0
"let g:pdv_cfg_annotation_Version=0
"nnoremap <silent> <leader>d mg :call PhpDocSingle()<CR>`g
"nnoremap <silent> <leader>h mg :call UpdatePhpDocIfExists()<CR>`g
"function! UpdatePhpDocIfExists()
"    normal! k
"    if getline('.') =~ '/'
"        normal! V%d
"    else
"        normal! j
"    endif
"    call PhpDocSingle()
"    normal! k^%k$
"    if getline('.') =~ ';'
"        exe "normal! $svoid"
"    endif
"endfunction

"" Supertab
"let g:SuperTabLongestHighlight = 1

"set nofoldenable                " disable code folding
"let g:DisableAutoPHPFolding = 1 " disable PIV's folding

" let g:syntastic_php_checkers=['php', 'phpcs']
"" let g:syntastic_php_checkers=['php', 'phpcs', 'phpmd', 'phpstan']
"let g:syntastic_php_phpcs_exec = '/usr/local/bin/phpcs.phar'
"" let g:syntastic_php_phpcs_args = '--standard=psr2'
"let g:syntastic_php_phpmd_exec = '/usr/local/bin/phpmd.phar'
"let g:syntastic_php_phpmd_post_args = 'cleancode,codesize,controversial,design,unusedcode'

"let g:syntastic_php_phpstan_exec = '/usr/local/bin/phpstan'

"let g:syntastic_always_populate_loc_list = 1
"let g:syntastic_auto_loc_list = 5
"let g:syntastic_check_on_open = 1
"let g:syntastic_check_on_wq = 1

"set nospell

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
