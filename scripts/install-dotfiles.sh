#!/usr/bin/env /bin/bash
#################### Variables
dir=~/.dotfiles                    # dotfiles directory
olddir=~/.dotfiles_old             # old dotfiles backup directory
files=".bash_aliases .tmux.conf .fonts .gitconfig .gitconfig.local .vimrc.local .vimrc.plugins.local .zshrc" # list of files/folders to symlink in homedir
##############################

######################## Colors
export WHITE="\e[1;37m"
export LGRAY="\e[0;37m"
export GRAY="\e[1;30m"
export BLACK="\e[0;30m"
export RED="\e[0;31m"
export LRED="\e[1;31m"
export GREEN="\e[0;32m"
export LGREEN="\e[1;32m"
export YELLOW="\e[0;33m"
export BLUE="\e[0;34m"
export LBLUE="\e[1;34m"
export PURPLE="\e[0;35m"
export PINK="\e[1;35m"
export CYAN="\e[0;36m"
export LCYAN="\e[1;36m"
export Z="\e[0m"
##############################

echo '#######################'
echo -e "# ${GREEN}dot files installer${Z} #"
echo '#######################'
echo ''


# # Checking presence of git
echo -e "# # ${LGREEN}CHECKING${Z} INSTALLED ${YELLOW}GIT${Z} VERSION..."
git --version >/dev/null 2>&1
if [ $? -eq 0 ]; then
    echo -e "${GREEN}Git is installed$Z and is version is: '$YELLOW"`git --version | head -n 1`"$Z'"
    echo -e "${LGREEN}...Done${Z}\n"
else
    echo -e "${RED}Git is not installed!$Z"
    echo -e "${RED}git command is mandatory to run this script, install it.$Z"
    echo -e "(i.e. # sudo apt-get update && sudo apt-get install git)"
    exit -1;
fi
echo ""

cd ~

if [ -e $DIR ]; then
    ##TODO:! ask confirmation to remove it
    echo -e "${YELLOW}$dir${Z} is already exists, ${RED}removing it...${Z}"
    rm -fr $dir
    echo -e "${LGREEN}...Done${Z}\n"
fi

# # clone .dotfiles project
echo -e "# ${LGREEN}Cloning${Z} ${YELLOW}silvadanilo/.dotfiles${Z} repository..."
git clone https://github.com/silvadanilo/.dotfiles.git $dir
echo -e "${LGREEN}...Done${Z}\n"

# create dotfiles_old in homedir
echo -e "${LGREEN}Creating${Z} ${YELLOW}$olddir${Z} for backup of any existing dotfiles in ~"
mkdir -p $olddir
echo -e "${LGREEN}...Done${Z}\n"

# move any existing dotfiles in homedir to dotfiles_old directory, then create symlinks
for file in $files; do
    if [ -e ~/$file ]; then
        echo -e "${LGREEN}Moving${Z} existing dotfiles $YELLOW$file$Z from $YELLOW~$Z to $YELLOW$olddir$Z ..."
        mv ~/$file $olddir/ >/dev/null 2>&1
    fi
    echo -e "${LGREEN}Creating${Z} symlink to $YELLOW$file$Z in home directory."
    ln -s $dir/$file ~/$file
    echo ""
done

echo -e "# ${LGREEN}Creating${Z} a fonts conf symbonlic link..."
ln -s $dir/.config/fontconfig/conf.d ~/.fonts.conf.d
echo -e "${LGREEN}...Done${Z}\n"

echo -e "# ${LGREEN}Reload${Z} ${YELLOW}.bashrc${Z} file..."
source ~/.bashrc
echo -e "${LGREEN}...Done${Z}\n"

echo -e "${GREEN}#######\nDONE...\n#######${Z}\n"

echo -e "${GREEN}# Remember to edit sample files like:${Z} ${LGREEN}.gitconfig.local${Z}"
