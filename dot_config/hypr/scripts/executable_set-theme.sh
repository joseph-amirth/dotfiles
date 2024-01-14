#!/bin/bash

theme=$1

inject_color() {
    key=$1
    file=$2
    value=$(cat ~/.config/hypr/themes/$theme/color.json | jq -r .$1)
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
    exp="s/\{\{theme\}\}/$theme/"
    sed -i -r "$exp" "$file"

    # Set wallpaper.
    hyprctl hyprpaper preload "~/.config/hypr/themes/$theme/wallpaper.png"
    hyprctl hyprpaper wallpaper "HDMI-A-2,~/.config/hypr/themes/$theme/wallpaper.png"
}

set_waybar_theme >/dev/null 2>&1
set_wallpaper >/dev/null 2>&1
