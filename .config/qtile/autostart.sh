#!/bin/bash

# Only run the program if it isn't already.
function run {
    if ! pgrep $1 ; then
        $@ &
    fi
}

run feh --bg-scale ~/.config/qtile/wallpaper.jpg &
run discord &
run gammy &
run flameshot &
run nm-applet &
