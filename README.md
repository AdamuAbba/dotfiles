![dotfiles](./demo/dotfiles.png)

# shytype's dotfiles

**Disclaimer**: I have mostly stolen and adapted configurations from various sources (some credited in code comments), including GitHub repositories, AI generated code, Reddit posts, and my imaginary girlfriend **Shylina**. I do not claim ownership of the original configurations or ideas. Steal as much as you want, baby it's open source

## Table of Contents

- [Contents](#contents)
- [Theme](#theme)
- [Neovim Setup](#neovim-setup)
  - [Requirements](#requirements)
  - [Notable Plugins](#notable-plugins)
- [Shell Setup (macOS & Linux)](#shell-setup-macos--linux)
- [Terminal Emulators](#terminal-emulators)
- [Terminal Multiplexers](#terminal-multiplexers)
  - [Tmux Plugins](#tmux-plugins)
- [Window Managers](#window-managers)
- [File Managers](#file-managers)
- [Status Bars](#status-bars)
- [Git Setup](#git-setup)
- [Search & Navigation](#search--navigation)
- [System Monitoring](#system-monitoring)
- [Other Tools](#other-tools)
- [Installation](#installation)
  - [Prerequisites](#prerequisites)
  - [Setup](#setup)
- [Directory Structure](#directory-structure)
- [Platform Support](#platform-support)
- [Important shit](#important-shit)

## Contents

- Neovim config (LazyVim-based)
- Tmux & Zellij configs
- Zsh config with Oh-My-Zsh
- Git config with delta
- Multiple terminal emulators (Ghostty, Kitty, WezTerm)
- Window managers (AeroSpace for macOS, i3 for Linux)
- File managers (Yazi, Superfile)
- And 30+ other CLI tools

## Theme

The entire setup uses the **Dracula** color scheme consistently across all tools, with a preference for pure black backgrounds and JetBrainsMono/Iosevka Nerd Fonts.

## Neovim Setup

### Requirements

- Neovim >= **0.9.0** (needs to be built with **LuaJIT**)
- Git >= **2.19.0** (for partial clones support)
- [LazyVim](https://www.lazyvim.org/)
- A [Nerd Font](https://www.nerdfonts.com/) (v3.0 or greater) **_(optional, but needed to display some icons)_**
- A **C** compiler for `nvim-treesitter`. See [here](https://github.com/nvim-treesitter/nvim-treesitter#requirements)
- For [telescope.nvim](https://github.com/nvim-telescope/telescope.nvim) **_(optional)_**:
  - **live grep**: [ripgrep](https://github.com/BurntSushi/ripgrep)
  - **find files**: [fd](https://github.com/sharkdp/fd)
- A terminal that supports true color and _undercurl_:
  - [Ghostty](https://github.com/mitchellh/ghostty) **_(macOS & Linux)_**
  - [Kitty](https://github.com/kovidgoyal/kitty) **_(macOS & Linux)_**
  - [WezTerm](https://github.com/wez/wezterm) **_(macOS, Linux & Windows)_**

### Notable Plugins

- **AI**: GitHub Copilot, OpenCode
- **UI**: bufferline, lualine, noice, smear-cursor, snacks-nvim
- **Coding**: blink-cmp, LuaSnip, nvim-treesitter, markdown-preview
- **LSP**: Mason for LSP server management
- **Themes**: Dracula (My Modified version)

## Shell Setup (macOS & Linux)

- [Zsh](https://www.zsh.org/) - Extended Bourne shell
- [Oh-My-Zsh](https://ohmyz.sh/) - Framework for managing zsh configuration
- [Starship](https://starship.rs/) - Cross-shell prompt with Dracula theme
- [Nerd Fonts](https://github.com/ryanoasis/nerd-fonts) - I use JetBrainsMono and Iosevka
- [zoxide](https://github.com/ajeetdsouza/zoxide) - Smarter cd command
- [eza](https://github.com/eza-community/eza) - Modern `ls` replacement
- [fzf](https://github.com/junegunn/fzf) - Command-line fuzzy finder
- [Atuin](https://github.com/atuinsh/atuin) - Magical shell history with sync

## Terminal Emulators

| Tool | Platform | Description |
|------|----------|-------------|
| [Ghostty](https://github.com/mitchellh/ghostty) | macOS, Linux | GPU-accelerated, Iosevka NF font |
| [Kitty](https://github.com/kovidgoyal/kitty) | macOS, Linux | Fast, GPU-based with cursor trail |
| [WezTerm](https://github.com/wez/wezterm) | Cross-platform | Lua config, JetBrainsMono font |

## Terminal Multiplexers

| Tool | Description |
|------|-------------|
| [Tmux](https://github.com/tmux/tmux) | Classic multiplexer with custom Dracula theme, prefix `Ctrl+g` |
| [Zellij](https://github.com/zellij-org/zellij) | Modern multiplexer with built-in layouts |

### Tmux Plugins

- tpm, tmux-sensible, tmux-battery, tmux-yank
- tmux-cpu, tmux-net-speed, tmux-pane-control
- tmux-fzf, vim-tmux-navigator, tmux-nerd-font-window-name

## Window Managers

| Tool | Platform | Description |
|------|----------|-------------|
| [AeroSpace](https://github.com/nikitabobko/AeroSpace) | macOS | Tiling WM with named workspaces |
| [i3](https://i3wm.org/) | Linux | Tiling WM with Dracula theme, vim-style navigation |

## File Managers

| Tool | Description |
|------|-------------|
| [Yazi](https://github.com/sxyazi/yazi) | Blazing fast, Rust-based with rich previews |
| [Superfile](https://github.com/MHNightCat/superfile) | Modern TUI with image preview support |

## Status Bars

| Tool | Platform | Description |
|------|----------|-------------|
| [Sketchybar](https://github.com/FelixKratz/SketchyBar) | macOS | Highly customizable bar replacement |
| [Polybar](https://github.com/polybar/polybar) | Linux | X11 status bar with multiple themes |

## Git Setup

- [Git](https://git-scm.com/) with GPG commit signing
- [Delta](https://github.com/dandavison/delta) - Syntax-highlighting pager with side-by-side view
- Neovim as default editor and diff tool

## Search & Navigation

| Tool | Description |
|------|-------------|
| [fzf](https://github.com/junegunn/fzf) | Fuzzy finder with fd integration |
| [ripgrep](https://github.com/BurntSushi/ripgrep) | Fast line-oriented search |
| [fd](https://github.com/sharkdp/fd) | Fast alternative to find |
| [zoxide](https://github.com/ajeetdsouza/zoxide) | Smarter cd that learns your habits |
| [eza](https://github.com/eza-community/eza) | Modern ls with icons and colors |

## System Monitoring

| Tool | Description |
|------|-------------|
| [btop](https://github.com/aristocratos/btop) | Resource monitor (CPU, memory, disks, network) |
| [oxker](https://github.com/mrjackwills/oxker) | Docker container management TUI |

## Other Tools

| Tool | Description |
|------|-------------|
| [Helix](https://helix-editor.com/) | Modal text editor with Dracula theme |
| [bat](https://github.com/sharkdp/bat) | `cat` with syntax highlighting |
| [Sesh](https://github.com/joshmedeski/sesh) | Tmux session manager |
| [ncspot](https://github.com/hrkfdn/ncspot) | Terminal Spotify client |
| [fastfetch](https://github.com/fastfetch-cli/fastfetch) | System information tool |
| [presenterm](https://github.com/mfontanini/presenterm) | Terminal presentations |
| [ATAC](https://github.com/Julien-cpsn/ATAC) | Terminal API client |
| [jqp](https://github.com/noahgorstein/jqp) | Interactive jq playground |

## Installation

### Prerequisites

- macOS or Linux
- An image of my dear Shylina (optional, but highly recommended)
- [Homebrew](https://brew.sh/) (for macOS)
- Git

### Setup

1. Clone this repository:

```bash
git clone https://github.com/AdamuAbba/dotfiles.git ~/dotfiles
cd ~/dotfiles
```

2. Create symlinks:

```bash
bash scripts/utils/symlinks.sh --create
```

3. Install Homebrew packages (macOS):

```bash
# Check homebrew/ directory for Brewfile {outdated}
brew bundle --file=homebrew/Brewfile
```

## Directory Structure

```
dotfiles/
├── aerospace/       # AeroSpace WM config (macOS)
├── atuin/           # Shell history config
├── btop/            # System monitor config
├── ghostty/         # Ghostty terminal config
├── git/             # Git configuration
├── helix/           # Helix editor config
├── homebrew/        # Brewfile and related configs
├── i3/              # i3 WM config (Linux)
├── karabiner/       # Keyboard customization (macOS)
├── kitty/           # Kitty terminal config
├── nvim/            # Neovim configuration
├── opencode/        # OpenCode AI assistant config
├── polybar/         # Polybar themes (Linux)
├── rofi/            # Application launcher (Linux)
├── scripts/         # Utility scripts
├── sesh/            # Tmux session manager config
├── sketchybar/      # Status bar config (macOS)
├── starship/        # Starship prompt config
├── superfile/       # Superfile file manager config
├── tmux/            # Tmux configuration
├── wezterm/         # WezTerm terminal config
├── yazi/            # Yazi file manager config
├── zellij/          # Zellij multiplexer config
├── zsh/             # Zsh configuration
└── zshrc-config/    # Modular zsh configs
```

## Platform Support

| Feature | macOS | Linux |
|---------|-------|-------|
| Shell (Zsh + Oh-My-Zsh) | Yes | Yes |
| Neovim | Yes | Yes |
| Tmux/Zellij | Yes | Yes |
| Ghostty/Kitty/WezTerm | Yes | Yes |
| Window Manager | AeroSpace | i3 |
| Status Bar | Sketchybar | Polybar |
| Compositor | - | Picom |
| Notifications | - | Dunst |
| App Launcher | - | Rofi |
| Keyboard | Karabiner | sxhkd |

## Important shit

For the past couple of years I have been daily driving macOS due to react-native development, but I have been using Linux for a while (Arch btw) and I will be switching back to it in the near future. So yeah There may be some platform-specific features or tools that only work on macOS.
