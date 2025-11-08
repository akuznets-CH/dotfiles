.PHONY: all setup-mac symlink delete-symlinks brew-install help

all: help

help:
	@echo "Available commands:"
	@echo "  make setup-mac         # Run full mac setup (brew, symlinks)"

setup-mac: brew-install symlink
	bash ./setup/mac/homebrew.sh
	bash ./setup/mac/symlink.sh
	@echo "Mac setup complete."
