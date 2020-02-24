alias tmux="TERM=screen-256color tmux"
alias sumawk="awk '{s+=\$1} END {printf \"%.0f\", s}'"
alias ops='git commit --amend --no-edit'

function kp() {
    ps -fe | fzf | tr -s ' ' | cut -d ' ' -f 2 | xargs kill $1
}

if [ -f ~/.bash_aliases.local ]; then
    . ~/.bash_aliases.local
fi
