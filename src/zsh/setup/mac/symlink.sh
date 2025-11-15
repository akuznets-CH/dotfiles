#!/bin/bash
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && cd ../../.. && pwd )"
ln -sfnv "$DIR/src/zsh/.zshrc" "$HOME/.zshrc"
