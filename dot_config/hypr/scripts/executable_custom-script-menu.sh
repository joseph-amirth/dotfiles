custom_scripts() {
    echo "kitty-session"
    echo "set-theme"
}

cmd=$(custom_scripts | rofi -dmenu)
$cmd
