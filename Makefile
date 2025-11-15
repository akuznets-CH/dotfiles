.PHONY: all setup-mac symlink-mac uninstall-mac install-mac help

COMPONENTS = $(wildcard src/*)

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
	-@for component in $(COMPONENTS); do \
		$(MAKE) -C $$component install-mac; \
	done

uninstall-mac:
	-@for component in $(COMPONENTS); do \
		$(MAKE) -C $$component uninstall-mac; \
	done

symlink-mac:
	-@for component in $(COMPONENTS); do \
		$(MAKE) -C $$component symlink-mac; \
	done
