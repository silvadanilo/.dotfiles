alias tmux="TERM=screen-256color tmux"
alias sumawk="awk '{s+=\$1} END {printf \"%.0f\", s}'"
alias ops='git commit --amend --no-edit -n'
alias duh='du -h --max-depth=1 | sort -h'
alias find-duplicates='rdfind -checksum md5 -deleteduplicates true -n true'
alias remove-duplicates='rdfind -checksum md5 -deleteduplicates true -n false'
alias remove-empty-dirs='find . -type d -empty -delete'
alias monta-casa-sesto='sshfs -p 2222 -o allow_other,default_permissions danilo@casasesto:/ /media/asus/'
alias fix-private-permissions='find . -type d -not -perm 700 -exec chmod 700 {} \;; find . -type f -not -perm 600 -exec chmod 600 {} \;'
alias lls='ls -lhrS'

lxcsh() {
    lxc exec "$1" -- sudo --login --user ubuntu;
}

function kp() {
    ps -fe | fzf | tr -s ' ' | cut -d ' ' -f 2 | xargs kill $1
}

if [ -f ~/.bash_aliases.local ]; then
    . ~/.bash_aliases.local
fi

if [ -f ~/.dotfiles/.scripts/forgit.plugin.zsh ]; then
    . ~/.dotfiles/.scripts/forgit.plugin.zsh
fi

if [ -f ~/.fzf/bin/fzf ]; then
    export PATH=$PATH:~/.fzf/bin/
fi
