# Neovim Setup

This repository contains my Neovim configuration, along with an automated install script for both macOS and Windows. The setup includes essential plugins and tools to enhance development productivity.

## Features
- **Fully Automated Installation**: Run a single script to set up Neovim with all dependencies.
- **Plugin Manager**: Uses [lazy.nvim](https://github.com/folke/lazy.nvim) to manage plugins efficiently.
- **Modern Development Setup**: Includes support for LSP, autocomplete, fuzzy finding, and more.
- **Cross-Platform**: Works on both macOS and Windows (using Scoop for package management on Windows).
- **Symlinked Configuration**: Ensures easy updates and version control via Git.

---

## Installation Instructions

### **1?? Clone the Repository**
```sh
# macOS
git clone https://github.com/yourusername/nvim-setup.git ~/.nvim-setup
cd ~/.nvim-setup

# Windows (PowerShell)
git clone https://github.com/yourusername/nvim-setup.git "$env:USERPROFILE\nvim-setup"
cd "$env:USERPROFILE\nvim-setup"
```

### **2?? Run the Install Script**
#### **For macOS**
```sh
./install_mac.sh
```
#### **For Windows** (Run PowerShell as Administrator)
```powershell
./install_windows.ps1
```

### **3?? Start Neovim**
```sh
nvim
```

---

## Plugin List & Features

### **Core Plugins**
- **lazy.nvim** Ð Plugin manager
- **nvim-treesitter** Ð Better syntax highlighting
- **nvim-lspconfig** Ð Language Server Protocol (LSP) support
- **cmp-nvim** Ð Autocompletion engine
- **telescope.nvim** Ð Fuzzy finder and file searching
- **lualine.nvim** Ð A modern statusline
- **gitsigns.nvim** Ð Git integration inside Neovim

### **Development Tools**
- **nvim-lspconfig** Ð Pre-configured LSP for various languages
- **null-ls.nvim** Ð Formatter and linter integration
- **mason.nvim** Ð Easy LSP, DAP, and formatter installation
- **nvim-dap** Ð Debugging support

### **UI Enhancements**
- **catppuccin.nvim** Ð Custom color theme
- **bufferline.nvim** Ð Enhanced tab management
- **which-key.nvim** Ð Keybinding suggestions

### **File Navigation & Utilities**
- **telescope.nvim** Ð Fuzzy finder
- **nvim-tree.lua** Ð File explorer
- **nvim-autopairs** Ð Auto-close brackets and quotes
- **comment.nvim** Ð Quick commenting

---

## Updating the Configuration
If you make changes to your Neovim setup, you can update your local version with:
```sh
cd ~/.nvim-setup && git pull && ./install_mac.sh  # macOS
cd "$env:USERPROFILE\nvim-setup" && git pull && ./install_windows.ps1  # Windows
```

---

## Notes
- If you encounter issues, make sure you have Git, Neovim, and other dependencies installed.
- Windows users should ensure they run PowerShell as Administrator when executing the script.

Enjoy your new Neovim setup! ??

