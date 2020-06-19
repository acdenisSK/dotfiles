#!/bin/sh

[ -f $HOME/.Xresources ] && xrdb -load $HOME/.Xresources

exec bspwm
