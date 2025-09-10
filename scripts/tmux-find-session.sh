#!/bin/bash

# Find the session to attach to using fzf
# If the user presses Esc, fzf exits with a non-zero status code,
# and the script will exit thanks to `set -e`.
set -e
session=$(tmux list-sessions -F '#S' | fzf --reverse)

# If we're not already in a tmux session, attach to the selected session.
# Otherwise, switch to it.
if [[ -z "$TMUX" ]]; then
    tmux attach-session -t "$session"
else
    tmux switch-client -t "$session"
fi
