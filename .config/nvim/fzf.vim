""" FZF
let g:fzf_buffers_jump = 1
let g:fzf_commits_log_options = '--graph --color=always --format="%C(auto)%h%d %s %C(black)%C(bold)%cr"'
let g:fzf_commands_expect = 'alt-enter,ctrl-x'
command! -bang -nargs=? -complete=dir FilesP call fzf#vim#files(<q-args>, {'options': ['--layout=reverse', '--info=inline', '--preview', 'cat {}']}, <bang>0)

nnoremap <silent> <space><space> :FilesP<CR>
nnoremap <C-p> :Files<CR>
nnoremap <C-b> :Buffers<CR>
nnoremap <silent> <leader>fb :Buffer<CR>
nnoremap <silent> <leader>fw :Windows<CR>
nnoremap <silent> <leader>fl :BLines<CR>
nnoremap <silent> <leader>ft :BTags<CR>
nnoremap <silent> <leader>fT :Tags<CR>
nnoremap <silent> <leader>fh :History<CR>
nnoremap <silent> <leader>/ :execute 'Rg ' . input('Rg/')<CR>
nnoremap <C-/> :execute 'Rg ' . input('Rg/')<CR>
nnoremap <silent> <leader>. :RgIn

nnoremap <silent> <leader>f* :call SearchWordWithRg()<CR>
vnoremap <silent> <leader>f*:call SearchVisualSelectionWithRg()<CR>
nnoremap <silent> <leader>fgc :Commits<CR>
nnoremap <silent> <leader>fcb :BCommits<CR>
nnoremap <silent> <leader>ft :Filetypes<CR>
nnoremap <leader>A :exec "Rg ".expand("<cword>")<cr>

imap <C-x><C-f> <plug>(fzf-complete-file)
imap <C-x><C-l> <plug>(fzf-complete-line)

function! SearchWordWithRg()
  execute 'Rg' expand('<cword>')
endfunction

function! SearchVisualSelectionWithRg() range
  let old_reg = getreg('"')
  let old_regtype = getregtype('"')
  let old_clipboard = &clipboard
  set clipboard&
  normal! ""gvy
  let selection = getreg('"')
  call setreg('"', old_reg, old_regtype)
  let &clipboard = old_clipboard
  execute 'Rg' selection
endfunction

function! SearchWithRgInDirectory(...)
  call fzf#vim#rg(join(a:000[1:], ' '), extend({'dir': a:1}, g:fzf#vim#default_layout))
endfunction
command! -nargs=+ -complete=dir RgIn call SearchWithRgInDirectory(<f-args>)
