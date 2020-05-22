# Aliases

alias ls="ls --color=auto"
alias pacman="pacman --color=auto"
alias yay="yay --color=auto"
alias cargo="cargo --color=auto"

[[ -d $HOME/dotfiles ]] && alias config="git --git-dir=$HOME/dotfiles --work-tree=$HOME"

# Programmable bash completions

[[ -f /usr/share/bash-completion/bash_completion ]] && . /usr/share/bash-completion/bash_completion

# Shell options

shopt -s checkwinsize

shopt -s expand_aliases

shopt -s histappend

# Prompt

SKYBLUE="\[\e[38;5;74m\]"
DEEPSKY="\[\e[38;5;39m\]"
RESET="\[\e[0m\]"

PS1="${DEEPSKY}[${SKYBLUE}\u@\h${RESET} \W${DEEPSKY}]${RESET}\$ "
