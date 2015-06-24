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
    echo '# #Installing Vim 7.4 ....'
    curl https://raw.githubusercontent.com/silvadanilo/.dotfiles/master/install-vim-7.4.sh -L -o - > /tmp/install-vim-7.4.sh
    bash /tmp/install-vim-7.4.sh
    echo '# # Vim is installed'
}

# # TODO:!!! Check curl
echo '# # CHECKING INSTALLED VERSION OF CURL'

# # Install Vim 7.4
# is vim installed?
echo '# # CHECKING INSTALLED VIM VERSION...'
vim --version >/dev/null 2>&1
if [ $? -eq 0 ]; then
    echo 'Vim is installed and is version is: "' `vim --version | head -n 1` '"'
else
    echo 'Vim is not installed'
fi

while true; do
    read -p "Do you want to install vim 7.4 ? (y/n) " shouldInstallVim
    echo ""
    case $shouldInstallVim in
        [Yy]* ) installVim; break;;
        [Nn]* ) exit;;
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
