#!/bin/bash

set -e  # Exit if any command fails

echo "Starting Neovim setup for macOS..."

# Get the script's directory (assuming it's inside the repo)
REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
NVIM_CONFIG="$HOME/.config/nvim"
LAZY_PATH="$HOME/.local/share/nvim/lazy/lazy.nvim"

# Install Homebrew if missing
if ! command -v brew &>/dev/null; then
    echo "Homebrew not found. Installing..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# Install required packages if missing
echo "Checking dependencies..."
brew list neovim &>/dev/null || brew install neovim
brew list git &>/dev/null || brew install git
brew list ripgrep &>/dev/null || brew install ripgrep
brew list fd &>/dev/null || brew install fd
brew list lua &>/dev/null || brew install lua

# Backup existing Neovim config if it exists
if [[ -d "$NVIM_CONFIG" || -L "$NVIM_CONFIG" ]]; then
    echo "Existing Neovim config found. Backing up..."
    mv "$NVIM_CONFIG" "$NVIM_CONFIG.bak"
fi

# Create symlink to the repo's nvim config
echo "Linking Neovim config..."
ln -s "$REPO_DIR/nvim" "$NVIM_CONFIG"

# Install lazy.nvim if not already installed
if [[ ! -d "$LAZY_PATH" ]]; then
    echo "Installing lazy.nvim..."
    git clone --depth 1 https://github.com/folke/lazy.nvim.git "$LAZY_PATH"
fi

echo "Neovim setup complete!"
