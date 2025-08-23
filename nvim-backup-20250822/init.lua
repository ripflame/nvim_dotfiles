---------------------------------------------------------------------------------------------------
-- NEOVIM CONFIGURATION - ENTRY POINT
---------------------------------------------------------------------------------------------------

-- Lazy.nvim Bootstrap
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

-- Set the leader key to comma (before loading lazy.nvim)
vim.g.mapleader = ","

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
