#!/bin/bash
function sudo ()
{
    [[ $EUID = 0 ]] || set -- command sudo "$@"
    "$@"
}

sudo apt-get install -y libevent-dev libncurses-dev pkg-config

cd /tmp
rm -rf tmux-2.2
wget "https://github.com/tmux/tmux/releases/download/2.2/tmux-2.2.tar.gz"
tar xvzf tmux-2.2.tar.gz
cd tmux-2.2

autoreconf -fis
./configure

make
sudo make install
