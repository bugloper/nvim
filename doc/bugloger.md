# Neovim Configuration Structure

This document explains the purpose and organization of the Neovim configuration files.

## Directory Structure

### Core Configuration (`lua/core/`)
- `autocmds.lua`: Contains autocommands (automatic actions triggered by events)
- `keymaps.lua`: Basic key mappings and leader key configuration
- `lazy.lua`: Bootstrap and configuration for the lazy.nvim plugin manager
- `options.lua`: Basic Neovim settings (line numbers, indentation, UI options, etc.)

### Custom Configuration (`lua/custom/`)
- `plugins/init.lua`: Your personal plugin configurations and additions

### bugloper Configuration (`lua/bugloper/`)
- `health.lua`: Health checks for your Neovim configuration
- `plugins/`: Default plugin configurations from bugloper.nvim
  - `autopairs.lua`: Auto-pairing brackets, quotes, etc.
  - `debug.lua`: Debugging configurations
  - `gitsigns.lua`: Git integration signs and features
  - `indent_line.lua`: Indentation guides
  - `lint.lua`: Code linting configurations
  - `neo-tree.lua`: File explorer configurations

### Main Plugin Configuration (`lua/plugins/`)
- `completion.lua`: Autocompletion setup (nvim-cmp)
- `init.lua`: Basic plugin definitions
- `lsp.lua`: Language Server Protocol configurations
- `telescope.lua`: Fuzzy finder configurations

### Empty/Unused Directories
- `lua/keymaps`: Empty directory (can be removed, as keymaps are in core/)
- `lua/options`: Empty directory (can be removed, as options are in core/)

## Structure Overview

The configuration follows a modular approach:

1. `core/` contains essential Neovim configurations
2. `custom/` is for your personal additions
3. `bugloper/` contains default configurations from bugloper.nvim
4. `plugins/` holds main plugin configurations
