#!/bin/bash

source _custom-script-util

SESSIONS_DIR=~/.config/kitty/sessions
SESSIONS=$(basename --multiple $(find $SESSIONS_DIR -type f))

SESSION=$1

if [[ -z $SESSION ]]; then
    SESSION=$(echo "$SESSIONS" | fzf)
fi

if grep "^$SESSION$" <<< "$SESSIONS" > /dev/null; then
    kitty --session "$SESSIONS_DIR/$SESSION" --detach
else
    fatalln "Invalid session name."
fi
