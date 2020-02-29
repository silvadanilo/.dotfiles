"'colorscheme': 'powerline'
"'colorscheme': 'solarized'
"'colorscheme': 'gruvbox'
""" Lightline
let g:lightline = {
      \ 'colorscheme': 'gruvbox_material',
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
endfunction
