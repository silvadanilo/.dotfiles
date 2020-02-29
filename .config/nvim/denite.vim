call denite#custom#option('default', {
      \ 'prompt': '❯'
      \ })

call denite#custom#var('file/rec', 'command',
      \ ['fd', '-H', '--full-path'])
call denite#custom#var('grep', 'command', ['rg'])
call denite#custom#var('grep', 'default_opts',
      \ ['--hidden', '--vimgrep', '--smart-case'])
call denite#custom#var('grep', 'recursive_opts', [])
call denite#custom#var('grep', 'pattern_opt', ['--regexp'])
call denite#custom#var('grep', 'separator', ['--'])
call denite#custom#var('grep', 'final_opts', [])
call denite#custom#option('_', 'max_dynamic_update_candidates', 100000)
call denite#custom#option('_', {
      \ 'split': 'floating',
      \ 'highlight_matched_char': 'Underlined',
      \ 'highlight_matched_range': 'NormalFloat',
      \ 'wincol': &columns / 6,
      \ 'winwidth': &columns * 2 / 3,
      \ 'winrow': &lines / 6,
      \ 'winheight': &lines * 2 / 3
      \ })

autocmd FileType denite call s:denite_settings()

function! s:denite_settings() abort
  nnoremap <silent><buffer><expr> <CR>
        \ denite#do_map('do_action')
  nnoremap <silent><buffer><expr> <C-v>
        \ denite#do_map('do_action', 'vsplit')
  nnoremap <silent><buffer><expr> d
        \ denite#do_map('do_action', 'delete')
  nnoremap <silent><buffer><expr> p
        \ denite#do_map('do_action', 'preview')
  nnoremap <silent><buffer><expr> <Esc>
        \ denite#do_map('quit')
  nnoremap <silent><buffer><expr> q
        \ denite#do_map('quit')
  nnoremap <silent><buffer><expr> i
        \ denite#do_map('open_filter_buffer')
endfunction

autocmd FileType denite-filter call s:denite_filter_settings()

function! s:denite_filter_settings() abort
  nmap <silent><buffer> <Esc> <Plug>(denite_filter_quit)
endfunction

nnoremap <C-p> :<C-u>Denite file/rec -start-filter<CR>
nnoremap <leader>s :<C-u>Denite buffer<CR>
nnoremap <leader>8 :<C-u>DeniteCursorWord grep:.<CR>
nnoremap <leader>/ :<C-u>Denite -start-filter grep:::!<CR>
nnoremap <leader><Space>/ :<C-u>DeniteBufferDir -start-filter grep:::!<CR>
nnoremap <leader>d :<C-u>DeniteBufferDir file/rec -start-filter<CR>
nnoremap <leader>r :<C-u>Denite -resume -cursor-pos=+1<CR>
nnoremap <leader><C-r> :<C-u>Denite register:.<CR>
nnoremap <leader>g :<C-u>Denite gitstatus<CR>
