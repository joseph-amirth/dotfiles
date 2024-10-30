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

inject_color() {
    key=$1
    file=$2
    value=$(cat ~/.config/hypr/themes/$THEME/color.json | jq -r .$1)
    exp="s/\{\{$key\}\}/$value/"
    sed -i -r "$exp" "$file"
}

set_waybar_theme() {
    # Generate style.css from style.css.tmpl.
    template=~/.config/waybar/style.css.tmpl
    file=~/.config/waybar/style.css
    cp -f "$template" "$file"
    inject_color bg "$file"
    inject_color bg_alt "$file"
    inject_color primary "$file"

    # Restart waybar.
    killall waybar
    waybar &!
}

set_wallpaper() {
    # Generate hyprpaper.conf from hyprpaper.conf.tmpl.
    template=~/.config/hypr/hyprpaper.conf.tmpl
    file=~/.config/hypr/hyprpaper.conf
    cp -f "$template" "$file"
    exp="s/\{\{theme\}\}/$THEME/"
    sed -i -r "$exp" "$file"

    # Set wallpaper.
    hyprctl hyprpaper preload "~/.config/hypr/themes/$THEME/wallpaper.png"
    hyprctl hyprpaper wallpaper "HDMI-A-2,~/.config/hypr/themes/$THEME/wallpaper.png"
    ln -sf ~/.config/hypr/themes/$THEME/wallpaper.png ~/.theme/wallpaper
}

[[ ! -d ~/.theme ]] && mkdir ~/.theme

set_waybar_theme >/dev/null 2>&1
set_wallpaper >/dev/null 2>&1
echo -n $THEME > ~/.theme/name
