#!/bin/bash

THEME=$1
RESOLUTION=$2
WIDTH=$(cut -d 'x' -f 1 <<< $RESOLUTION)
HEIGHT=$(cut -d 'x' -f 2 <<< $RESOLUTION)

# Dimensions.
export WIDTH="$(($WIDTH - 14))px"

case $RESOLUTION in
    3840x2160)
        export HEIGHT="48px"
        export FONT0="JetBrainsMono Nerd Font:size=19:weight=bold;2"
        ;;
    *)
        export HEIGHT="32px"
        export FONT0="JetBrainsMono Nerd Font:size=13:weight=bold;2"
        ;;
esac


# Color theme.
export BACKGROUND="#001F1F28"
export BACKGROUND_ALT="#2A2A37"
export FOREGROUND="#C8C4AA"

case $THEME in
    space)
        export PRIMARY="#43C5A5"
        ;;
    interstellar)
        export PRIMARY="#F97583" 
        ;;
    tloz)
        export PRIMARY="#2EA87E"
        ;;
    astronaut)
        export PRIMARY="#C8C4AA"
        ;;
    *)
        export PRIMARY="#7EB3C9"
esac

export SECONDARY="#8ABEB7"
export ALERT="#A54242"
export DISABLED="#707880"
