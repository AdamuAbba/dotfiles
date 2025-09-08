# Neovim Configuration

This repository contains my personal Neovim configuration.

## Overview

This setup leverages **LazyVim** for efficient plugin management and a streamlined configuration experience.

## Structure

- **`init.lua`**: The entry point of the configuration, responsible for loading LazyVim and other essential settings.
- **`lua/config/lazy.lua`**: This file is  where my LazyVim plugin specifications and their configurations reside.
- **`lazy-lock.json`**: Managed by LazyVim, this file locks the versions of your plugins.
- **`lazyvim.json`**: Contains LazyVim-specific settings.
- **`stylua.toml`**: Configuration for `stylua`, a Lua formatter.
- **`snippets/`**: Contains various snippets for different file types.
- **`templates/`**: Holds templates for new files.

## Getting Started

shit you should do

LazyVim will automatically install the necessary plugins on the first launch.

## Customization

You can customize this Neovim setup by modifying the Lua files in the `lua` directory. For LazyVim-specific customizations, refer to the [LazyVim documentation](https://www.lazyvim.org/)।

---

**Note**: This README is a general overview i quickly generated with AI as a placeholder (feeling too lazy to make this robust for now). For detailed information on specific plugins or custom configurations, please refer to `lua/plugins/<dir>/<plugin-name>.lua` files or the official documentation of the respective plugins.
