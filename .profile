#!/bin/sh

export PATH="$HOME/.local/bin:$HOME/.cargo/bin:$PATH"

export LANG=en_US.UTF-8
export TERMINAL="alacritty"
export BROWSER="firefox"
export PAGER="less"
export READER="zathura"

export VISUAL="vim"
export EDITOR="$VISUAL"
export GIT_EDITOR="$EDITOR"

# Source .bashrc if we're running bash and the file exists

if [ -n "$BASH_VERSION" ] && [ -f "$HOME/.bashrc" ]; then
    . "$HOME/.bashrc"
fi
