# A gobble of environment variables and aliases shared amongst bash and zsh.

export LANG=en_US.UTF-8

alias ls='ls --color=auto'
alias pacman='pacman --color=auto'
alias yay='yay --color=auto'
alias cargo='cargo --color=auto'

export VISUAL="nvim"
export EDITOR="${VISUAL}"

alias config='/usr/bin/git --git-dir=/home/alex/dotfiles --work-tree=/home/alex'
