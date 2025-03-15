--------------------------------------------------------------------------------
-- LEADER KEY SETTING
--------------------------------------------------------------------------------
-- Set the leader key to comma.
-- This must be set BEFORE loading lazy.nvim.
vim.g.mapleader = ","

--------------------------------------------------------------------------------
-- LAZY.NVIM PLUGIN MANAGER SETUP
--------------------------------------------------------------------------------
-- Ensure Lazy.nvim is installed.
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git", "clone", "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git", "--branch=stable", lazypath
  })
end
vim.opt.rtp:prepend(lazypath)

-- Load plugins from plugins.lua.
require("lazy").setup("plugins")

--------------------------------------------------------------------------------
-- GENERAL SETTINGS
--------------------------------------------------------------------------------
-- Enable true color support.
vim.opt.termguicolors = true

-- Reserve a space in the gutter to avoid layout shifts.
vim.opt.signcolumn = 'yes'

-- Set line numbering: absolute and relative.
vim.opt.number = true
vim.opt.relativenumber = true

-- Reserve a space in the gutter to avoid layout shifts.
vim.opt.signcolumn = 'yes'

-- Indentation settings.
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true

-- Neovide settings only
if vim.g.neovide then
  -- Detect OS
  local is_windows = vim.fn.has("win32") == 1
  local is_mac = vim.fn.has("macunix") == 1

  -- Set font list based on OS
  local font = "SauceCodePro Nerd Font:h16" -- Default font
  if is_windows then
    font = "SauceCodePro Nerd Font:h14"     -- Consolas is default on Windows
  elseif is_mac then
    font = "SauceCodePro Nerd Font:h16"     -- Menlo is default on macOS
  else
    font = "Monospace:h14"                  -- Generic fallback for Linux
  end

  vim.o.guifont = font -- Put anything you want to happen only in Neovide here
  vim.g.neovide_scale_factor = .90
end

-- Enable smart indentation and cursor line highlighting.
vim.opt.smartindent = true
vim.opt.cursorline = true

-- Set scrolling offset.
vim.opt.scrolloff = 12

-- Disable line wrapping.
vim.opt.wrap = false

-- Use the system clipboard for all yank/put operations.
vim.opt.clipboard = "unnamedplus"

-- Enable mouse support in all modes.
vim.opt.mouse = "a"

-- Search settings.
vim.opt.incsearch = true  -- Show search matches as you type.
vim.opt.ignorecase = true -- Ignore case during search...
vim.opt.smartcase = true  -- ...unless an uppercase character is used.
vim.opt.hlsearch = true   -- Highlight all search matches.

-- Fold settings.
vim.opt.foldmethod = "manual"
vim.opt.foldenable = true
vim.o.foldenable = true -- Disable folding by default
vim.o.foldlevel = 99 -- Keep everything unfolded
vim.o.foldlevelstart = 99 -- Prevent automatic folding on file open
vim.o.foldcolumn = "1" -- Optional: Show fold column for easier toggling
vim.o.foldmethod = "expr" -- Use expression-based folding (needed for Treesitter or ufo)
vim.o.foldexpr = "nvim_treesitter#foldexpr()" -- If using Treesitter

--------------------------------------------------------------------------------
-- KEY MAPPINGS
--------------------------------------------------------------------------------
-- Close the quickfix window.
vim.keymap.set("n", "<leader>cc", ":cclose<CR>", { noremap = true, desc = "Close quickfix window" })

-- Open the built-in file explorer (netrw) using <leader>s.
vim.keymap.set("n", "<leader>s", vim.cmd.Ex, { desc = "Open file explorer" })

-- Smooth scrolling with Ctrl+e / Ctrl+y.
vim.keymap.set("n", "<C-e>", "3<C-e>", { noremap = true, desc = "Scroll down 3 lines" })
vim.keymap.set("n", "<C-y>", "3<C-y>", { noremap = true, desc = "Scroll up 3 lines" })

-- Toggle search highlight (clear highlighting) with //.
vim.keymap.set("n", "//", ":nohlsearch<CR>", { silent = true, desc = "Clear search highlight" })

-- Append a semicolon at the end of the current line.
vim.keymap.set("n", ";;", "A;<ESC>", { silent = true, desc = "Append semicolon at end of line" })

-- Trim trailing whitespace on demand using <leader>t.
vim.keymap.set("n", "<leader>t", ":%s/\\s\\+$//<CR>", { silent = true, desc = "Trim trailing whitespace" })

-- Better window navigation using Ctrl + (H, J, K, L).
vim.keymap.set("n", "<C-J>", "<C-W><C-J>", { noremap = true, desc = "Move to window below" })
vim.keymap.set("n", "<C-K>", "<C-W><C-K>", { noremap = true, desc = "Move to window above" })
vim.keymap.set("n", "<C-L>", "<C-W><C-L>", { noremap = true, desc = "Move to window right" })
vim.keymap.set("n", "<C-H>", "<C-W><C-H>", { noremap = true, desc = "Move to window left" })

-- Emacs-like navigation in Insert mode.
vim.keymap.set("i", "<C-b>", "<Left>", { desc = "Move cursor left" })
vim.keymap.set("i", "<C-f>", "<Right>", { desc = "Move cursor right" })
vim.keymap.set("i", "<C-e>", "<End>", { desc = "Move cursor to end of line" })

-- Open the current working directory in the system file manager.
local open_cmd = vim.loop.os_uname().sysname == "Windows_NT" and "explorer ." or "open ."
vim.keymap.set("n", "<leader>o", ":!" .. open_cmd .. "<CR>", {
  noremap = true,
  silent = true,
  desc = "Open current directory in file manager",
})

-- Telescope Keymaps (File Navigation)
local builtin = require("telescope.builtin")
vim.keymap.set("n", "<leader>ff", function()
  builtin.find_files({
    hidden = true,
    find_command = { "rg", "--files", "--hidden", "--glob", "!.git/*" }
  })
end, { desc = "Find hidden files" })
vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Grep text" })
vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Find buffers" })

-- Custom Mappings & Scripts (From Old Config)
-- Terminal command: open a terminal in a horizontal split.
vim.cmd([[
  command! OpenTerminal split | terminal
]])
vim.keymap.set("n", "<leader>ev", function()
  vim.cmd("e " .. vim.fn.stdpath("config") .. "/init.lua")
end, { silent = true })

--------------------------------------------------------------------------------
-- LSP & AUTOCOMPLETION
--------------------------------------------------------------------------------
-- Load LSP configurations from lsp.lua.
require("lsp")

-- Configure nvim-cmp for autocompletion.
local cmp = require("cmp")
cmp.setup({
  snippet = {
    expand = function(args)
      require("luasnip").lsp_expand(args.body)
    end,
  },
  mapping = {
    ['<C-e>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.close()
      else
        cmp.complete()
      end
    end, { "i", "s" }),
    ['<C-j>'] = cmp.mapping.select_next_item(),
    ['<C-k>'] = cmp.mapping.select_prev_item(),
    ['<CR>'] = cmp.mapping.confirm({ select = true }),
    ['<C-q>'] = cmp.mapping.abort(),
  },
  sources = cmp.config.sources({
    { name = "nvim_lsp" },
    { name = 'nvim_lsp_signature_help' },
    { name = "luasnip" },
    { name = "buffer" },
    { name = "path" },
  }),
  formatting = {
    format = function(entry, vim_item)
      local icons = {
        nvim_lsp = "",
        luasnip = "",
        buffer = "",
        path = "",
      }
      vim_item.kind = string.format("%s %s", icons[entry.source.name] or "", vim_item.kind)
      return vim_item
    end,
  },
})

-- LSP-related key mappings.
vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { desc = "Rename variable" })
vim.keymap.set("n", "<leader>F", function()
  vim.lsp.buf.format { async = true }
end, { desc = "Format code" })

-- Hover over symbol to show documentation.
vim.keymap.set("n", "K", vim.lsp.buf.hover, { desc = "Show documentation" })

-- Show code actions (e.g., quick fixes, refactorings).
vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "Show code actions" })

--------------------------------------------------------------------------------
-- Treesitter Context
--------------------------------------------------------------------------------
require("treesitter-context").setup({
  enable = true,
  max_lines = 3,
  min_window_height = 10,
  mode = "cursor",
  separator = "─"
})

--------------------------------------------------------------------------------
-- VirtColumn
--------------------------------------------------------------------------------
require("virt-column").setup({
  char = "│",
  highlight = "VertSplit"
})

--------------------------------------------------------------------------------
-- END OF CONFIGURATION
--------------------------------------------------------------------------------
