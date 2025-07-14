# Neovim Setup

This repository contains my Neovim configuration, along with automated install scripts for both macOS and Windows.

## Features

- **Fully Automated Installation**: Run a single script to set up Neovim with all dependencies.
- **Plugin Manager**: Uses [lazy.nvim](https://github.com/folke/lazy.nvim) for efficient plugin management.
- **Modern Development Environment**:
  - LSP support with automatic server installation via Mason
  - Advanced autocompletion with nvim-cmp and LuaSnip
  - Syntax highlighting with Treesitter
  - Fuzzy finding with Telescope
  - Git integration with Gitsigns, Fugitive, and DiffView
- **Code Organization**:
  - Smart code folding with UFO and LSP integration
  - Rainbow indentation guides with multi-color support
  - Code context display with treesitter-context
  - Interactive key binding help with which-key
- **UI Enhancements**:
  - Everforest theme with light/dark mode support
  - Auto dark mode integration
  - Tabline with bufferline
  - Enhanced status line with lualine
  - File navigation with built-in netrw
  - Visual column guides
- **Development Tools**:
  - Markdown preview with Peek
  - Code formatting with null-ls (prettier, black)
  - Visual undo history with undotree
  - Auto-pairing brackets and comments
  - Windsurf integration
- **Custom Snippets**: Pre-configured snippets for JavaScript and JSON
- **Cross-Platform**: Works on both macOS (with Homebrew) and Windows (using Scoop)

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
- **nvim-cmp** - Autocompletion engine with multiple sources
- **telescope.nvim** - Fuzzy finder and file navigation
- **lualine.nvim** - Status line with auto theme detection
- **auto-dark-mode.nvim** - Automatically switch between light and dark themes
- **bufferline.nvim** - Enhanced tab/buffer management with diagnostics

### **UI Enhancements**

- **everforest** - Color theme with light/dark variants and italic support
- **virt-column.nvim** - Custom color column with character display
- **indent-blankline.nvim** - Rainbow indentation guides with multi-color support
- **nvim-treesitter-context** - Show code context while scrolling
- **which-key.nvim** - Interactive keybinding suggestions and help

### **Development Tools**

- **peek.nvim** - Live markdown preview with Deno
- **windsurf.vim** - Windsurf editor integration
- **none-ls.nvim** - Formatter and linter integration (prettier, black)
- **lazydev.nvim** - Enhanced Lua development for Neovim
- **luasnip** - Advanced snippet engine with SnipMate format support
- **nvim-treesitter** - Advanced syntax highlighting with incremental selection

### **Git Integration**

- **gitsigns.nvim** - Git change indicators in gutter
- **vim-fugitive** - Comprehensive Git commands within Neovim
- **diffview.nvim** - Enhanced diff viewing and merge conflict resolution

### **Code Organization**

- **nvim-ufo** - Advanced code folding with LSP and indent providers
- **undotree** - Visual navigation of undo history with auto-close
- **Comment.nvim** - Easy code commenting with context awareness
- **nvim-autopairs** - Intelligent auto-close brackets and quotes

---

## Key Bindings Highlights

- **Leader Key**: `,` (comma)
- **File Navigation**:
  - `,ff` - Find files including hidden (Telescope with ripgrep)
  - `,fg` - Live grep search (Telescope)
  - `,fb` - Find open buffers (Telescope)
  - `,s` - Toggle file explorer (netrw)
- **Window Navigation**:
  - `Ctrl+h/j/k/l` - Move between windows
  - `Ctrl+w+></+/-` - Resize windows by 15/10 units
  - `Ctrl+t` - Open new tab
  - `Ctrl+d/u` - Half-page scroll with auto-center
- **Code Editing**:
  - `,F` - Format document (LSP async)
  - `,rn` - Rename symbol (LSP)
  - `,ca` - Code actions (LSP)
  - `gd` - Go to definition
  - `gp` - Peek definition in Telescope
  - `K` - Show hover documentation
  - `,e` - Show diagnostic float
  - `Tab/Shift+Tab` - Navigate through snippets
  - `J/K` (visual) - Move selection up/down
- **Completion**:
  - `Ctrl+e` - Toggle completion menu
  - `Ctrl+j/k` - Navigate completion items
  - `Enter` - Confirm selection
- **Git**:
  - Access git commands via `:Git` (fugitive)
  - Git signs in gutter (gitsigns)
  - `:DiffviewOpen` - Enhanced diff view
- **Theme Control**:
  - `:DARK` - Switch to dark theme
  - `:LITE` - Switch to light theme
- **Other Utilities**:
  - `,u` - Toggle undotree with auto-close
  - `,y/Y/P` - System clipboard operations
  - `,d` - Delete without yanking
  - `,?` - Show buffer local keymaps (which-key)
  - `:PeekOpen/PeekClose` - Markdown preview

---

## Customization

### Adding Snippets

Place your snippets in the `nvim/snippets` directory:

- Already includes snippets for JavaScript and JSON
- Uses SnipMate format with lazy loading
- Supports live reload with libuv file system events

### Adjusting LSP Servers

Edit `nvim/lua/lsp.lua` to customize:

- Which LSP servers are automatically installed via Mason
- Server-specific settings and capabilities
- LSP keybindings and handlers

### Changing Themes

The default theme is Everforest with medium background:

- Light/dark variants available with automatic switching
- Auto dark mode integration with system preferences
- Italic support enabled for enhanced readability

### Treesitter Configuration

Currently supports syntax highlighting for:
- Markdown, JavaScript, TypeScript, Lua, Python, HTML, CSS
- Incremental selection with custom keymaps
- Context display and intelligent indentation

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
