#!/bin/bash
function sudo ()
{
    [[ $EUID = 0 ]] || set -- command sudo "$@"
    "$@"
}

function installNeovim() {
    sudo apt-get install -y fuse libfuse2 git python3-pip ack-grep wget curl libncurses5-dev \
        libgnome2-dev libgnomeui-dev libgtk2.0-dev libatk1.0-dev libbonoboui2-dev \
        libcairo2-dev libx11-dev libxpm-dev libxt-dev

    mkdir -p /tmp/install
    cd /tmp/install
    wget --quiet https://github.com/neovim/neovim/releases/download/nightly/nvim.appimage --output-document nvim
    chmod +x nvim
    sudo chown root:root nvim
    sudo mv nvim /usr/bin
    mkdir -p ~/.config/nvim
    curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    pip3 install --user neovim
}

installNeovim;
exit $?
