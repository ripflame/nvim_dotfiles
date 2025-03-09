--------------------------------------------------------------------------------
-- Lazy.nvim Plugin Manager Setup
--------------------------------------------------------------------------------
-- Ensure Lazy.nvim is installed.
-- Lazy.nvim is used to manage your plugins.
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git", "clone", "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git", "--branch=stable", lazypath
  })
end
-- Prepend Lazy.nvim to the runtime path so Neovim can load it.
vim.opt.rtp:prepend(lazypath)

--------------------------------------------------------------------------------
-- GENERAL SETTINGS
--------------------------------------------------------------------------------
vim.api.nvim_create_autocmd("BufReadPost", {
  pattern = "*",
  callback = function()
    if vim.fn.exists(":LspStart") == 2 then
      vim.cmd("LspStart")
    end -- Start LSP automatically
  end,
})
vim.defer_fn(function()
  vim.cmd("LspStart")
end, 100)
vim.api.nvim_create_autocmd("FileType", {
  pattern = "html",
  callback = function()
    vim.bo.syntax = "javascript"
  end,
})
vim.api.nvim_create_autocmd("BufEnter", {
  pattern = "*.html",
  callback = function()
    vim.cmd("syntax sync fromstart")
    vim.cmd("set filetype=html.javascript")
  end,
})


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

-- Set line numbering: absolute and relative.
vim.opt.number = true
vim.opt.relativenumber = true

-- Indentation settings.
vim.opt.tabstop = 2      -- Number of spaces per Tab.
vim.opt.shiftwidth = 2   -- Number of spaces for each indentation.
vim.opt.expandtab = true -- Convert Tabs to spaces.

-- Enable true color support.
vim.opt.termguicolors = true

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

--------------------------------------------------------------------------------
-- SYNTAX & COLORSCHEME
--------------------------------------------------------------------------------
-- Enable syntax highlighting.
vim.cmd("syntax on")

--------------------------------------------------------------------------------
-- LEADER KEY SETTING
--------------------------------------------------------------------------------
-- Set the leader key to comma.
vim.g.mapleader = ","

--------------------------------------------------------------------------------
-- BASIC KEY MAPPINGS
--------------------------------------------------------------------------------
-- Open the built-in file explorer (netrw) using <leader>pv.
vim.keymap.set("n", "<leader>s", vim.cmd.Ex, { desc = "Open file explorer" })

--------------------------------------------------------------------------------
-- SCROLLING MAPPINGS (Smooth scrolling with Ctrl+e / Ctrl+y)
--------------------------------------------------------------------------------
vim.keymap.set("n", "<C-e>", "3<C-e>", { noremap = true, desc = "Scroll down 3 lines" })
vim.keymap.set("n", "<C-y>", "3<C-y>", { noremap = true, desc = "Scroll up 3 lines" })

--------------------------------------------------------------------------------
-- SEARCH HIGHLIGHT TOGGLE
--------------------------------------------------------------------------------
-- Toggle search highlight (clear highlighting) with //.
vim.keymap.set("n", "//", ":nohlsearch<CR>", { silent = true, desc = "Clear search highlight" })

--------------------------------------------------------------------------------
-- QUICK END-OF-LINE SEMICOLON INSERTION
--------------------------------------------------------------------------------
-- Append a semicolon at the end of the current line:
-- Moves to end of line in Insert mode (A), types ";" then returns to Normal mode.
vim.keymap.set("n", ";;", "A;<ESC>", { silent = true, desc = "Append semicolon at end of line" })

--------------------------------------------------------------------------------
-- TRIM TRAILING WHITESPACE
--------------------------------------------------------------------------------
-- Remove trailing whitespace on demand using <leader>t.
vim.keymap.set("n", "<leader>t", ":%s/\\s\\+$//<CR>", { silent = true, desc = "Trim trailing whitespace" })

--------------------------------------------------------------------------------
-- WINDOW NAVIGATION MAPPINGS
--------------------------------------------------------------------------------
-- Better window navigation using Ctrl + (H, J, K, L).
vim.keymap.set("n", "<C-J>", "<C-W><C-J>", { noremap = true, desc = "Move to window below" })
vim.keymap.set("n", "<C-K>", "<C-W><C-K>", { noremap = true, desc = "Move to window above" })
vim.keymap.set("n", "<C-L>", "<C-W><C-L>", { noremap = true, desc = "Move to window right" })
vim.keymap.set("n", "<C-H>", "<C-W><C-H>", { noremap = true, desc = "Move to window left" })

--------------------------------------------------------------------------------
-- EMACS-LIKE NAVIGATION IN INSERT MODE
--------------------------------------------------------------------------------
-- In insert mode, use Ctrl+b to move left, Ctrl+f to move right, and Ctrl+e to go to the end of the line.
vim.keymap.set("i", "<C-b>", "<Left>", { desc = "Move cursor left" })
vim.keymap.set("i", "<C-f>", "<Right>", { desc = "Move cursor right" })
vim.keymap.set("i", "<C-e>", "<End>", { desc = "Move cursor to end of line" })

--------------------------------------------------------------------------------
-- OPEN CURRENT DIRECTORY IN EXPLORER (WINDOWS-SPECIFIC)
--------------------------------------------------------------------------------
-- Open the current working directory in Windows Explorer.
local open_cmd = vim.loop.os_uname().sysname == "Windows_NT" and "explorer ." or "open ."

vim.keymap.set("n", "<leader>o", ":!" .. open_cmd .. "<CR>", {
  noremap = true,
  silent = true,
  desc = "Open current directory in file manager",
})

--------------------------------------------------------------------------------
-- PLUGIN MANAGEMENT
--------------------------------------------------------------------------------
-- Load your plugins via Lazy.nvim using the plugins defined in plugins.lua.
require("lazy").setup("plugins")

-- Lualine settings
require("lualine").setup({
  options = {
    theme = "auto",
    icons_enabled = true,
    section_separators = { left = "", right = "" },
    component_separators = { left = "", right = "" },
  },
  sections = {
    lualine_a = { "mode" },
    lualine_b = { "branch", "diff", "diagnostics" },
    lualine_c = { { "filename", path = 2 } },
    lualine_x = { "encoding", "fileformat", "filetype" },
    lualine_y = { "progress" },
    lualine_z = { "location" },
  },
})

--------------------------------------------------------------------------------
-- LSP CONFIGURATION
--------------------------------------------------------------------------------
-- Load your LSP configuration from lsp.lua.
require("lsp")

--------------------------------------------------------------------------------
-- NVIM-CMP (AUTOCOMPLETION) SETUP
--------------------------------------------------------------------------------
local cmp = require("cmp")
cmp.setup({
  mapping = {
    -- Toggle autocompletion: if visible, close; if not, open completion menu.
    ['<C-e>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.close()
      else
        cmp.complete()
      end
    end, { "i", "s" }),
    -- Navigate completion items.
    ['<C-j>'] = cmp.mapping.select_next_item(),
    ['<C-k>'] = cmp.mapping.select_prev_item(),
    -- Confirm selection with Enter.
    ['<CR>'] = cmp.mapping.confirm({ select = true }),
    -- Abort completion with Ctrl+q.
    ['<C-q>'] = cmp.mapping.abort(),
  },
  sources = cmp.config.sources({
    { name = "nvim_lsp" },
    { name = "buffer" },
    { name = "path" },
  })
})

--------------------------------------------------------------------------------
-- LSP-RELATED MAPPINGS
--------------------------------------------------------------------------------
-- Rename variable using LSP.
vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { desc = "Rename variable" })

-- Format code using LSP.
vim.keymap.set("n", "<leader>F", function()
  vim.lsp.buf.format { async = true }
end, { desc = "Format code" })

--------------------------------------------------------------------------------
-- TELESCOPE KEYMAPS (FILE NAVIGATION)
--------------------------------------------------------------------------------
local builtin = require("telescope.builtin")
vim.keymap.set("n", "<leader>ff", function()
  require("telescope.builtin").find_files({
    hidden = true,
    find_command = { "rg", "--files", "--hidden", "--glob", "!.git/*" }
  })
end, { desc = "Find hidden files" })
-- vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Find files" })
vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Grep text" })
vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Find buffers" })

--------------------------------------------------------------------------------
-- CUSTOM MAPPINGS & SCRIPTS (FROM OLD CONFIG)
--------------------------------------------------------------------------------
-- Terminal command: open a terminal in a horizontal split.
vim.cmd([[
  command! OpenTerminal split | terminal
]])
vim.keymap.set("n", "<leader>ev", function()
  vim.cmd("e " .. vim.fn.stdpath("config") .. "/init.lua")
end, { silent = true })

--------------------------------------------------------------------------------
-- END OF CONFIGURATION
--------------------------------------------------------------------------------
