---------------------------------------------------------------------------------------------------
-- NEOVIM CONFIGURATION (Native LSP + Lazy.nvim)
-- Native LSP for 0.12+ compatibility, Lazy.nvim for plugins
---------------------------------------------------------------------------------------------------

-- Set the leader key to comma (before loading anything)
vim.g.mapleader = ","

-- Load core modules
require("core.options") -- General settings
require("core.lsp") -- LSP configuration

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
			{ out, "WarningMsg" },
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
require("lazy").setup("plugins")

-- Load keymaps (full version with all functionality)
require("core.keymaps") -- Key mappings
