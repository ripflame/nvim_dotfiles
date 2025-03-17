# Neovim Setup

This repository contains my Neovim configuration, along with an automated install script for both macOS and Windows.
## Features
- **Fully Automated Installation**: Run a single script to set up Neovim with all dependencies.
- **Plugin Manager**: Uses [lazy.nvim](https://github.com/folke/lazy.nvim) to manage plugins efficiently.
- **Modern Development Setup**: Includes support for LSP, autocomplete, fuzzy finding, and more.
- **Cross-Platform**: Works on both macOS and Windows (using Scoop for package management on Windows).
- **Symlinked Configuration**: Ensures easy updates and version control via Git.

---

## Installation Instructions

### **1 Clone the Repository**
```sh
# macOS
git clone https://github.com/ripflame/nvim_dotfiles.git ~/.nvim-setup
cd ~/.nvim-setup

# Windows (PowerShell)
git clone https://github.com/ripflame/nvim_dotfiles.git "$env:USERPROFILE\nvim-setup"
cd "$env:USERPROFILE\nvim-setup"
```

### **2 Run the Install Script**
#### **For macOS**
```sh
./install_mac.sh
```
#### **For Windows** (Run PowerShell as Administrator)
```powershell
./install_windows.ps1
```

### **3 Start Neovim**
```sh
nvim
```

---

## Plugin List & Features

### **Core Plugins**
- **lazy.nvim** => Plugin manager
- **nvim-treesitter** => Better syntax highlighting
- **nvim-lspconfig** => Language Server Protocol (LSP) support
- **cmp-nvim** => Autocompletion engine
- **telescope.nvim** => Fuzzy finder and file searching
- **lualine.nvim** => A modern statusline
- **gitsigns.nvim** => Git integration inside Neovim
- **ufo.nvim** => Code folding with LSP or indentation as a fallback

### **Development Tools**
- **nvim-lspconfig** => Pre-configured LSP for various languages
- **null-ls.nvim** => Formatter and linter integration
- **vim-fugitive** => Easy git access with :Git
- ~~**mason.nvim** => Easy LSP, DAP, and formatter installation~~
- ~~**nvim-dap** => Debugging support~~

### **UI Enhancements**
- **everforest.nvim** => Custom color theme
- **virt-colum.nvim** => Replace the colorcolumn wiht any char
- **indent-blankline.nvim** => Show indentation vertical lines with differente colors
- ~~**bufferline.nvim** => Enhanced tab management~~
- ~~**which-key.nvim** => Keybinding suggestions~~

### **File Navigation & Utilities**
- ~~**nvim-tree.lua** => File explorer~~
- **nvim-autopairs** => Auto-close brackets and quotes
- **comment.nvim** => Quick commenting

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

Enjoy your new Neovim setup!

