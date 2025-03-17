#!/bin/bash
set -e  # Exit if any command fails

echo "???????????????????????????????"
echo "? Neovim Setup Script (macOS) ?"
echo "???????????????????????????????"

# Get the script's directory (assuming it's inside the repo)
REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
NVIM_CONFIG="$HOME/.config/nvim"
LAZY_PATH="$HOME/.local/share/nvim/lazy/lazy.nvim"

# Install Homebrew if missing
if ! command -v brew &>/dev/null; then
    echo "?? Homebrew not found. Installing..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    
    # Add Homebrew to PATH (if needed)
    if [[ "$(uname -m)" == "arm64" ]]; then
        echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
        eval "$(/opt/homebrew/bin/brew shellenv)"
    fi
else
    echo "? Homebrew already installed"
fi

# Install required packages if missing
echo "?? Checking dependencies..."
dependencies=("neovim" "git" "ripgrep" "fd" "lua" "node" "npm")

for pkg in "${dependencies[@]}"; do
    if ! brew list "$pkg" &>/dev/null; then
        echo "  Installing $pkg..."
        brew install "$pkg"
    else
        echo "  ? $pkg already installed"
    fi
done

# Install language servers via npm
echo "?? Installing language servers..."
lsp_servers=("typescript-language-server" "pyright" "html-languageserver" "vscode-langservers-extracted")

for server in "${lsp_servers[@]}"; do
    if ! command -v "$server" &>/dev/null; then
        echo "  Installing $server..."
        npm install -g "$server"
    else
        echo "  ? $server already installed"
    fi
done

# Backup existing Neovim config if it exists
if [[ -d "$NVIM_CONFIG" && ! -L "$NVIM_CONFIG" ]]; then
    echo "?? Existing Neovim config found. Backing up..."
    backup_name="$NVIM_CONFIG.bak.$(date +%Y%m%d%H%M%S)"
    mv "$NVIM_CONFIG" "$backup_name"
    echo "  Backup created at $backup_name"
elif [[ -L "$NVIM_CONFIG" ]]; then
    echo "?? Removing existing symlink..."
    rm "$NVIM_CONFIG"
fi

# Create directory structure if needed
mkdir -p "$(dirname "$NVIM_CONFIG")"

# Create symlink to the repo's nvim config
echo "?? Linking Neovim config..."
ln -sf "$REPO_DIR/nvim" "$NVIM_CONFIG"

# Install lazy.nvim if not already installed
if [[ ! -d "$LAZY_PATH" ]]; then
    echo "?? Installing lazy.nvim..."
    git clone --filter=blob:none --branch=stable https://github.com/folke/lazy.nvim.git "$LAZY_PATH"
fi

# Install SauceCodePro Nerd Font if not already installed
if ! fc-list | grep -i "SauceCodePro" &>/dev/null; then
    echo "?? Installing SauceCodePro Nerd Font..."
    brew tap homebrew/cask-fonts
    brew install --cask font-sauce-code-pro-nerd-font
fi

echo "? Neovim setup complete!"
echo "?? Launch Neovim by typing 'nvim' to automatically install plugins"
