" Deoplete
let g:deoplete#enable_at_startup = 1
let g:deoplete#enable_smart_case = 1
let g:deoplete#file#enable_buffer_path = 1
let g:deoplete#sources = {}
let g:deoplete#sources.php = ['phpactor', 'ultisnips', 'omni', 'around', 'member', 'buffer']

let g:neosnippet#enable_completed_snippet = 1

call deoplete#custom#source('_',  'max_menu_width', 0)
call deoplete#custom#source('_',  'max_abbr_width', 0)
call deoplete#custom#source('_',  'max_kind_width', 0)
