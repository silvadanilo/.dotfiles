#!/usr/bin/env bash
########## Variables

dir=~/.dotfiles                    # dotfiles directory
olddir=~/.dotfiles_old             # old dotfiles backup directory
files=".bashrc .vimrc .vim"       # list of files/folders to symlink in homedir

##########

echo '#######################'
echo '# dot files installer #'
echo '#######################'

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

# # TODO:!!! Check curl
echo '# # CHECKING INSTALLED VERSION OF CURL'

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
    read -p "Do you want to compile and install vim 7.4 ? (y/n) " shouldInstallVim
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
    read -p "Do you want to compile and install tmux 1.9a? (y/n) " shouldInstallTmux
    echo ""
    case $shouldInstallTmux in
        [Yy]* ) installTmux; break;;
        [Nn]* ) break;;
        * ) echo "Please answer yes or no.";;
    esac
done

# # create dotfiles_old in homedir
# echo "Creating $olddir for backup of any existing dotfiles in ~"
# mkdir -p $olddir
# echo "...done"

# # change to the dotfiles directory
# echo "Changing to the $dir directory"
# cd $dir
# echo "...done"

# # move any existing dotfiles in homedir to dotfiles_old directory, then create symlinks
# for file in $files; do
#     echo "Moving any existing dotfiles from ~ to $olddir"
#     mv ~/$file ~/$olddir/
#     echo "Creating symlink to $file in home directory."
#     ln -s $dir/$file ~/$file
# done

# source ~/.bashrc
