## First-Time Setup

Run the following command in the root of this repository:
```bash
make setup-mac
```

This will:
1.  Install homebrew and all the packages defined in each component's `setup/mac/install.sh` script.
2.  Create symlinks to dotfiles, as defined in each component's `setup/mac/symlink.sh` script.

## Modular Usage

This repository is structured in a modular way, allowing you to manage each component individually. Each component is located in the `src` directory.

### To install all components for macOS:
```bash
make install-mac
```

### To uninstall all components for macOS:
```bash
make uninstall-mac
```

### To symlink all components for macOS:
```bash/
make symlink-mac
```

### To manage individual components:

You can also run make commands for individual components by specifying the component's directory. For example, to install only `ghostty` for macOS:
```bash
make -C src/ghostty install-mac
```

## GitHub Copilot Authentication
2.  In Neovim, run:
    ```
    :Copilot auth
    ```
