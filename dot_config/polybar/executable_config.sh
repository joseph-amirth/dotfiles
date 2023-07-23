#!/bin/bash

export BACKGROUND="#001F1F28"
export BACKGROUND_ALT="#2A2A37"
export FOREGROUND="#C8C4AA"

case $1 in
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

# [module/date]
export DATE_LABEL="%date%"
export DATE_FORMAT_PREFIX="%{F${FOREGROUND}}  %{F-}"
export DATE_FORMAT="${DATE_FORMAT_PREFIX}<label>"
