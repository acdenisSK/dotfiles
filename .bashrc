#!/bin/bash

# Environment variables

export LANG=en_US.UTF-8

if [ -x /usr/bin/nvim ]; then
    export VISUAL="nvim"
elif [ -x /usr/bin/vim ]; then
    export VISUAL="vim"
else 
    export VISUAL="nano"
fi

export EDITOR="${VISUAL}"

# Aliases

alias ls="ls --color=auto"
  
# Only apply these if the programs already exist
[ -x /usr/bin/pacman ] && alias pacman="pacman --color=auto"
[ -x /usr/bin/yay ]    && alias yay="yay --color=auto"
[ -x /usr/bin/cargo ]  && alias cargo="cargo --color=auto"
 
if [ -x /usr/bin/git ] && [ -d $HOME/dotfiles ]; then
    alias config="git --git-dir=$HOME/dotfiles --work-tree=$HOME"
fi

# Programmable bash completions

[ -f /usr/share/bash-completion/bash_completion ] && source /usr/share/bash-completion/bash_completion

# Prompt

SKYBLUE="\[$(tput setaf 74)\]"
DEEPSKY="\[$(tput setaf 39)\]"
RESET="\[$(tput sgr0)\]"

PS1="${DEEPSKY}[${RESET}${SKYBLUE}\u@\h${RESET} \W${DEEPSKY}]${RESET}\$ "

