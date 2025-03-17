---------------------------------------------------------------------------------------------------
-- GENERAL SETTINGS AND OPTIONS
---------------------------------------------------------------------------------------------------

-- Syntax and file type-related settings
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "python", "lua", "javascript", "typescript" },
  callback = function()
    vim.o.colorcolumn = "100"
  end
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "markdown", "text" },
  callback = function()
    vim.o.colorcolumn = "100" -- Keep prose at readable lengths
  end
})

-- UI settings
vim.opt.termguicolors = true        -- Enable true color support
vim.opt.signcolumn = 'yes'          -- Always show sign column
vim.opt.number = true               -- Show line numbers
vim.opt.relativenumber = true       -- Show relative line numbers
vim.opt.cursorline = true           -- Highlight current line
vim.opt.wrap = false                -- Disable line wrapping
vim.opt.mouse = "a"                 -- Enable mouse support in all modes

-- Indentation settings
vim.opt.tabstop = 2                 -- Width of a tab character
vim.opt.shiftwidth = 2              -- Width for autoindents
vim.opt.expandtab = true            -- Convert tabs to spaces
vim.opt.smartindent = true          -- Smart indentation

-- Search settings
vim.opt.incsearch = true            -- Show search matches as you type
vim.opt.ignorecase = true           -- Ignore case during search
vim.opt.smartcase = true            -- Unless uppercase character is used
vim.opt.hlsearch = true             -- Highlight all search matches

-- System integration
vim.opt.clipboard = "unnamedplus"   -- Use system clipboard

-- Fold settings
vim.o.foldmethod = "expr"           -- Use expression for folding
vim.o.foldexpr = "nvim_treesitter#foldexpr()"
vim.o.foldenable = true             -- Enable folding
vim.o.foldlevel = 99                -- Keep everything open by default
vim.o.foldlevelstart = 99           -- Prevents auto-collapsing on file open
vim.o.foldcolumn = "1"              -- Show fold column

-- Auto-save and restore folds (Prevents folds from resetting)
vim.api.nvim_create_autocmd("BufWinLeave", {
  pattern = "*",
  callback = function()
    if vim.fn.expand("%") ~= "" and vim.bo.buftype == "" then
      vim.cmd("silent! mkview")
    end
  end
})

vim.api.nvim_create_autocmd("BufWinEnter", {
  pattern = "*",
  callback = function()
    if vim.fn.expand("%") ~= "" and vim.bo.buftype == "" then
      vim.cmd("silent! loadview")
    end
  end
})

-- Neovide GUI settings
if vim.g.neovide then
  -- Detect OS
  local is_windows = vim.fn.has("win32") == 1
  local is_mac = vim.fn.has("macunix") == 1

  -- Set font list based on OS
  local font = "SauceCodePro Nerd Font:h16" -- Default font
  if is_windows then
    font = "SauceCodePro Nerd Font:h14"     -- Smaller font on Windows
  elseif is_mac then
    font = "SauceCodePro Nerd Font:h16"     -- Larger font on macOS
  else
    font = "Monospace:h14"                  -- Generic fallback for Linux
  end

  vim.o.guifont = font
  vim.g.neovide_scale_factor = .90
end
