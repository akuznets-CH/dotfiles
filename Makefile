.PHONY: all setup-mac symlink-mac uninstall-mac install-mac help

all: setup-mac

help:
	@echo "Available commands:"
	@echo "  make setup-mac         # Run full mac setup (brew, symlinks)"
	@echo "  make install-mac       # Install all components for mac"
	@echo "  make uninstall-mac     # Uninstall all components for mac"
	@echo "  make symlink-mac       # Symlink all components for mac"

setup-mac: install-mac symlink-mac
	@echo "Mac setup complete."

install-mac:
	@brew install tmux fzf nvim ghostty

uninstall-mac:
	@brew uninstall tmux fzf nvim ghostty

symlink-mac:
	@mkdir -p "$(HOME)/.config"
	@mkdir -p "$(HOME)/.local/bin"
	@mkdir -p "@(HOME)/Library/Application Support/lazygit"

	@ln -sfnv "$(PWD)/src/ghostty/ghostty"    "$(HOME)/.config/ghostty"
	@ln -sfnv "$(PWD)/src/nvim/nvim"          "$(HOME)/.config/nvim"
	@ln -sfnv "$(PWD)/src/tmux/.tmux.conf"    "$(HOME)/.tmux.conf"
	@ln -sfnv "$(PWD)/src/tmux/tscope.sh"     "$(HOME)/.local/bin/tscope"
	@ln -sfnv "$(PWD)/src/vim/.vimrc"         "$(HOME)/.vimrc"
	@ln -sfnv "$(PWD)/src/zsh/.zshrc"         "$(HOME)/.zshrc"
	@ln -sfnv "$(PWD)/src/lazygit/config.yml" "$(HOME)/Library/Application Support/lazygit/config.yml"
