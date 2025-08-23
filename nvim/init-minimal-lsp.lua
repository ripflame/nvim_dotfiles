---------------------------------------------------------------------------------------------------
-- TEMPORARY TEST: NATIVE LSP ONLY (Neovim 0.11+)
---------------------------------------------------------------------------------------------------

-- Set the leader key to comma (before loading plugins)
vim.g.mapleader = ","

-- Load core modules
require("core.options") -- General settings

---------------------------------------------------------------------------------------------------
-- NATIVE LSP CONFIGURATION (NEOVIM 0.11+)
---------------------------------------------------------------------------------------------------

-- Configure LSP servers using native vim.lsp.config()
-- Note: Install language servers via system package manager (npm, apt, etc.)

-- TypeScript/JavaScript
vim.lsp.config('ts_ls', {
  cmd = { 'typescript-language-server', '--stdio' },
  filetypes = { 'javascript', 'typescript', 'javascriptreact', 'typescriptreact' },
  root_markers = { 'package.json', 'tsconfig.json', 'jsconfig.json' },
})

-- Enable all configured LSP servers
vim.lsp.enable('ts_ls')

-- Load keymaps
require("core.keymaps-minimal") -- Key mappings

-- Success message
print("Neovim configuration loaded successfully with native LSP!")