alias tmux="TERM=screen-256color tmux"
alias sumawk="awk '{s+=\$1} END {printf \"%.0f\", s}'"

if [ -f ~/.bash_aliases.local ]; then
    . ~/.bash_aliases.local
fi
