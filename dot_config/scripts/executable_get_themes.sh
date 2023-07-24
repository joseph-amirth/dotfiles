#!/bin/bash

for FILE in ~/.config/bspwm/assets/*.png; do
    FILE=${FILE#"$(realpath ~/.config/bspwm/assets/)/"}
    FILE=${FILE%".png"}
    echo $FILE
done
