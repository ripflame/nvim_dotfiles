#!/bin/bash
set -e  # Exit if any command fails

echo " ---------------------------------"
echo "| Neovim Setup Script (WSL2)     |"
echo " ---------------------------------"

# Get the script's directory (assuming it's inside the repo)
REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
NVIM_CONFIG="$HOME/.config/nvim"
LAZY_PATH="$HOME/.local/share/nvim/lazy/lazy.nvim"

# Check if we're running in WSL2
if ! grep -qEi "(Microsoft|WSL)" /proc/version 2>/dev/null; then
    echo "⚠️  This script is designed for WSL2. Use install_mac.sh for macOS or install_windows.ps1 for Windows."
    exit 1
fi

echo "✓ Running in WSL2 environment"

# Update package list
echo "🔄 Updating package lists..."
sudo apt update

# Install required packages
echo "🔄 Installing dependencies..."
dependencies=("curl" "git" "build-essential" "cmake" "pkg-config" "libtool" "unzip" "gettext" "python3" "python3-pip" "nodejs" "npm" "ripgrep" "fd-find" "fzf")

for pkg in "${dependencies[@]}"; do
    if ! dpkg -l | grep -q "^ii  $pkg "; then
        echo "  Installing $pkg..."
        sudo apt install -y "$pkg"
    else
        echo "  ✓ $pkg already installed"
    fi
done

# Install Neovim from source (latest version for WSL2 compatibility)
echo "🔄 Installing latest Neovim..."
if ! command -v nvim &>/dev/null || [[ $(nvim --version | head -n1 | grep -o "v[0-9]\+\.[0-9]\+") < "v0.11" ]]; then
    echo "  Building Neovim from source for latest features..."
    cd /tmp
    if [[ -d "neovim" ]]; then
        rm -rf neovim
    fi
    git clone https://github.com/neovim/neovim.git
    cd neovim
    git checkout stable
    make CMAKE_BUILD_TYPE=RelWithDebInfo
    sudo make install
    cd "$REPO_DIR"
    echo "  ✓ Neovim installed successfully"
else
    echo "  ✓ Neovim already installed with compatible version"
fi

# Create symlink for fd (different name on Ubuntu)
if command -v fdfind &>/dev/null && ! command -v fd &>/dev/null; then
    echo "🔄 Creating fd symlink..."
    sudo ln -sf $(which fdfind) /usr/local/bin/fd
fi

# Install Nerd Font for WSL2
echo "🔄 Setting up SauceCodePro Nerd Font for WSL2..."
FONT_DIR="$HOME/.local/share/fonts"
mkdir -p "$FONT_DIR"

if [[ ! -f "$FONT_DIR/SauceCodeProNerdFont-Regular.ttf" ]]; then
    echo "  Downloading SauceCodePro Nerd Font..."
    cd /tmp
    curl -fLo "SauceCodePro.zip" https://github.com/ryanoasis/nerd-fonts/releases/download/v3.1.1/SourceCodePro.zip
    unzip -o SauceCodePro.zip -d SauceCodePro
    cp SauceCodePro/*.ttf "$FONT_DIR/"
    fc-cache -fv
    rm -rf SauceCodePro SauceCodePro.zip
    echo "  ✓ SauceCodePro Nerd Font installed"
    echo "  📋 Configure your Windows Terminal to use 'SauceCodePro Nerd Font'"
else
    echo "  ✓ SauceCodePro Nerd Font already installed"
fi

# Backup existing Neovim config if it exists
if [[ -d "$NVIM_CONFIG" && ! -L "$NVIM_CONFIG" ]]; then
    echo "🔄 Existing Neovim config found. Backing up..."
    backup_name="$NVIM_CONFIG.bak.$(date +%Y%m%d%H%M%S)"
    mv "$NVIM_CONFIG" "$backup_name"
    echo "  Backup created at $backup_name"
elif [[ -L "$NVIM_CONFIG" ]]; then
    echo "🔄 Removing existing symlink..."
    rm "$NVIM_CONFIG"
fi

# Create directory structure if needed
mkdir -p "$(dirname "$NVIM_CONFIG")"

# Create symlink to the repo's nvim config
echo "🔄 Linking Neovim config..."
ln -sf "$REPO_DIR/nvim" "$NVIM_CONFIG"

# Install lazy.nvim if not already installed
if [[ ! -d "$LAZY_PATH" ]]; then
    echo "🔄 Installing lazy.nvim..."
    git clone --filter=blob:none --branch=stable https://github.com/folke/lazy.nvim.git "$LAZY_PATH"
fi

# Create undodir for persistent undo history
UNDODIR="$HOME/.local/share/nvim/undodir"
if [[ ! -d "$UNDODIR" ]]; then
    echo "🔄 Creating undodir for persistent undo history..."
    mkdir -p "$UNDODIR"
fi

# Install formatters that Mason doesn't handle
echo "📋 LSP servers will be automatically installed by Mason on first Neovim launch"
echo "🔧 Installing formatters that Mason doesn't handle..."
pip3 install black

# WSL2 specific configurations
echo "🔄 Setting up WSL2-specific configurations..."

# Configure git to handle line endings properly
git config --global core.autocrlf false
git config --global core.eol lf

# Install wslu for WSL utilities (if not already installed)
if ! command -v wslview &>/dev/null; then
    echo "  Installing wslu for WSL utilities..."
    sudo apt install -y wslu
fi

echo ""
echo "✅ Neovim setup complete for WSL2!"
echo ""
echo "🚀 Launch Neovim by typing 'nvim' to automatically install plugins"
echo "📋 Mason will automatically install all LSP servers on first launch"
echo ""
echo "🔧 WSL2 Specific Notes:"
echo "  • Configure Windows Terminal to use 'SauceCodePro Nerd Font'"
echo "  • Use 'wslview <file>' to open files in Windows default apps"
echo "  • Markdown preview (peek.nvim) may require additional setup for browser access"
echo ""