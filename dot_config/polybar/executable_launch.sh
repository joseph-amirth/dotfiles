#!/bin/bash

killall -q polybar

source ~/.config/polybar/config.sh "$@"

polybar main 2>&1 | tee -a /tmp/polybar.log & disown

echo "Polybar launched..."
