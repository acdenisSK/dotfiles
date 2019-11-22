#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias pacman='pacman --color=auto'

alias config='/usr/bin/git --git-dir=/home/alex/dotfiles --work-tree=/home/alex'

export VISUAL="nvim"
export EDITOR="${VISUAL}"

SKYBLUE="\[$(tput setaf 74)\]"
DEEPSKY="\[$(tput setaf 39)\]"
RESET="\[$(tput sgr0)\]"

PS1="${DEEPSKY}[${RESET}${SKYBLUE}\u@\h${RESET} \W${DEEPSKY}]${RESET}\$ "
