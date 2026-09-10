#!/bin/bash

session=$(basename "$PWD")

if [[ -z "$TMUX" ]]; then
    exec tmux new-session -s "$session"
fi

tmux new-session -d -s "$session" || exit 1
exec tmux switch-client -t "$session"
