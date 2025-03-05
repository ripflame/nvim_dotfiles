#!/bin/bash

set -e  # Exit immediately if a command fails

echo "Starting Neovim setup for macOS..."

# Install Homebrew if not installed
if ! command -v brew &>/dev/null; then
    echo "Homebrew not found. Installing..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
else
    echo "Homebrew is already installed."
fi

# Install dependencies
echo "Installing dependencies..."
brew install neovim git ripgrep fd lua

# Set up Neovim config
echo "Setting up Neovim configuration..."
if [[ -d "$HOME/.config/nvim" ]]; then
    echo "Existing Neovim config found. Backing up..."
    mv "$HOME/.config/nvim" "$HOME/.config/nvim.bak"
fi

# Clone config and create symlink
git clone https://github.com/ripflame/nvim_dotfiles.git "$HOME/.nvim-setup"
ln -s "$HOME/.nvim-setup/nvim" "$HOME/.config/nvim"

# Ensure lazy.nvim is installed
echo "Installing lazy.nvim..."
LZ_PATH="$HOME/.local/share/nvim/lazy/lazy.nvim"
if [[ ! -d "$LZ_PATH" ]]; then
    git clone --depth 1 https://github.com/folke/lazy.nvim.git "$LZ_PATH"
fi

echo "Neovim setup complete!"
