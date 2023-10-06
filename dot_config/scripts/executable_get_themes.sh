#!/bin/bash

echo "$(basename --multiple --suffix=".png" $(find ~/.config/bspwm/assets/*.png -type f))"
