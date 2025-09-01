.PHONY: all help install lint format

all: help

help:
	@echo "Available commands:"
	@echo "  install - Installs dependencies (nvim, luacheck, stylua) using homebrew."
	@echo "  lint    - Lints Lua files using luacheck."
	@echo "  format  - Formats Lua files using stylua."

install:
	@echo "Checking for Homebrew..."
	@if ! command -v brew &> /dev/null; then \
		echo "Homebrew not found. Installing Homebrew..."; \
		/bin/bash -c "$$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"; \
		eval "$$(/opt/homebrew/bin/brew shellenv)"; \
		else \
		echo "Homebrew is already installed."; \
		fi
	@echo "Installing nvim, luacheck, and stylua..."
	@brew install nvim luacheck stylua

lint:
	@echo "Linting with luacheck..."
	@luacheck .
	@echo "Done!"

TEXT_FILES := $(shell find . -type f -not -path "./.git/*" -exec sh -c 'file -b --mime-type "$$0" | grep -q "^text" && echo "$$0"' {} \;)


format:
	@echo "Formatting with stylua..."
	@stylua .
	@echo "Adding trailing newline to text files..."
	@for file in $(TEXT_FILES); do \
		if [ -f "$file" ]; then \
		if [ -n "$(tail -c 1 "$file")" ]; then \
		echo "" >> "$file"; \
		fi; \
		fi; \
		done
	@echo "Done!"
