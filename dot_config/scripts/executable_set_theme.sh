#!/bin/bash

# ANSI escape codes for colors
red='\033[31m'
green='\033[32m'
blue='\033[34m'
reset='\033[0m'

# Echo wrappers.
function infoln() {
    echo -e "${blue}$1${reset}"
}

function successln() {
    echo -e "${green}$1${reset}"
}

function errorln() {
    echo -e "${red}$1${reset}"
}

THEME=$1

if [[ -z "$THEME" ]]; then
    errorln "ERROR: You must provide a theme to be set."
    exit 1
fi

if [[ ! -f ~/.config/bspwm/assets/$THEME.png ]]; then
    errorln "ERROR: $THEME is not a valid theme."
    exit 2
fi

echo -n $THEME | cat > ~/.theme
bspc wm -r

successln "Changed theme to $THEME."
