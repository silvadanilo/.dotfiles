""" NCM2
"augroup ncm2
"  au!
"  autocmd BufEnter * call ncm2#enable_for_buffer()
"  au User Ncm2PopupOpen set completeopt=noinsert,menuone,noselect
"  au User Ncm2PopupClose set completeopt=menuone
"augroup END

" parameter expansion for selected entry via Enter
"inoremap <silent> <expr> <CR> (pumvisible() ? ncm2_ultisnips#expand_or("\<CR>", 'n') : "\<CR>")
