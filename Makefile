.PHONY: all setup-mac symlink delete-symlinks brew-install help

all: help

help:
	@echo "Available commands:"
	@echo "  make setup-mac         # Run full mac setup (brew, symlinks)"
	@echo "  make symlink           # Create all dotfile symlinks"
	@echo "  make delete-symlinks   # Delete all dotfile symlinks"
	@echo "  make brew-install      # Install homebrew packages"


setup-mac: brew-install symlink
	@echo "Mac setup complete."

symlink:
	bash ./setup/mac/symlink.sh

delete-symlinks:
	bash ./setup/mac/symlink.sh --delete

brew-install:
	bash ./setup/mac/homebrew.sh

