#!/bin/bash

# Environment variables and aliases

export LANG=en_US.UTF-8
export TERMINAL="alacritty"
export BROWSER="firefox"
export PAGER="less"

alias ls="ls --color=auto"

# Only apply these if the programs already exist
type pacman &>/dev/null && alias pacman="pacman --color=auto"
type yay &>/dev/null && alias yay="yay --color=auto"
type cargo &>/dev/null && alias cargo="cargo --color=auto"

if type nvim &>/dev/null; then
    alias vim="nvim"
    export VISUAL="nvim"
elif type vim &>/dev/null; then
    export VISUAL="vim"
else
    export VISUAL="nano"
fi

export EDITOR="$VISUAL"
export GIT_EDITOR="$EDITOR"

if type git &>/dev/null && [[ -d $HOME/dotfiles ]]; then
    alias config="git --git-dir=$HOME/dotfiles --work-tree=$HOME"
fi

# Programmable bash completions

[[ -f /usr/share/bash-completion/bash_completion ]] && . /usr/share/bash-completion/bash_completion

# Prompt

SKYBLUE="\[\e[38;5;74m\]"
DEEPSKY="\[\e[38;5;39m\]"
RESET="\[\e[0m\]"

PS1="${DEEPSKY}[${SKYBLUE}\u@\h${RESET} \W${DEEPSKY}]${RESET}\$ "
