syntax on
set background=dark
set t_Co=256
if filereadable(expand("~/.config/nvim/plugged/vim-colors-solarized/colors/solarized.vim"))
    let g:solarized_termcolors=256
    colorscheme solarized
endif

if filereadable(expand("~/.config/nvim/plugged/gruvbox/colors/gruvbox.vim"))
    let g:gruvbox_contrast_dark='hard'
    colorscheme gruvbox
endif

" Term color
if !has('nvim')
set term=screen-256color
endif
