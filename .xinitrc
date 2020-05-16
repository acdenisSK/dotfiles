#!/bin/sh

[ -f $HOME/.Xresources ] && xrdb -merge $HOME/.Xresources

exec bspwm
