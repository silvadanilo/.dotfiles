syntax on
set termguicolors
set background=dark
set t_Co=256

" if filereadable(expand("~/.config/nvim/plugged/vim-colors-solarized/colors/solarized.vim"))
"     let g:solarized_termcolors=256
"     colorscheme solarized
" endif

" if filereadable(expand("~/.config/nvim/plugged/gruvbox/colors/gruvbox.vim"))
"     let g:gruvbox_contrast_dark='medium'
"     colorscheme gruvbox
" endif

if filereadable(expand("~/.config/nvim/plugged/gruvbox-material/colors/gruvbox-material.vim"))
    let g:gruvbox_material_background = 'medium'
    colorscheme gruvbox-material
endif

" Term color
if !has('nvim')
    set term=screen-256color
endif
