# Neovim Native LSP Migration Guide

## Overview

This document details the migration from the deprecated `nvim-lspconfig` + `Mason` setup to Neovim's native LSP configuration system (`vim.lsp.config()` + `vim.lsp.enable()`), which became available in Neovim 0.11+ and is the recommended approach for Neovim 0.12+.

## Background: The Problem

### Original Error
When using Neovim 0.12.0-dev with the traditional `nvim-lspconfig` setup, JavaScript and TypeScript files would trigger this error:

```
Error executing lua callback: vim/fs.lua:0: invalid value (table) at index 2 in table for 'concat'
stack traceback:
    [C]: in function 'concat'
    vim/fs.lua: in function 'joinpath'
    vim/fs.lua: in function 'find'
    vim/fs.lua: in function 'root'
    .../.local/share/nvim/lazy/nvim-lspconfig/lsp/ts_ls.lua:64: in function 'root_dir'
```

### Root Cause
The error originated from a version compatibility issue in `nvim-lspconfig`'s `ts_ls` configuration:

```lua
-- In nvim-lspconfig/lsp/ts_ls.lua:63-64
root_markers = vim.fn.has('nvim-0.11.3') == 1 and { root_markers } or root_markers
local project_root = vim.fs.root(bufnr, root_markers)
```

The problem:
1. `vim.fn.has('nvim-0.11.3')` returns `1` (true) for Neovim 0.12.0-dev
2. This wraps `root_markers` in a table: `{ root_markers }` creating a nested table structure
3. `vim.fs.root()` expects a flat array of strings, not nested tables
4. This causes the `table.concat()` error when trying to process the nested structure

### The Bigger Picture
According to the [nvim-lspconfig README](https://github.com/neovim/nvim-lspconfig), the entire `nvim-lspconfig` framework is being deprecated:

> - Configs now use `vim.lsp.enable('…')` instead of `require'lspconfig'.….setup{}`
> - Configs in `lua/lspconfig/` are deprecated and will be removed
> - The `require'lspconfig'` framework is deprecated
> - Framework parts have been upstreamed to Nvim core (`vim.lsp.config`)

## Migration Strategy: Hybrid Approach

We implemented a **hybrid approach** that provides the best of both worlds:

- ✅ **Native LSP**: Use `vim.lsp.config()` + `vim.lsp.enable()` for LSP servers
- ✅ **Lazy.nvim**: Keep using Lazy.nvim for all other plugins (UI, Git, etc.)
- ✅ **Full Compatibility**: All existing functionality preserved
- ✅ **Future Proof**: Ready for Neovim's evolution

## Technical Implementation

### Before (Old nvim-lspconfig approach)
```lua
-- OLD: Using nvim-lspconfig + Mason
require("mason").setup()
require("mason-lspconfig").setup({
  ensure_installed = { "ts_ls", "html", "cssls", ... }
})

-- This would auto-setup LSP servers with potential compatibility issues
```

### After (Native LSP + Lazy.nvim hybrid)
```lua
-- NEW: Native LSP configuration
vim.lsp.config('ts_ls', {
  cmd = { 'typescript-language-server', '--stdio' },
  filetypes = { 'javascript', 'typescript', 'javascriptreact', 'typescriptreact' },
  root_markers = { 'package.json', 'tsconfig.json', 'jsconfig.json' },
})

-- Enable the LSP server
vim.lsp.enable('ts_ls')

-- Still use Lazy.nvim for non-LSP plugins
require("lazy").setup("plugins-hybrid")
```

## Language Server Configuration

### TypeScript/JavaScript
```lua
vim.lsp.config('ts_ls', {
  cmd = { 'typescript-language-server', '--stdio' },
  filetypes = { 'javascript', 'typescript', 'javascriptreact', 'typescriptreact' },
  root_markers = { 'package.json', 'tsconfig.json', 'jsconfig.json' },
})
```

### HTML
```lua
vim.lsp.config('html', {
  cmd = { 'vscode-html-language-server', '--stdio' },
  filetypes = { 'html' },
  root_markers = { 'package.json', '.git' },
})
```

### CSS
```lua
vim.lsp.config('cssls', {
  cmd = { 'vscode-css-language-server', '--stdio' },
  filetypes = { 'css', 'scss', 'less' },
  root_markers = { 'package.json', '.git' },
})
```

### Python
```lua
vim.lsp.config('pyright', {
  cmd = { 'pyright-langserver', '--stdio' },
  filetypes = { 'python' },
  root_markers = { 'pyproject.toml', 'setup.py', 'requirements.txt', '.git' },
})
```

### Lua
```lua
vim.lsp.config('lua_ls', {
  cmd = { 'lua-language-server' },
  filetypes = { 'lua' },
  root_markers = { '.luarc.json', '.luarc.jsonc', '.git' },
  settings = {
    Lua = {
      diagnostics = {
        globals = { 'vim' }
      },
      workspace = {
        library = vim.api.nvim_get_runtime_file("", true),
      },
      telemetry = {
        enable = false,
      },
    }
  }
})
```

## Installation Requirements

### Language Server Installation
With native LSP, you need to install language servers manually via system package managers instead of Mason:

```bash
# TypeScript/JavaScript
npm install -g typescript-language-server typescript

# HTML/CSS/JSON
npm install -g vscode-langservers-extracted

# Python
npm install -g pyright
# or: pip install pyright

# Lua
# Install lua-language-server via your system package manager
# Ubuntu/Debian: apt install lua-language-server
# macOS: brew install lua-language-server

# Emmet
npm install -g emmet-ls

# Markdown
# Download marksman from: https://github.com/artempyanykh/marksman/releases
```

## File Structure Changes

### Configuration Files
```
nvim/
├── init.lua                    # Main config (hybrid approach)
├── init-lazy.lua              # Backup of original Lazy.nvim config
├── init-test-lsp.lua          # Minimal native LSP test config
├── lua/
│   ├── core/
│   │   ├── options.lua        # Unchanged
│   │   ├── keymaps.lua        # Full keymaps (restored)
│   │   └── keymaps-minimal.lua # Test version
│   ├── plugins/               # Original plugins (backed up)
│   ├── plugins-hybrid/        # New hybrid plugin configs
│   └── lsp-lazy-backup.lua    # Backed up old LSP config
└── NEOVIM_NATIVE_LSP_MIGRATION.md # This documentation
```

### Removed Dependencies
- ❌ `nvim-lspconfig` - Replaced with native `vim.lsp.config()`
- ❌ `mason.nvim` - Manual LSP server installation
- ❌ `mason-lspconfig.nvim` - No longer needed

### Preserved Plugins
All other plugins remain unchanged:
- ✅ nvim-treesitter
- ✅ telescope.nvim
- ✅ lualine.nvim
- ✅ gitsigns.nvim
- ✅ nvim-cmp (completion)
- ✅ LuaSnip (snippets)
- ✅ All UI and editor enhancement plugins

## Benefits of Native LSP

### 1. **Compatibility**
- ✅ No more version-specific compatibility issues
- ✅ Direct integration with Neovim core
- ✅ Future-proof as Neovim evolves

### 2. **Performance**
- ✅ Reduced plugin overhead
- ✅ Direct API calls instead of wrapper functions
- ✅ Faster startup time (fewer plugins to load)

### 3. **Simplicity**
- ✅ Cleaner configuration
- ✅ No dependency management for LSP servers
- ✅ Direct control over LSP behavior

### 4. **Reliability**
- ✅ No more "plugin broke my LSP" scenarios
- ✅ Consistent behavior across Neovim versions
- ✅ Official support from Neovim core team

## Testing Results

### Before Migration
```bash
# Opening JS/TS files resulted in:
Error: vim/fs.lua:0: invalid value (table) at index 2 in table for 'concat'
# LSP would not start, no completion or diagnostics
```

### After Migration
```bash
# Test results:
Neovim configuration loaded successfully with native LSP!
LSP clients: 1
Client: ts_ls
# ✅ No errors, LSP working perfectly
```

## Rollback Strategy

If issues arise, you can easily rollback:

1. **Switch back to original config:**
   ```bash
   cd ~/.nvim-setup/nvim/
   mv init.lua init-hybrid.lua
   mv init-lazy.lua init.lua
   mv lua/lsp-lazy-backup.lua lua/lsp.lua
   ```

2. **Use specific commit:**
   ```bash
   git checkout main  # Return to pre-migration state
   ```

## Future Considerations

### vim.pack Migration
- Neovim 0.12+ may include `vim.pack` for native plugin management
- Currently not available in 0.12.0-dev builds tested
- Future migration path: Native LSP + vim.pack (no external plugin manager)

### Built-in Completion
- Neovim may include native completion in future versions
- Could potentially replace nvim-cmp
- Monitor `vim.lsp.completion` API development

## Troubleshooting

### LSP Server Not Starting
1. Check if language server is installed: `which typescript-language-server`
2. Verify project has root markers (package.json, etc.)
3. Check LSP logs: `:LspLog` (if LSP commands available)

### Plugin Issues
1. Check plugin directory: `~/.local/share/nvim/lazy/`
2. Update plugins: `:Lazy update`
3. Check for conflicts in hybrid plugin configs

### Configuration Errors
1. Check syntax: `nvim --headless -c "luafile ~/.nvim-setup/nvim/init.lua" -c "qa"`
2. Test minimal config first
3. Add plugins incrementally

## Conclusion

This migration successfully resolves the JavaScript/TypeScript compatibility issues while modernizing the Neovim configuration for the future. The hybrid approach maintains all existing functionality while providing a robust foundation for Neovim 0.12+ compatibility.

The native LSP approach is not just a workaround—it's the officially recommended path forward for Neovim LSP configuration.