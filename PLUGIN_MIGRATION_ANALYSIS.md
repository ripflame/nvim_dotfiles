# Plugin Migration Analysis: Lazy.nvim → vim.pack

## Current Plugins (22 total)

### Core/Essential Plugins (vim.pack compatible)
- **treesitter** - Core functionality, should work
- **telescope** - Popular, should work 
- **lualine** - Status line, should work
- **fugitive** - Git integration, should work
- **gitsigns** - Git signs, should work
- **undotree** - Undo history, should work
- **which-key** - Key binding help, should work
- **comment** - Comment toggling, should work
- **autopairs** - Auto-close pairs, should work
- **diffview** - Git diff viewer, should work
- **colorscheme** - Color scheme, should work

### LSP/Completion Stack (MAJOR CHANGES NEEDED)
- **lspconfig** - ❌ REMOVE (deprecated, use vim.lsp.config/enable)
- **mason** - ❌ REMOVE (external LSP installer, use system packages)
- **completion** (nvim-cmp) - ⚠️ EVALUATE (may need vim.lsp.completion)
- **lazydev** - ⚠️ EVALUATE (Lua dev support)

### Formatting/Development
- **formatting** (none-ls/null-ls) - ⚠️ EVALUATE (may not be needed)
- **snippets** (LuaSnip) - ⚠️ EVALUATE (may use built-in snippets)
- **markdown** - Should work
- **folding** - Should work

### UI/Visual
- **bufferline** - Should work
- **indent-guides** - Should work

### Editor-Specific
- **windsurf** - Custom editor plugin, should work

## Migration Strategy

### Phase 1: Remove deprecated
- Remove nvim-lspconfig entirely
- Remove Mason (use system LSP servers)
- Replace with vim.lsp.config() + vim.lsp.enable()

### Phase 2: Evaluate completion stack
- Test if built-in vim.lsp.completion is sufficient
- Keep nvim-cmp if needed for advanced features

### Phase 3: Core plugins via vim.pack
- Migrate essential plugins to vim.pack.add()
- Test each one individually

### Phase 4: Clean up
- Remove Lazy.nvim bootstrap
- Update configuration structure