alias tmux="TERM=screen-256color tmux"
alias sumawk="awk '{s+=\$1} END {printf \"%.0f\", s}'"
alias ops='git commit --amend --no-edit -n'
alias duh='du -h --max-depth=1 | sort -h'

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
