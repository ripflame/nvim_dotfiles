# Neovim Setup

This repository contains my modern Neovim configuration with native LSP support, along with automated install scripts for both macOS and Windows.

## Features

- **Fully Automated Installation**: Run a single script to set up Neovim with all dependencies.
- **Plugin Manager**: Uses [lazy.nvim](https://github.com/folke/lazy.nvim) for efficient plugin management.
- **Modern Development Environment**:
  - **Native LSP**: Uses Neovim's native `vim.lsp.config()` for optimal performance and compatibility
  - **Mason Integration**: Automatic LSP server installation and management
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
  - Code formatting with conform.nvim (prettier, black, stylua)
  - Visual undo history with undotree
  - Auto-pairing brackets and comments
  - Windsurf integration
- **Custom Snippets**: Pre-configured snippets for JavaScript and JSON
- **Cross-Platform**: Works on macOS (Homebrew), Windows (Scoop), and WSL2/Ubuntu (apt)

---

## Installation Instructions

### **1. Clone the Repository**

```sh
# macOS / WSL2/Ubuntu
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

#### **For WSL2/Ubuntu** (Bash)

```sh
./install_wsl2.sh
```

### **3. Start Neovim**

```sh
nvim
```

When you first start Neovim:
1. **Plugins** will be automatically installed by lazy.nvim
2. **LSP servers** will be automatically installed by Mason (see `:Mason` UI)
3. **Additional servers** can be installed via the installation guide

**Note**: Mason handles all LSP server installations automatically. The install scripts only install essential system dependencies and formatters.

---

## Plugin List & Features

### **Core Plugins**

- **lazy.nvim** - Plugin manager
- **mason.nvim** - LSP server package manager
- **Native LSP** - Neovim's built-in `vim.lsp.config()` and `vim.lsp.enable()`
- **nvim-cmp** - Autocompletion engine with native LSP integration
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
- **conform.nvim** - Modern formatter integration (prettier, black, stylua)
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
  - `,F` - Format document (conform.nvim with LSP fallback)
  - `,rn` - Rename symbol (LSP)
  - `,ca` - Code actions (LSP) 
  - `gd` - Go to definition
  - `gp` - Peek definition in Telescope
  - `K` - Show hover documentation
  - `,e` - Show diagnostic float
  - `[d`/`]d` - Navigate diagnostics
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

### Adding LSP Servers

Refer to `LSP_SERVER_INSTALLATION_GUIDE.md` for detailed instructions on adding new language servers.

To add a new server:
1. Add server name to `nvim/lua/plugins/mason.lua` servers list
2. Configure server in `nvim/init.lua` using `vim.lsp.config()`
3. Add to `vim.lsp.enable()` list

The configuration uses:
- **Mason** for automatic server installation and updates
- **Native LSP** for optimal server configuration and performance

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
cd ~/.nvim-setup && git pull && ./install_mac.sh      # macOS
cd ~/.nvim-setup && git pull && ./install_wsl2.sh     # WSL2/Ubuntu
cd "$env:USERPROFILE\nvim-setup" && git pull && ./install_windows.ps1  # Windows
```

---

## Architecture

This configuration uses a modern three-tier architecture:

```
┌─────────────────────────────────────────┐
│  🔧 MASON: LSP Server Management       │
│  • Auto-install/update LSP servers     │
│  • Cross-platform server management    │
│  • UI for server discovery             │
└─────────────────────────────────────────┘
                    ↓
┌─────────────────────────────────────────┐
│  ⚡ NATIVE LSP: Core Configuration      │
│  • vim.lsp.config() - Direct Neovim    │
│  • No nvim-lspconfig dependency        │
│  • Future-proof for Neovim 0.12+       │
└─────────────────────────────────────────┘
                    ↓
┌─────────────────────────────────────────┐
│  🎨 LAZY.NVIM: Plugin Ecosystem        │
│  • All non-LSP plugins                 │
│  • UI, Git, completion, treesitter     │
│  • Optimized plugin loading            │
└─────────────────────────────────────────┘
```

## Notes

- **Neovim Version**: Requires Neovim 0.11+ for native LSP support (0.12+ recommended)
- **Platform-Specific Notes**:
  - **macOS**: Uses Homebrew for package management
  - **Windows**: Uses Scoop, run PowerShell as Administrator
  - **WSL2/Ubuntu**: Builds Neovim from source for latest version, configure Windows Terminal font
- **Common Requirements**: Git, compiler tools (gcc/clang), Node.js, Python3
- **Font Setup**: Install and configure 'SauceCodePro Nerd Font' in your terminal for proper icons

## LSP Server Management

### Automatic Installation
Mason automatically installs and manages these LSP servers:
- **TypeScript/JavaScript**: `typescript-language-server`
- **HTML**: `html-lsp` (vscode-html-language-server)
- **CSS**: `css-lsp` (vscode-css-language-server)  
- **JSON**: `json-lsp` (vscode-json-language-server)
- **Python**: `python-lsp-server` (pylsp)
- **Lua**: `lua-language-server`
- **Emmet**: `emmet-ls`
- **Markdown**: `marksman`

### Adding New Language Servers
See **`LSP_SERVER_INSTALLATION_GUIDE.md`** for complete instructions on adding support for additional languages.

### Manual Management
- `:Mason` - Browse and install additional servers
- `:MasonUpdate` - Update all installed servers
- Native LSP keymaps work automatically (K, gd, grn, gra, grr, etc.)

### WSL2-Specific Setup
For WSL2 users, markdown preview requires Windows browser access:
- **Chrome**: Ensure Chrome is installed on Windows (automatic detection)
- **Edge**: Alternative browser if Chrome unavailable
- **Preview Commands**: `:PeekOpen` and `:PeekClose` for markdown files

## Documentation

- **`LSP_SERVER_INSTALLATION_GUIDE.md`** - Complete guide for adding new language servers
- See git history for migration details and architectural decisions

Enjoy your enhanced Neovim experience!
