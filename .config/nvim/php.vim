""" PHPACTOR
let g:phpactor_executable = '~/.config/nvim/plugged/phpactor/bin/phpactor'

" Include use statement
nmap <Leader>u :call phpactor#UseAdd()<CR>
nmap <f3> :call phpactor#UseAdd()<CR>

" Invoke the context menu
nmap <Leader>mm :call phpactor#ContextMenu()<CR>
nnoremap <m-m> :call phpactor#ContextMenu()<cr>

" Invoke the navigation menu
nmap <Leader>nn :call phpactor#Navigate()<CR>

" Goto definition of class or class member under the cursor
nmap <Leader>o :call phpactor#GotoDefinitionTab()<CR>
nnoremap gd :call phpactor#GotoDefinitionTab()<CR>
nnoremap gr :call phpactor#FindReferences()<CR>
nnoremap gp :call phpactor#Navigate()<CR>

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

""" vim-php-namespace
inoremap <Leader>ec <C-O>:call PhpExpandClass()<CR>
noremap <Leader>ec :call PhpExpandClass()<CR>
autocmd FileType php inoremap <Leader>su <Esc>:call PhpSortUse()<CR>
autocmd FileType php noremap <Leader>su :call PhpSortUse()<CR>
let g:php_namespace_sort_after_insert = 1

let g:syntastic_php_phpstan_exec = '/usr/local/bin/phpstan'
let g:syntastic_php_checkers=['php']
"" let g:syntastic_php_checkers=['php', 'phpcs', 'phpmd', 'phpstan']
"let g:syntastic_php_phpcs_exec = '/usr/local/bin/phpcs.phar'
"" let g:syntastic_php_phpcs_args = '--standard=psr2'
"let g:syntastic_php_phpmd_exec = '/usr/local/bin/phpmd.phar'
"let g:syntastic_php_phpmd_post_args = 'cleancode,codesize,controversial,design,unusedcode'

""" php-cs-fixer
" command! -nargs=1 Silent execute ':silent !'.<q-args> | execute ':redraw!'
" map <c-s> <esc>:w<cr>:Silent php-cs-fixer fix %:p --level=symfony<cr>
" let g:php_cs_fixer_path = "/usr/local/bin/php-cs-fixer.phar" " define the path to the php-cs-fixer.phar
" let g:php_cs_fixer_enable_default_mapping = 1     " Enable the mapping by default (<leader>pcd)
" let g:php_cs_fixer_dry_run = 1                    " Call command with dry-run option
" let g:php_cs_fixer_verbose = 1                    " Return the output of command if 1, else an inline information.

""" Pdv (php doc generator)
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


"set nofoldenable                " disable code folding
"let g:DisableAutoPHPFolding = 1 " disable PIV's folding

" Drop Vdebug settings at the end of the file "
let g:vdebug_options = {
\ 'break_on_open': 1,
\ 'path_maps': {'/var/www': '/home/danilo/sviluppo/heaven-provisioning/projects'},
\ 'port': '9000',
\ 'watch_window_style': 'compact'
\ }
