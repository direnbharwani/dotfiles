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

| Package        | Description                        | OS                  | Remarks                                                                                        |
| -------------- | ---------------------------------- | ------------------- | ---------------------------------------------------------------------------------------------- |
| **aerospace**  | Tiling window manager              | MacOS               | Some apps are specific (iTerm2, Things etc.)                                                   |
| **borders**    | Window border enhancement tool     | MacOS               |                                                                                                |
| **nvim**       | Neovim configuration and plugins   | Windows/MacOS/Linux | This is very opinionated (duh!)                                                                |
| **oh-my-posh** | Cross-shell prompt customization   | Windows/MacOS/Linux | Alternative prompt to Starship. Minimalist look.                                               |
| **tmux**       | Terminal multiplexer configuration | Windows/MacOS/Linux | Same as above. [tpm](https://github.com/tmux-plugins/tpm) is a submodule.                      |
| **vim**        | Vi/Vim editor settings and plugins | Windows/MacOS/Linux |                                                                                                |
| **zsh**        | Z shell configuration and themes   | Windows/MacOS/Linux | Uses zinit, includes git aliases and integration for various [plugins](./zsh/.zsh/plugins.zsh) |

> [!NOTE]
> To get tmux plugins to install:
>
> 1. Start a tmux instance
> ```bash
> tmux new
> ```
> 2. Press `prefix + I` (default prefix is `<Ctrl + Space>`)

## Future Plans

- [ ] Cross-platform Package Installer
  - [ ] CLI
  - [ ] TUI?
