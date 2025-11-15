#!/bin/bash
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && cd ../../.. && pwd )"
mkdir -p "$HOME/.config"
ln -sfnv "$DIR/src/nvim/nvim" "$HOME/.config/nvim"
