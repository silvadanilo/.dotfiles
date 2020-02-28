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
  let g:ctrlp_user_command = 'rg --no-ignore --files %s'
  let g:ctrlp_use_caching = 0
  let g:ctrlp_working_path_mode = 'ra'
  let g:ctrlp_switch_buffer = 'et'
endif
