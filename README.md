My configuration files.

# Note -- PATH:

If you're a Rust user, I suggest to add

```sh
[ -d "$HOME/.cargo" ] && export PATH="$HOME/.cargo/bin:$PATH"
```

...as the content of a shell script located in `/etc/profile.d` (name is irrelevant) for a complete integration of these dotfiles.
The shell scripts in this directory get all sourced on login, making it convenient for administering a system-wide PATH, for example.
