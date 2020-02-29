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

augroup CloseLoclistWindowGroup
    autocmd!
    autocmd QuitPre * if empty(&buftype) | lclose | endif
augroup END

augroup CloseQuickfixWindowGroup
    autocmd!
    autocmd QuitPre * if empty(&buftype) | cclose | endif
augroup END


""""""" START PERSONAL CONFIGURATION
if filereadable(expand('~/.config/nvim/custom-functions.vim'))
    source ~/.config/nvim/custom-functions.vim
endif

if filereadable(expand('~/.config/nvim/generic.vim'))
    source ~/.config/nvim/generic.vim
endif

if filereadable(expand('~/.config/nvim/colors.vim'))
    source ~/.config/nvim/colors.vim
endif

"""""""""""""""""""
" AUTOCOMPLETION
"""""""""""""""""""
if filereadable(expand('~/.config/nvim/deoplete.vim'))
    source ~/.config/nvim/deoplete.vim
endif

" if filereadable(expand('~/.config/nvim/ncm2.vim'))
"     source ~/.config/nvim/ncm2.vim
" endif

"""""""""""""""""""
" CODE NAVIGATION
"""""""""""""""""""
if filereadable(expand('~/.config/nvim/fzf.vim'))
    source ~/.config/nvim/fzf.vim
endif

if filereadable(expand('~/.config/nvim/nerdtree.vim'))
    source ~/.config/nvim/nerdtree.vim
endif

" if filereadable(expand('~/.config/nvim/ctrlp.vim'))
"     source ~/.config/nvim/ctrlp.vim
" endif

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


"""""""""""""""""""
" UI
"""""""""""""""""""
if filereadable(expand('~/.config/nvim/tagbar.vim'))
    source ~/.config/nvim/tagbar.vim
endif

if filereadable(expand('~/.config/nvim/leadearguide.vim'))
    source ~/.config/nvim/leadearguide.vim
endif

if filereadable(expand('~/.config/nvim/arpeggio.vim'))
    source ~/.config/nvim/arpeggio.vim
endif

if filereadable(expand('~/.config/nvim/gutentags.vim'))
    source ~/.config/nvim/gutentags.vim
endif

if filereadable(expand('~/.config/nvim/lightline.vim'))
    source ~/.config/nvim/lightline.vim
endif

if filereadable(expand('~/.config/nvim/startify.vim'))
    source ~/.config/nvim/startify.vim
endif

""" Signify
let g:signify_vcs_list = ['git']

""" Syntastics
"let g:syntastic_always_populate_loc_list = 1
"let g:syntastic_auto_loc_list = 5
"let g:syntastic_check_on_open = 1
"let g:syntastic_check_on_wq = 1

"set nospell

"""""""""""""""""""
" CODING
"""""""""""""""""""
if filereadable(expand('~/.config/nvim/ale.vim'))
    source ~/.config/nvim/ale.vim
endif

if filereadable(expand('~/.config/nvim/php.vim'))
    source ~/.config/nvim/php.vim
endif

if filereadable(expand('~/.config/nvim/utilsnip.vim'))
    source ~/.config/nvim/utilsnip.vim
endif

""" echodoc
let g:echodoc#enable_at_startup = 1
let g:echodoc#type = 'floating'
highlight link EchoDocFloat Pmenu

""" swoop
let g:swoopUseDefaultKeyMap = 0

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

"" Supertab
"let g:SuperTabLongestHighlight = 1

" Local vimrc ================================================================
if filereadable(expand('~/.vimrc.local'))
    source ~/.vimrc.local
endif
