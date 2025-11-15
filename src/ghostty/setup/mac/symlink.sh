#!/bin/bash
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && cd ../../.. && pwd )"
mkdir -p "$HOME/.config"
ln -sfnv "$DIR/src/ghostty/ghostty" "$HOME/.config/ghostty"
