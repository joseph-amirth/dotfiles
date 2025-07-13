#!/bin/bash

LOCK="  Lock"
SHUTDOWN="  Shutdown"
RESTART="  Restart"
LOGOUT="󰗼  Log out"
QUIT="  Quit Hyprland"

ACTIONS="$LOCK\n$SHUTDOWN\n$RESTART\n$LOGOUT\n$QUIT"

ACTION=$(echo -ne "$ACTIONS" | rofi -config power-menu.rasi -dmenu -i)

case $ACTION in
    $LOCK)
        loginctl lock-session
        ;;
    $SHUTDOWN)
        shutdown -h now
        ;;
    $RESTART)
        reboot
        ;;
    $LOGOUT)
        loginctl kill-user $(whoami)
        ;;
    $QUIT)
        hyprctl dispatch exit
        ;;
    "")
        ;;
    *)
        rofi -config power-menu.rasi -e "Invalid action \"$ACTION\""
        ;;
esac
