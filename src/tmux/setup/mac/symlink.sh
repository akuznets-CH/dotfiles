#!/bin/bash
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && cd ../../.. && pwd )"
mkdir -p "$HOME/.local/bin"
ln -sfnv "$DIR/src/tmux/.tmux.conf" "$HOME/.tmux.conf"
ln -sfnv "$DIR/src/tmux/tscope.sh" "$HOME/.local/bin/tscope"
