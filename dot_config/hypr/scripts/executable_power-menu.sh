#!/bin/bash

SHUTDOWN="  Shutdown"
LOCK="  Lock"
RESTART="  Restart"
LOGOUT="󰗼  Log out"

ACTIONS="$SHUTDOWN\n$LOCK\n$RESTART\n$LOGOUT"

ACTION=$(echo -ne "$ACTIONS" | rofi -config power-menu.rasi -dmenu -i)

case $ACTION in
    $SHUTDOWN)
        shutdown -h now
        ;;
    $LOCK)
        loginctl lock-session
        ;;
    $RESTART)
        reboot
        ;;
    $LOGOUT)
        loginctl kill-user $(whoami)
        ;;
    "")
        ;;
    *)
        rofi -config power-menu.rasi -e "Invalid action \"$ACTION\""
        ;;
esac
