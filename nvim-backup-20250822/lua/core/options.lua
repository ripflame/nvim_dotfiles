---------------------------------------------------------------------------------------------------
-- GENERAL SETTINGS AND OPTIONS
---------------------------------------------------------------------------------------------------
local undodir = vim.fn.stdpath('data') .. '/undodir'

-- Create undodir if it doesn't exist
if not vim.loop.fs_stat(undodir) then
  vim.fn.mkdir(undodir, "p")
end

-- Set up permanent undo history
vim.opt.undofile = true    -- Enable persistent undo
vim.opt.undodir = undodir  -- Set undo directory
vim.opt.undolevels = 1000  -- Maximum number of changes that can be undone
vim.opt.undoreload = 10000 -- Maximum number of lines to save for undo on buffer reload

-- UI settings
vim.opt.termguicolors = true  -- Enable true color support
vim.opt.signcolumn = 'yes'    -- Always show sign column
vim.opt.number = true         -- Show line numbers
vim.opt.relativenumber = true -- Show relative line numbers
vim.opt.cursorline = true     -- Highlight current line
vim.opt.wrap = false          -- Disable line wrapping
vim.opt.mouse = "a"           -- Enable mouse support in all modes
vim.opt.scrolloff = 8         -- Scroll window 8 lines away
vim.o.colorcolumn = "80"      -- Keep prose at readable lengths

-- Indentation settings
vim.opt.tabstop = 2        -- Width of a tab character
vim.opt.shiftwidth = 2     -- Width for autoindents
vim.opt.expandtab = true   -- Convert tabs to spaces
vim.opt.smartindent = true -- Smart indentation

-- Search settings
vim.opt.incsearch = true  -- Show search matches as you type
vim.opt.ignorecase = true -- Ignore case during search
vim.opt.smartcase = true  -- Unless uppercase character is used
vim.opt.hlsearch = false   -- Highlight all search matches

-- Fold settings
vim.o.foldenable = true   -- Enable folding
vim.o.foldlevel = 99      -- Keep everything open by default
vim.o.foldlevelstart = 99 -- Prevents auto-collapsing on file open
vim.o.foldcolumn = "1"    -- Show fold column

-- Netrw configuration for left sidebar that closes on file selection
vim.g.netrw_liststyle = 3        -- Tree view
vim.g.netrw_banner = 0           -- Remove banner
vim.g.netrw_browse_split = 4     -- Open files in previous window
vim.g.netrw_winsize = 25         -- 25% of window
vim.g.netrw_keepdir = 0          -- Keep current directory synced
vim.g.netrw_fastbrowse = 0       -- Disable fast browsing
