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
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "python", "lua", "javascript", "typescript" },
  callback = function()
    vim.o.colorcolumn = "100"
  end
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "markdown", "text" },
  callback = function()
    vim.o.colorcolumn = "80" -- Keep prose at readable lengths
  end
})

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
-- vim.opt.scrolloff = 8

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
-- Use Treesitter for folding (change to "indent" if needed)
vim.o.foldmethod = "expr"
vim.o.foldexpr = "nvim_treesitter#foldexpr()"

-- Keep folds open by default on first open but never force them open later
vim.o.foldenable = true   -- Folding is enabled, but doesn't auto-collapse
vim.o.foldlevel = 99      -- Keeps everything open by default
vim.o.foldlevelstart = 99 -- Prevents auto-collapsing on file open
vim.o.foldcolumn = "1"    -- Show fold column for easier manual toggling

-- Auto-save and restore folds (Prevents folds from resetting)
-- Auto-save folds, but only if the buffer has a valid file name
vim.api.nvim_create_autocmd("BufWinLeave", {
  pattern = "*",
  callback = function()
    if vim.fn.expand("%") ~= "" and vim.bo.buftype == "" then
      vim.cmd("silent! mkview")
    end
  end
})

-- Restore folds, but only if the buffer has a valid file name
vim.api.nvim_create_autocmd("BufWinEnter", {
  pattern = "*",
  callback = function()
    if vim.fn.expand("%") ~= "" and vim.bo.buftype == "" then
      vim.cmd("silent! loadview")
    end
  end
})

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
  max_lines = 4,
  min_window_height = 5,
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

local highlight = {
    "RainbowRed",
    "RainbowYellow",
    "RainbowBlue",
    "RainbowOrange",
    "RainbowGreen",
    "RainbowViolet",
    "RainbowCyan",
}

local hooks = require "ibl.hooks"
-- create the highlight groups in the highlight setup hook, so they are reset
-- every time the colorscheme changes
hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
    vim.api.nvim_set_hl(0, "RainbowRed", { fg = "#E06C75" })
    vim.api.nvim_set_hl(0, "RainbowYellow", { fg = "#E5C07B" })
    vim.api.nvim_set_hl(0, "RainbowBlue", { fg = "#61AFEF" })
    vim.api.nvim_set_hl(0, "RainbowOrange", { fg = "#D19A66" })
    vim.api.nvim_set_hl(0, "RainbowGreen", { fg = "#98C379" })
    vim.api.nvim_set_hl(0, "RainbowViolet", { fg = "#C678DD" })
    vim.api.nvim_set_hl(0, "RainbowCyan", { fg = "#56B6C2" })
end)

require("ibl").setup { indent = { highlight = highlight } }

--------------------------------------------------------------------------------
-- END OF CONFIGURATION
--------------------------------------------------------------------------------
