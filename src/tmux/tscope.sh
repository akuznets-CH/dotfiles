#!/bin/bash

sessions=$(tmux list-sessions -F '#S' 2>/dev/null || true)

session=$(echo "$sessions" | fzf --reverse \
    --header 'Choose session (Ctrl-X to kill)' \
    --bind 'ctrl-x:execute(tmux kill-session -t {})+reload(tmux list-sessions -F "#S" || true)' \
    --prompt="> ")

if [[ -z "$session" ]]; then
    exit 0
fi

if ! tmux has-session -t "$session" 2>/dev/null; then
    if [[ -z "$TMUX" ]]; then
        tmux new-session -s "$session"
    else
        tmux new-session -d -s "$session"
        tmux switch-client -t "$session"
    fi
else
    if [[ -z "$TMUX" ]]; then
        tmux attach-session -t "$session"
    else
        tmux switch-client -t "$session"
    fi
fi
