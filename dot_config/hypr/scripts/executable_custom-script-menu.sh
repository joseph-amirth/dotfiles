source _custom-script-util

custom_scripts() {
    echo "kitty-session"
    echo "set-theme"
}

cmd=$(custom_scripts | rofi -dmenu)
if [[ $cmd ]]; then
    infoln "Executing: $cmd"
    $cmd
else
    errorln "Invalid command"
fi
