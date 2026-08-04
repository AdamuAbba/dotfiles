# shytype's dotfiles

![dotfiles](./demo/dotfiles.png)

**Disclaimer**: I have mostly stolen and adapted configurations from various
sources (some credited in code comments), including GitHub repositories, AI
generated code, Reddit posts, and my imaginary girlfriend **Shylina**. I do not
claim ownership of the original configurations or ideas. Steal as much as you
want, baby it's open source

## Table of Contents

- [Installation](#installation)
  - [Setup](#setup)

## Installation

### Setup

1. Clone this repository:

```bash
git clone https://github.com/AdamuAbba/dotfiles.git ~/dotfiles
cd ~/dotfiles
```

1. Create symlinks:

```bash
bash scripts/utils/symlinks.sh --create
```

1. Install Homebrew packages (macOS):

```bash
# Check homebrew/ directory for Brewfile {outdated}
brew bundle --file=homebrew/Brewfile
```

1. Enable git hooks (keeps `homebrew/Brewfile` in sync via a pre-commit hook):

```bash
git config core.hooksPath .githooks
```
