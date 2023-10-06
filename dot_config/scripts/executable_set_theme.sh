#!/bin/bash

source utils

THEME=$1

if [[ -z "$THEME" ]]; then
    THEME=$(get_themes | fzf)
fi

if [[ ! -f ~/.config/bspwm/assets/$THEME.png ]]; then
    fatalln "ERROR: Invalid theme name."
fi

echo -n $THEME | cat > ~/.theme
bspc wm -r

successln "Changed theme to $THEME."
