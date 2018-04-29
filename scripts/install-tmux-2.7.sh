#!/bin/bash
function sudo ()
{
    [[ $EUID = 0 ]] || set -- command sudo "$@"
    "$@"
}

sudo apt-get remove -y tmux
sudo apt-get install -y libevent-dev libncurses-dev pkg-config

cd /tmp
rm -rf tmux-2.7
wget "https://github.com/tmux/tmux/releases/download/2.7/tmux-2.7.tar.gz"
tar xvzf tmux-2.7.tar.gz
cd tmux-2.7

autoreconf -fis
./configure

make
sudo make install
