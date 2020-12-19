#!/bin/sh

# This should be removed in favour of .config/environment.d/10-path.conf,
# but will unfortunately have to stay as the PATH variable gets
# overriden by /etc/profile. I do not want to change
# system files under /etc, especially if I wish to synchronise
# changes to the dotfiles repo.
export PATH=${HOME}/.local/bin:${HOME}/.cargo/bin:$PATH

# Source .bashrc if we're running bash and the file exists

if [ -n "$BASH_VERSION" ] && [ -f "$HOME/.bashrc" ]; then
    . "$HOME/.bashrc"
fi

[ -e "$HOME/.nix-profile/etc/profile.d/nix.sh" ] && . "$HOME/.nix-profile/etc/profile.d/nix.sh"
