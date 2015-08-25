#!/usr/bin/env /bin/bash
#################### Variables
DOTFILE_DIR=~/.dotfiles                    # dotfiles directory
OLD_DOTFILE_DIR=~/.dotfiles_old             # old dotfiles backup directory
FILES=".bash_aliases .tmux.conf .fonts .gitconfig .gitconfig.local .vimrc.local .vimrc.plugins.local .zshrc" # list of files/folders to symlink in homedir
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

if [ -e $DOTFILE_DIR ]; then
    ##TODO:! ask confirmation to remove it
    echo -e "${YELLOW}$DOTFILE_DIR${Z} is already exists, ${RED}removing it...${Z}"
    rm -fr $DOTFILE_DIR
    echo -e "${LGREEN}...Done${Z}\n"
fi

# # clone .dotfiles project
echo -e "# ${LGREEN}Cloning${Z} ${YELLOW}silvadanilo/.dotfiles${Z} repository..."
git clone https://github.com/silvadanilo/.dotfiles.git $DOTFILE_DIR
echo -e "${LGREEN}...Done${Z}\n"

# create dotfiles_old in homedir
echo -e "${LGREEN}Creating${Z} ${YELLOW}$OLD_DOTFILE_DIR${Z} for backup of any existing dotfiles in ~"
mkdir -p $OLD_DOTFILE_DIR
echo -e "${LGREEN}...Done${Z}\n"

# move any existing dotfiles in homedir to dotfiles_old directory, then create symlinks
for FILE in $FILES; do
    if [ -e ~/$FILE ]; then
        echo -e "${LGREEN}Moving${Z} existing dotfiles $YELLOW$file$Z from $YELLOW~$Z to $YELLOW$OLD_DOTFILE_DIR$Z ..."
        mv ~/$FILE $OLD_DOTFILE_DIR/ >/dev/null 2>&1
    fi
    echo -e "${LGREEN}Creating${Z} symlink to $YELLOW$FILE$Z in home directory."
    ln -s $DOTFILE_DIR/$FILE ~/$FILE
    echo ""
done

echo -e "# ${LGREEN}Creating${Z} a fonts conf symbonlic link..."
if [ ! -e ~/.fonts.conf.d ]; then
    ln -s $DOTFILE_DIR/.config/fontconfig/conf.d ~/.fonts.conf.d
fi
echo -e "${LGREEN}...Done${Z}\n"


echo -e "# ${LGREEN}Creating${Z} symlink for vim bundles..."
if [ ! -e ~/.vim/bundle ]; then
    mkdir -p ~/.vim/bundle
fi
for DIR in `ls $DOTFILE_DIR/.vim/bundle`; do
    echo -e "${LGREEN}Creating${Z} symlink to $YELLOW$DIR$Z in ~/.vim/bundle directory."
    ln -s $DOTFILE_DIR/.vim/bundle/$DIR ~/.vim/bundle
    echo "...done\n"
done
echo -e "${LGREEN}...Done${Z}\n"


echo -e "# ${LGREEN}Reload${Z} ${YELLOW}.bashrc${Z} file..."
source ~/.bashrc
echo -e "${LGREEN}...Done${Z}\n"

echo -e "${GREEN}#######\nDONE...\n#######${Z}\n"

echo -e "${GREEN}# Remember to edit sample files like:${Z} ${LGREEN}.gitconfig.local${Z}"
git update-index --assume-unchanged .gitconfig.local
