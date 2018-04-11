#!/bin/bash
function sudo ()
{
    [[ $EUID = 0 ]] || set -- command sudo "$@"
    "$@"
}

function installVim() {
    sudo apt-get remove -y --purge vim vim.tiny

    sudo apt-get install -y lua5.1 liblua5.1-dev libncurses5-dev libgnome2-dev \
        libgnomeui-dev libgtk2.0-dev libatk1.0-dev libbonoboui2-dev libcairo2-dev \
        libx11-dev libxpm-dev libxt-dev python-dev ruby-dev wget python3-pip python3-dev

    pip3 install --user neovim typing jedi psutil setproctitle

    mkdir -p /tmp/install
    cd /tmp/install
    rm -rf vim80
    wget ftp://ftp.vim.org/pub/vim/unix/vim-8.0.tar.bz2
    tar xvjf vim-8.0.tar.bz2
    cd vim80

    ./configure --with-features=huge \
                --enable-gui=gtk2 \
                --enable-cscope \
                --prefix=/usr \
                --enable-luainterp \
                --with-lua-prefix=/usr \
                --enable-rubyinterp \
                --enable-python3interp \
                --with-python3-config-dir=$(python3-config --configdir)

    make VIMRUNTIMEDIR=/usr/share/vim/vim80
    sudo make install
}

installVim;
exit $?
