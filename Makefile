.PHONY: all setup-mac symlink delete-symlinks brew-install help

all: help

help:
	@echo "Available commands:"
	@echo "  make setup-mac       - Runs delete-symlinks, brew-install, and symlink in order."
	@echo "  make symlink         - Creates symlinks for dotfiles."
	@echo "  make delete-symlinks - Deletes existing symlinks and files/folders created by symlink.sh."
	@echo "  make brew-install    - Installs nvim, ghostty, and tmux using Homebrew."

setup-mac: delete-symlinks brew-install symlink
	@echo "All setup tasks completed."

symlink:
	@echo "Running symlink script..."
	./scripts/symlink.sh

delete-symlinks:
	@echo "Running delete symlinks script..."
	./scripts/delete-symlinks.sh

brew-install:
	@echo "Running brew install script..."
	./scripts/brew-install.sh
