#!/bin/bash
function sudo ()
{
    [[ $EUID = 0 ]] || set -- command sudo "$@"
    "$@"
}

function installNvim() {
    sudo apt-get install -y cmake

    cd /tmp
    git clone --depth=1 https://github.com/neovim/neovim.git && cd neovim
    make CMAKE_BUILD_TYPE=Release
    sudo make install
    mkdir -p ~/.config/nvim # this is your "~/.vim"
    touch ~/.config/nvim/init.vim # this is your "~/.vimrc"
}

installNvim;
exit $?
