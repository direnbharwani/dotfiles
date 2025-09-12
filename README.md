# Diren's Dotfiles

Personal configuration files and settings.

> [!WARNING]
> This has only been tested on MacOS & Arch Linux

## Installation

```bash
git clone --recurse-submodules https://github.com/direnbharwani/dotfiles.git
cd dotfiles
chmod +x install.sh && ./install.sh
```

## Packages

Common

| Package        | Description                        | Remarks                                                                                        |
| -------------- | ---------------------------------- | ---------------------------------------------------------------------------------------------- |
| **zsh**        | Z shell configuration and themes   | Uses zinit, includes git aliases and integration for various [plugins](./zsh/.zsh/plugins.zsh) |
| **vim**        | Vi/Vim editor settings and plugins |                                                                                                |
| **nvim**       | Neovim configuration and plugins   | This is very opinionated (duh!)                                                                |
| **tmux**       | Terminal multiplexer configuration | Same as above. [tpm](https://github.com/tmux-plugins/tpm) is a submodule.                      |
| **oh-my-posh** | Cross-shell prompt customization   | Alternative prompt to Starship. Minimalist look.                                               |

> [!NOTE]
> To get tmux plugins to install:
>
> 1. Start a tmux instance
> 2. Press `prefix + I` (default prefix is `<Ctrl + Space>`)

MacOS Specific
| Package | Description |
| ------------- | ------------------------------------------- |
| **aerospace** | Tiling window manager |
| **borders** | Window border enhancement tool |

## Future Plans

- [ ] Cross-platform Package Installer
  - [ ] CLI
  - [ ] TUI?
