!#/bin/sh
sudo apt-get install -y lua5.1 liblua5.1-dev vim git zsh wicd-curses curl
#sudo apt-get install evolution i3 virtualbox

# https://github.com/shawncplus/phpcomplete.vim/wiki/Patched-ctags
cd /tmp
wget "https://github.com/shawncplus/phpcomplete.vim/raw/master/misc/ctags-5.8_better_php_parser.tar.gz" -O ctags-5.8_better_php_parser.tar.gz
tar xvf ctags-5.8_better_php_parser.tar.gz
cd ctags
./configure
make
sudo make install
