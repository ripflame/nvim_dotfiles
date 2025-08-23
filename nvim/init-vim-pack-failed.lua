---------------------------------------------------------------------------------------------------
-- NEOVIM CONFIGURATION - VIM.PACK EDITION (Neovim 0.12+)
---------------------------------------------------------------------------------------------------

-- Set the leader key to comma (before loading plugins)
vim.g.mapleader = ","

-- Load core modules
require("core.options") -- General settings

---------------------------------------------------------------------------------------------------
-- PLUGIN MANAGEMENT VIA VIM.PACK (NEOVIM 0.12+)
---------------------------------------------------------------------------------------------------

-- Essential plugins via vim.pack
vim.pack.add({
  -- Treesitter for syntax highlighting
  { src = "https://github.com/nvim-treesitter/nvim-treesitter" },
  { src = "https://github.com/nvim-treesitter/nvim-treesitter-context" },
  
  -- Telescope for fuzzy finding
  { src = "https://github.com/nvim-telescope/telescope.nvim" },
  { src = "https://github.com/nvim-lua/plenary.nvim" }, -- Telescope dependency
  
  -- UI enhancements
  { src = "https://github.com/nvim-lualine/lualine.nvim" },
  { src = "https://github.com/akinsho/bufferline.nvim" },
  { src = "https://github.com/lukas-reineke/indent-blankline.nvim" },
  { src = "https://github.com/nvim-tree/nvim-web-devicons" },
  
  -- Git integration
  { src = "https://github.com/tpope/vim-fugitive" },
  { src = "https://github.com/lewis6991/gitsigns.nvim" },
  { src = "https://github.com/sindrets/diffview.nvim" },
  
  -- Editor functionality
  { src = "https://github.com/folke/which-key.nvim" },
  { src = "https://github.com/numToStr/Comment.nvim" },
  { src = "https://github.com/windwp/nvim-autopairs" },
  { src = "https://github.com/mbbill/undotree" },
  
  -- Color scheme
  { src = "https://github.com/sainnhe/everforest" },
  
  -- Completion (keeping nvim-cmp for now, may migrate to built-in later)
  { src = "https://github.com/hrsh7th/nvim-cmp" },
  { src = "https://github.com/hrsh7th/cmp-buffer" },
  { src = "https://github.com/hrsh7th/cmp-path" },
  { src = "https://github.com/hrsh7th/cmp-nvim-lsp" },
  { src = "https://github.com/hrsh7th/cmp-nvim-lsp-signature-help" },
  
  -- Snippets
  { src = "https://github.com/L3MON4D3/LuaSnip" },
  { src = "https://github.com/saadparwaiz1/cmp_luasnip" },
  
  -- Folding
  { src = "https://github.com/kevinhwang91/nvim-ufo" },
  { src = "https://github.com/kevinhwang91/promise-async" }, -- nvim-ufo dependency
  
  -- Markdown
  { src = "https://github.com/toppair/peek.nvim" },
  
  -- Editor-specific
  { src = "https://github.com/windsurf-ai/windsurf.vim" },
})

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

-- HTML
vim.lsp.config('html', {
  cmd = { 'vscode-html-language-server', '--stdio' },
  filetypes = { 'html' },
  root_markers = { 'package.json', '.git' },
})

-- CSS
vim.lsp.config('cssls', {
  cmd = { 'vscode-css-language-server', '--stdio' },
  filetypes = { 'css', 'scss', 'less' },
  root_markers = { 'package.json', '.git' },
})

-- JSON
vim.lsp.config('jsonls', {
  cmd = { 'vscode-json-language-server', '--stdio' },
  filetypes = { 'json', 'jsonc' },
  root_markers = { 'package.json', '.git' },
})

-- Python
vim.lsp.config('pyright', {
  cmd = { 'pyright-langserver', '--stdio' },
  filetypes = { 'python' },
  root_markers = { 'pyproject.toml', 'setup.py', 'requirements.txt', '.git' },
})

-- Lua
vim.lsp.config('lua_ls', {
  cmd = { 'lua-language-server' },
  filetypes = { 'lua' },
  root_markers = { '.luarc.json', '.luarc.jsonc', '.git' },
  settings = {
    Lua = {
      diagnostics = {
        globals = { 'vim' } -- Recognize vim global
      }
    }
  }
})

-- Emmet
vim.lsp.config('emmet_ls', {
  cmd = { 'emmet-ls', '--stdio' },
  filetypes = { 'html', 'css', 'javascript', 'typescript', 'javascriptreact', 'typescriptreact' },
  root_markers = { 'package.json', '.git' },
})

-- Markdown
vim.lsp.config('marksman', {
  cmd = { 'marksman', 'server' },
  filetypes = { 'markdown', 'markdown.mdx' },
  root_markers = { '.marksman.toml', '.git' },
})

-- Enable all configured LSP servers
vim.lsp.enable({
  'ts_ls',
  'html', 
  'cssls',
  'jsonls',
  'pyright',
  'lua_ls',
  'emmet_ls',
  'marksman'
})

---------------------------------------------------------------------------------------------------
-- LOAD REMAINING CONFIGURATION
---------------------------------------------------------------------------------------------------

-- Load plugin configurations (will need to update these)
vim.cmd('runtime! plugin-configs/*.lua')

-- Load keymaps
require("core.keymaps") -- Key mappings

-- Success message
print("Neovim configuration loaded successfully with vim.pack!")