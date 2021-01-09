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

shopt -s no_empty_cmd_completion

shopt -s expand_aliases

shopt -s histappend

# Prompt

GREEN="\[\e[38;5;2m\]"
LIGHTGREEN="\[\e[38;5;10m\]"
RESET="\[\e[0m\]"

PS1="${LIGHTGREEN}\u${RESET}@\h ${GREEN}\w${RESET}> "
