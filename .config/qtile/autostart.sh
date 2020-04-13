#!/bin/bash

# Only run the program if it isn't already.
function run {
    if ! pgrep $1 ; then
        $@
    fi
}

run discord &
run steam &
run gammy &
run flameshot &
run nm-applet &
