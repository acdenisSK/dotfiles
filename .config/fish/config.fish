set fish_greeting

alias ls="ls --color=auto"
alias pacman="pacman --color=auto"
alias yay="yay --color=auto"
alias cargo="cargo --color=auto"

if test -d $HOME/dotfiles
    alias config="git --git-dir=$HOME/dotfiles --work-tree=$HOME"
end
