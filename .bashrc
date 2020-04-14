#!/bin/bash

# Environment variables

export LANG=en_US.UTF-8

if type vim &>/dev/null; then
    export VISUAL="vim"
else
    export VISUAL="nano"
fi

export EDITOR="${VISUAL}"

# Aliases

alias ls="ls --color=auto"

# Only apply these if the programs already exist
type pacman &>/dev/null && alias pacman="pacman --color=auto"
type yay &>/dev/null && alias yay="yay --color=auto"
type cargo &>/dev/null && alias cargo="cargo --color=auto"

if type git &>/dev/null && [ -d $HOME/dotfiles ]; then
    alias config="git --git-dir=$HOME/dotfiles --work-tree=$HOME"
fi

# Programmable bash completions

[ -f /usr/share/bash-completion/bash_completion ] && source /usr/share/bash-completion/bash_completion

# Prompt

SKYBLUE="\[$(tput setaf 74)\]"
DEEPSKY="\[$(tput setaf 39)\]"
RESET="\[$(tput sgr0)\]"

PS1="${DEEPSKY}[${RESET}${SKYBLUE}\u@\h${RESET} \W${DEEPSKY}]${RESET}\$ "
