if has('nvim')
  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
else
  Plug 'roxma/nvim-yarp'
  Plug 'roxma/vim-hug-neovim-rpc'
  Plug 'Shougo/deoplete.nvim'
endif


Plug 'hecal3/vim-leader-guide'
Plug 'mhinz/vim-startify'
Plug 'raimondi/delimitMate'
Plug 'sheerun/vim-polyglot'
Plug 'kana/vim-arpeggio'
Plug 'pelodelfuego/vim-swoop'
Plug 'tpope/vim-abolish'


Plug 'SirVer/ultisnips' | Plug 'phux/vim-snippets'

"Plug 'ncm2/ncm2'
"Plug 'ncm2/ncm2-ultisnips'
"Plug 'ncm2/ncm2-bufword'
"Plug 'ncm2/ncm2-path'

Plug 'altercation/vim-colors-solarized'
Plug 'itchyny/lightline.vim' " Statusbar
Plug 'vim-scripts/vim-orgmode'

"Plug 'ctrlpvim/ctrlp.vim'
Plug 'scrooloose/nerdtree'
Plug 'ludovicchabant/vim-gutentags' "Ctags
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all --bin' }
Plug 'junegunn/fzf.vim'
Plug 'mileszs/ack.vim'
" Plug 'jremmen/vim-ripgrep'

Plug 'Lokaltog/vim-easymotion'
Plug 'kana/vim-textobj-user'
Plug 'kana/vim-textobj-function'
Plug 'kentaro/vim-textobj-function-php'
Plug 'Julian/vim-textobj-variable-segment'

Plug 'majutsushi/tagbar'

Plug 'AndrewRadev/splitjoin.vim'
Plug 'junegunn/gv.vim'
Plug 'mattn/gist-vim'
Plug 'mhinz/vim-signify'
Plug 'scrooloose/syntastic'
Plug 'tmhedberg/matchit'
Plug 'tommcdo/vim-fubitive'
Plug 'tpope/vim-commentary'
"Plug 'tpope/vim-endwise' " it conflict with pumvisible and insert pumvisible after press CR
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-rhubarb'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'vim-scripts/Gundo'
Plug 'terryma/vim-multiple-cursors'
Plug 'godlygeek/tabular'
Plug 'michaeljsmith/vim-indent-object'

Plug 'MarcWeber/vim-addon-local-vimrc'

" Vim-Session
Plug 'xolox/vim-misc'
Plug 'xolox/vim-session'

"""""""""""""""""""""""""""""""""""""""""""""""
" CODE RELATED PLUGINS
Plug 'w0rp/ale' " write less messy code (syntax checker)
Plug 'vim-scripts/paredit.vim' " balanced bracket, etc

" PHP RELATED PLUGINS
"Plug 'phpactor/phpactor', { 'do': ':call phpactor#Update()', 'for': 'php'}
Plug 'phpactor/phpactor' ,  {'do': 'composer install', 'for': 'php'}
Plug 'kristijanhusak/deoplete-phpactor'
"Plug 'phpactor/ncm2-phpactor', {'for': 'php'}
"Plug 'phpstan/vim-phpstan'

Plug 'StanAngeloff/php.vim', {'for': 'php'}
Plug 'arnaud-lb/vim-php-namespace', {'for': 'php'}
Plug 'dantleech/vim-phpnamespace', {'for': 'php'}
Plug 'alvan/vim-php-manual', {'for': 'php'}
Plug '2072/php-indenting-for-vim', {'for': 'php'}

Plug 'Rican7/php-doc-modded', {'for': 'php'}

" ELIXIR RELATED PLUGINS
Plug 'elixir-editors/vim-elixir', {'for': 'elixir'}

" JAVASCRIPT RELATED PLUGINS
Plug 'leafgarland/typescript-vim' " Typescript

" RUST RELATED PLUGINS
Plug 'rust-lang/rust.vim' " Rust

" MARKDOWN RELATED PLUGINS
Plug 'gabrielelana/vim-markdown'

" Yaml RELATED PLUGINS
Plug 'avakhov/vim-yaml'

" Ansible RELATED PLUGINS
Plug 'pearofducks/ansible-vim'

" SHOULD BE THE LAST ONE
Plug 'ryanoasis/vim-devicons'
