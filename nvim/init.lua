---------------------------------------------------------------------------------------------------
-- NEOVIM CONFIGURATION - HYBRID EDITION (Native LSP + Lazy.nvim)
-- Best of both worlds: Native LSP for 0.12+ compatibility, Lazy.nvim for plugins
---------------------------------------------------------------------------------------------------

-- Set the leader key to comma (before loading anything)
vim.g.mapleader = ","

-- Load core modules
require("core.options") -- General settings

---------------------------------------------------------------------------------------------------
-- NATIVE LSP CONFIGURATION (NEOVIM 0.11+) - REPLACES nvim-lspconfig
---------------------------------------------------------------------------------------------------

-- Configure LSP servers using native vim.lsp.config() with Mason-installed servers
-- This approach gives us the benefits of Mason (auto-install/update) with native LSP configuration
-- that avoids nvim-lspconfig compatibility issues

-- Set up LSP capabilities for completion (enhanced by nvim-cmp)
local capabilities = vim.lsp.protocol.make_client_capabilities()

-- Helper function to get Mason-installed server path
local function mason_cmd(server_name)
  local mason_registry = require("mason-registry")
  if mason_registry.is_installed(server_name) then
    local pkg = mason_registry.get_package(server_name)
    return pkg:get_install_path()
  end
  return nil
end

-- Configure LSP servers immediately - Mason will install missing servers in background
-- TypeScript/JavaScript - Use native LSP to avoid table concat bug
vim.lsp.config('ts_ls', {
  cmd = { 'typescript-language-server', '--stdio' },
  filetypes = { 'javascript', 'typescript', 'javascriptreact', 'typescriptreact' },
  root_markers = { 'package.json', 'tsconfig.json', 'jsconfig.json' },
  capabilities = capabilities,
})

-- HTML
vim.lsp.config('html', {
  cmd = { 'vscode-html-language-server', '--stdio' },
  filetypes = { 'html' },
  root_markers = { 'package.json', '.git' },
  capabilities = capabilities,
})

-- CSS  
vim.lsp.config('cssls', {
  cmd = { 'vscode-css-language-server', '--stdio' },
  filetypes = { 'css', 'scss', 'less' },
  root_markers = { 'package.json', '.git' },
  capabilities = capabilities,
})

-- JSON
vim.lsp.config('jsonls', {
  cmd = { 'vscode-json-language-server', '--stdio' },
  filetypes = { 'json', 'jsonc' },
  root_markers = { 'package.json', '.git' },
  capabilities = capabilities,
})

-- Python
vim.lsp.config('pyright', {
  cmd = { 'pyright-langserver', '--stdio' },
  filetypes = { 'python' },
  root_markers = { 'pyproject.toml', 'setup.py', 'requirements.txt', '.git' },
  capabilities = capabilities,
})

-- Lua
vim.lsp.config('lua_ls', {
  cmd = { 'lua-language-server' },
  filetypes = { 'lua' },
  root_markers = { '.luarc.json', '.luarc.jsonc', '.git' },
  capabilities = capabilities,
  settings = {
    Lua = {
      diagnostics = {
        globals = { 'vim' } -- Recognize vim global
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

-- Emmet
vim.lsp.config('emmet_ls', {
  cmd = { 'emmet-ls', '--stdio' },
  filetypes = { 'html', 'css', 'javascript', 'typescript', 'javascriptreact', 'typescriptreact' },
  root_markers = { 'package.json', '.git' },
  capabilities = capabilities,
})

-- Markdown
vim.lsp.config('marksman', {
  cmd = { 'marksman', 'server' },
  filetypes = { 'markdown', 'markdown.mdx' },
  root_markers = { '.marksman.toml', '.git' },
  capabilities = capabilities,
})

-- Enable all configured LSP servers
vim.lsp.enable({
  'ts_ls', 'html', 'cssls', 'jsonls', 'pyright', 'lua_ls', 'emmet_ls', 'marksman'
})

---------------------------------------------------------------------------------------------------
-- LAZY.NVIM BOOTSTRAP (FOR NON-LSP PLUGINS)
---------------------------------------------------------------------------------------------------

-- Bootstrap lazy.nvim (same as before)
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out,                            "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

---------------------------------------------------------------------------------------------------
-- LOAD ALL NON-LSP PLUGINS VIA LAZY.NVIM
---------------------------------------------------------------------------------------------------

-- Load plugins (excluding LSP-related ones)
require("lazy").setup("plugins-hybrid")

-- Load keymaps (full version with all functionality)
require("core.keymaps") -- Key mappings

-- Success message
print("Neovim hybrid configuration loaded successfully! (Native LSP + Lazy.nvim plugins)")