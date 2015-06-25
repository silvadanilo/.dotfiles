#!/usr/bin/env /bin/bash

function installVim() {
    echo -e '\e[33m# #Installing Vim 7.4 ....\e[0m'
    curl https://raw.githubusercontent.com/silvadanilo/.dotfiles/master/install-vim-7.4.sh -L -o - > /tmp/install-vim-7.4.sh
    bash /tmp/install-vim-7.4.sh
    echo -e '\e[33m# # Vim 7.4 is installed\e[0m'
}

function installTmux() {
    echo -e '\e[33m# #Installing Tmux 1.9a ....\e[0m'
    curl https://raw.githubusercontent.com/silvadanilo/.dotfiles/master/install-tmux-1.9a.sh -L -o - > /tmp/install-tmux-1.9a.sh
    bash /tmp/install-tmux-1.9a.sh
    echo -e '\e[33m# # Tmux 1.9a is installed\e[0m'
}

# # Install Vim 7.4
# is vim installed?
echo '# # CHECKING INSTALLED VIM VERSION...'
vim --version >/dev/null 2>&1
if [ $? -eq 0 ]; then
    echo -e '\e[32mVim is installed\e[0m and is version is: "\e[33m' `vim --version | head -n 1` '\e[0m"'
else
    echo -e '\e[31mVim is not installed\e[0m'
fi

while true; do
    read -e -p "Do you want to compile and install vim 7.4 ? (y/n) " -i 'n' shouldInstallVim
    echo ""
    case $shouldInstallVim in
        [Yy]* ) installVim; break;;
        [Nn]* ) break;;
        * ) echo "Please answer yes or no.";;
    esac
done


# # Install Tmux 1.9a
# is vim installed?
echo '# # CHECKING INSTALLED Tmux VERSION...'
tmux -V >/dev/null 2>&1
if [ $? -eq 0 ]; then
    echo -e '\e[32mTmux is installed\e[0m and is version is: "\e[33m' `tmux -V | head -n 1` '\e[0m"'
else
    echo -e '\e[31mTmux is not installed\e[0m'
fi

while true; do
    read -e -p "Do you want to compile and install tmux 1.9a? (y/n) " -i 'n' shouldInstallTmux
    echo ""
    case $shouldInstallTmux in
        [Yy]* ) installTmux; break;;
        [Nn]* ) break;;
        * ) echo "Please answer yes or no.";;
    esac
done

# # TODO:!!! Check curl
echo '# # CHECKING INSTALLED VERSION OF CURL'

while true; do
    read -e -p "Do you want to install vimpeppers? (y/n) " -i 'y' shouldInstallVimpeppers
    echo ""
    case $shouldInstallVimpeppers in
        [Yy]* ) curl https://raw.github.com/gcapizzi/vimpeppers/master/bootstrap.sh -L -o - | sh; break;;
        [Nn]* ) break;;
        * ) echo "Please answer yes or no.";;
    esac
done
