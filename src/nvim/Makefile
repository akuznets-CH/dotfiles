.PHONY: all help install-mac uninstall-mac symlink-mac lint format

all: help

help:
	@echo "Available commands:"
	@echo "  install-mac - Installs dependencies (nvim, luacheck, stylua) using homebrew."
	@echo "  uninstall-mac - Uninstalls nvim."
	@echo "  symlink-mac - Creates symlinks for nvim."
	@echo "  lint    - Lints Lua files using luacheck."
	@echo "  format  - Formats Lua files using stylua."

install-mac:
	@echo "Installing nvim..."
	@bash setup/mac/install.sh
	@echo "Checking for Homebrew..."
	@if ! command -v brew &> /dev/null; then \
		echo "Homebrew not found. Installing Homebrew..."; \
		/bin/bash -c "$$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"; \
		eval "$$(/opt/homebrew/bin/brew shellenv)"; \
		else \
		echo "Homebrew is already installed."; \
		fi
	echo "Installing luacheck and stylua"
	@brew install luacheck stylua

uninstall-mac:
	@echo "Uninstalling nvim..."
	@bash setup/mac/uninstall.sh

symlink-mac:
	@echo "Symlinking nvim..."
	@bash setup/mac/symlink.sh

lint:
	@echo "Linting with luacheck."
	@luacheck .
	@echo "Done."

TEXT_FILES := $(shell find . -type f -not -path "./.git/*" -exec sh -c 'file -b --mime-type "$$0" | grep -q "^text" && echo "$$0"' {} \;)


format:
	@echo "Formatting with stylua."
	@stylua .
	@echo "Adding trailing newline to text files."
	@for file in $(TEXT_FILES); do \
		if [ -n "$(tail -c 1 \"$$file\")" ]; then \
			echo "" >> \"$$file\"; \
		fi; \
	done
	@echo "Done."
