.PHONY: all setup-mac symlink-mac install-mac help

all: setup-mac

help:
	@echo "Available commands:"
	@echo "  make setup-mac      # Run full mac setup (brew, symlinks)"
	@echo "  make install-mac    # Install all components for mac"
	@echo "  make symlink-mac    # Symlink all components for mac"

setup-mac: install-mac symlink-mac
	@echo "Mac setup complete."

install-mac:
	$(BREW_INSTALL_GUARD)
	@brew install tmux rg fzf nvim ghostty git

symlink-mac:
	@ln -sfnv "$(PWD)/src/zsh/.zshrc"         "$(HOME)/.zshrc"
	@ln -sfnv "$(PWD)/src/vim/.vimrc"         "$(HOME)/.vimrc"
	@ln -sfnv "$(PWD)/src/tmux/.tmux.conf"    "$(HOME)/.tmux.conf"

	@mkdir -p "$(HOME)/.config"
	@ln -sfnv "$(PWD)/src/nvim/nvim"          "$(HOME)/.config/nvim"
	@ln -sfnv "$(PWD)/src/ghostty/ghostty"    "$(HOME)/.config/ghostty"

	@mkdir -p "$(HOME)/.local/bin"
	@ln -sfnv "$(PWD)/src/tmux/tscope.sh"     "$(HOME)/.local/bin/tscope"

define BREW_INSTALL_GUARD
@command -v brew >/dev/null 2>&1 || ( \
	/bin/bash -c "$$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"; \
	exit 1; \
)
endef
