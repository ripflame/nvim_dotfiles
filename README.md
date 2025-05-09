# Neovim Setup

This repository contains my Neovim configuration, along with automated install scripts for both macOS and Windows.

## Features

- **Fully Automated Installation**: Run a single script to set up Neovim with all dependencies.
- **Plugin Manager**: Uses [lazy.nvim](https://github.com/folke/lazy.nvim) for efficient plugin management.
- **Modern Development Environment**: 
  - LSP support with automatic server installation via Mason
  - Autocompletion with nvim-cmp
  - Syntax highlighting with Treesitter
  - Fuzzy finding with Telescope
  - Git integration with Gitsigns and Fugitive
- **Code Organization**:
  - Smart folding with UFO
  - Indentation guides with multi-color support
  - Context-aware code view
  - Treesitter-based syntax highlighting
- **UI Enhancements**:
  - Everforest theme with light/dark mode support
  - Auto dark mode integration
  - Tabline with bufferline
  - Status line with lualine
  - File explorer with nvim-tree
- **Custom Snippets**: Pre-configured snippets for JavaScript and JSON
- **Cross-Platform**: Works on both macOS (with Homebrew) and Windows (using Scoop)
- **Persistent History**: Undo history preserved between sessions

---

## Installation Instructions

### **1. Clone the Repository**
```sh
# macOS
git clone https://github.com/ripflame/nvim_dotfiles.git ~/.nvim-setup
cd ~/.nvim-setup

# Windows (PowerShell)
git clone https://github.com/ripflame/nvim_dotfiles.git "$env:USERPROFILE\nvim-setup"
cd "$env:USERPROFILE\nvim-setup"
```

### **2. Run the Install Script**
#### **For macOS** (Zsh/Bash)
```sh
./install_mac.sh
```
#### **For Windows** (Run PowerShell as Administrator)
```powershell
./install_windows.ps1
```

### **3. Start Neovim**
```sh
nvim
```
When you first start Neovim, the plugins will be automatically installed by lazy.nvim, and LSP servers will be installed by Mason.

---

## Plugin List & Features

### **Core Plugins**
- **lazy.nvim** - Plugin manager
- **mason.nvim** - LSP/linter/formatter package manager
- **mason-lspconfig.nvim** - Mason integration with lspconfig
- **nvim-lspconfig** - Language Server Protocol (LSP) configuration
- **nvim-cmp** - Autocompletion engine
- **telescope.nvim** - Fuzzy finder and file navigation
- **lualine.nvim** - Status line
- **auto-dark-mode.nvim** - Automatically switch between light and dark themes
- **bufferline.nvim** - Enhanced tab/buffer management

### **UI Enhancements**
- **everforest** - Color theme with light/dark variants
- **virt-column.nvim** - Custom color column with character display
- **indent-blankline.nvim** - Show indentation with colored vertical lines
- **nvim-treesitter-context** - Show code context while scrolling
- **which-key.nvim** - Interactive keybinding suggestions
- **nvim-tree.lua** - File explorer

### **Development Tools**
- **null-ls.nvim** - Formatter and linter integration
- **neodev.nvim** - Enhanced development support for Neovim Lua API
- **luasnip** - Snippet engine
- **nvim-treesitter** - Better syntax highlighting and code analysis

### **Git Integration**
- **gitsigns.nvim** - Git change indicators in gutter
- **vim-fugitive** - Git commands within Neovim
- **diffview.nvim** - Enhanced diff viewing

### **Code Organization**
- **nvim-ufo** - Improved code folding with LSP integration
- **undotree** - Visual navigation of undo history
- **Comment.nvim** - Easy code commenting
- **nvim-autopairs** - Auto-close brackets and quotes

---

## Key Bindings Highlights

- **Leader Key**: `,` (comma)
- **File Navigation**:
  - `,ff` - Find files (Telescope)
  - `,fg` - Live grep (Telescope)
  - `,fb` - Find open buffers
  - `,s` - Toggle file explorer
- **Window Navigation**:
  - `Ctrl+h/j/k/l` - Move between windows
  - `Ctrl+w+</>/+/-` - Resize windows
- **Code Editing**:
  - `,F` - Format document (LSP)
  - `,rn` - Rename symbol (LSP)
  - `gd` - Go to definition
  - `K` - Show hover documentation
  - `[d/]d` - Navigate through diagnostics
  - `Tab/Shift+Tab` - Navigate through snippets
- **Git**:
  - Access git commands via `:Git` (fugitive)
- **Theme Control**:
  - `:DARK` - Switch to dark theme
  - `:LITE` - Switch to light theme
- **Other Utilities**:
  - `,u` - Toggle undotree
  - `,y` - Yank to system clipboard
  - `//` - Clear search highlights
  - `,,` - Show which-key menu for current context

---

## Customization

### Adding Snippets
Place your snippets in the `nvim/snippets` directory:
- Already includes snippets for JavaScript and JSON
- Uses SnipMate format

### Adjusting LSP Servers
Edit `nvim/lua/lsp.lua` to customize:
- Which LSP servers are automatically installed
- Server-specific settings

### Changing Themes
The default theme is Everforest:
- Light/dark variants available
- Automatic theme switching supported

---

## Updating the Configuration
If you make changes to your Neovim setup, update your local version with:
```sh
cd ~/.nvim-setup && git pull && ./install_mac.sh  # macOS
cd "$env:USERPROFILE\nvim-setup" && git pull && ./install_windows.ps1  # Windows
```

---

## Notes
- If you encounter issues, ensure you have the following installed:
  - Git
  - Neovim (0.8+)
  - Compiler tools (gcc/clang)
- Windows users should ensure they run PowerShell as Administrator when executing the script.
- For issues with font icons, make sure the Nerd Font is correctly installed and configured in your terminal.

Enjoy your enhanced Neovim experience!
