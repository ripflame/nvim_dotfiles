---------------------------------------------------------------------------------------------------
-- NEOVIM CONFIGURATION - ENTRY POINT
---------------------------------------------------------------------------------------------------
-- disable netrw at the very start of your init.lua in favor of nvim-tree
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- Set the leader key to comma (before loading lazy.nvim)
vim.g.mapleader = ","

-- Lazy.nvim Bootstrap
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git", "clone", "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git", "--branch=stable", lazypath
  })
end
vim.opt.rtp:prepend(lazypath)

-- Load core modules
require("core.options") -- General settings

-- Load plugins
require("lazy").setup("plugins")

-- Load keymaps
require("core.keymaps") -- Key mappings

-- Load LSP configurations
require("lsp")

-- Success message
print("Neovim configuration loaded successfully!")
