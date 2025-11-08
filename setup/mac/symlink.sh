#!/bin/bash

# Determine the absolute path of the repository's root directory.
# This is done by finding the directory of the script itself ("${BASH_SOURCE[0]}"),
# then navigating two directories up from there.
# This approach ensures that the script works correctly even when run from an arbitrary location.
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && cd ../.. && pwd )"

# Use two indexed arrays for compatibility with older bash versions like the one on macOS.
SOURCES=(
    "src/ghostty/ghostty"
    "src/nvim/nvim"
    "src/tmux/.tmux.conf"
    "src/vim/.vimrc"
    "src/zsh/.zshrc"
    "src/tmux/tscope.sh"
)

DESTINATIONS=(
    "$HOME/.config/ghostty"
    "$HOME/.config/nvim"
    "$HOME/.tmux.conf"
    "$HOME/.vimrc"
    "$HOME/.zshrc"
    "$HOME/.local/bin/tscope"
)

delete_targets() {
    echo "The following symlinks, files, and directories will be deleted if they exist:"
    for target in "${DESTINATIONS[@]}"; do
        echo "  $target"
    done

    echo ""
    read -p "Are you sure? (y/N): " confirm
    if [[ ! "$confirm" =~ ^[yY]$ ]]; then
        echo "Aborting."
        exit 1
    fi

    echo ""

    for target in "${DESTINATIONS[@]}"; do
        if [ -L "$target" ]; then
            echo "Deleting symlink: $target"
            rm "$target"
        elif [ -d "$target" ]; then
            echo "Deleting directory: $target"
            rm -rf "$target"
        elif [ -f "$target" ]; then
            echo "Deleting file: $target"
            rm "$target"
        else
            echo "Target does not exist or is not a file, directory, or symlink: $target"
        fi
    done
}

create_symlinks() {
    echo ""
    echo "Creating new symlinks."

    # Ensure target directories exist
    mkdir -p "$HOME/.config"
    mkdir -p "$HOME/.local/bin"

    # Loop through the arrays by index.
    for i in "${!SOURCES[@]}"; do
        source="${SOURCES[$i]}"
        target="${DESTINATIONS[$i]}"
        source_path="$DIR/$source"

        # Use -sfnv for directories, -sfv for files
        if [ -d "$source_path" ]; then
            echo "Linking directory: $source_path -> $target"
            ln -sfnv "$source_path" "$target"
        else
            echo "Linking file: $source_path -> $target"
            ln -sfv "$source_path" "$target"
        fi
    done

    echo "Done."
}

if [[ "$1" == "--delete" ]]; then
    delete_targets
    echo "Deletion complete."
else
    delete_targets
    create_symlinks
fi
