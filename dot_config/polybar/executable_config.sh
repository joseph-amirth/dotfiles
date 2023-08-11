#!/bin/bash

THEME=$1
WIDTH=$2
HEIGHT=$3

# Bar config.
export WIDTH="$(($WIDTH - 14))px"

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
