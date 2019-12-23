# A gobble of environment variables and aliases shared amongst bash and zsh.

export LANG=en_US.UTF-8

alias ls="ls --color=auto"

# Only apply these if the programs already exist
[ -x /usr/bin/pacman ] && alias pacman="pacman --color=auto"
[ -x /usr/bin/yay ] && alias yay="yay --color=auto"
[ -x /usr/bin/cargo ] && alias cargo="cargo --color=auto"

if [ -x /usr/bin/git ] && [ -d $HOME/dotfiles ]; then
    alias config="/usr/bin/git --git-dir=$HOME/dotfiles --work-tree=$HOME"
fi

export VISUAL="nvim"
export EDITOR="${VISUAL}"

NVM_PATH=/usr/share/nvim/init-nvm.sh

[ -f $NVM_PATH ] && source $NVM_PATH

