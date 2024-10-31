#!/bin/bash

source _custom-script-util

THEMES_DIR=~/.config/hypr/themes
THEMES=$(basename --multiple $(find $THEMES_DIR -type d -not -wholename $THEMES_DIR ))

THEME=$1
if [[ -z $THEME ]]; then
    THEME=$(echo "$THEMES" | fzf)
fi

if grep "^$THEME$" <<< "$THEMES" > /dev/null; then
    true
else
    fatalln "Invalid theme."
fi

COLORS_JSON=$(cat ~/.config/hypr/themes/$THEME/color.json)
BG=$(echo $COLORS_JSON | jq -r .bg)
BG_ALT=$(echo $COLORS_JSON | jq -r .bg_alt)
FG=$(echo $COLORS_JSON | jq -r .fg)
PRIMARY=$(echo $COLORS_JSON | jq -r .primary)
SECONDARY=$(echo $COLORS_JSON | jq -r .secondary)
ACTIVE=$(echo $COLORS_JSON | jq -r .active)
DISABLED=$(echo $COLORS_JSON | jq -r .disabled)

set_waybar_theme() {
    sed -i \
        -e "s/@define-color bg .*/@define-color bg $BG;/" \
        -e "s/@define-color bg-alt .*/@define-color bg-alt $BG_ALT;/" \
        -e "s/@define-color fg .*/@define-color fg $FG;/" \
        -e "s/@define-color primary .*/@define-color primary $PRIMARY;/" \
        -e "s/@define-color secondary .*/@define-color secondary $SECONDARY;/" \
        -e "s/@define-color active .*/@define-color active $ACTIVE;/" \
        -e "s/@define-color disabled .*/@define-color disabled $DISABLED;/" \
        ~/.config/waybar/style.css

    killall waybar
    waybar &!
}

set_rofi_theme() {
    sed -i \
        -e "s/bg: .*;/bg: $BG;/" \
        -e "s/bg-alt: .*;/bg-alt: $BG_ALT;/" \
        -e "s/fg: .*;/fg: $FG;/" \
        -e "s/primary: .*;/primary: $PRIMARY;/" \
        -e "s/secondary: .*;/secondary: $SECONDARY;/" \
        -e "s/active: .*;/active: $ACTIVE;/" \
        -e "s/disabled: .*;/disabled: $DISABLED;/" \
        ~/.config/rofi/config.rasi
}

set_wallpaper() {
    IMG=~/.config/hypr/themes/$THEME/wallpaper.png
    hyprctl hyprpaper preload $IMG
    hyprctl hyprpaper wallpaper "HDMI-A-2,$IMG"

    sed -i \
        -e "s/themes\/.*\//themes\/$THEME\//" \
        ~/.config/hypr/hyprpaper.conf
}

echo -n $THEME > ~/.theme

set_waybar_theme >/dev/null 2>&1
set_rofi_theme >/dev/null 2>&1
set_wallpaper >/dev/null 2>&1
