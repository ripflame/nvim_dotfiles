---------------------------------------------------------------------------------------------------
-- KEY MAPPINGS
---------------------------------------------------------------------------------------------------

-- Helper function for easier key mapping
local map = function(mode, key, cmd, opts)
  local options = { noremap = true, silent = true }
  if opts then options = vim.tbl_extend("force", options, opts) end
  vim.keymap.set(mode, key, cmd, options)
end

-- General mappings
map("n", "<leader>cc", ":cclose<CR>", { desc = "Close quickfix window" })
map("n", "<leader>s", ":NvimTreeToggle<CR>", { desc = "Open file explorer" })
map("n", "//", ":nohlsearch<CR>", { desc = "Clear search highlight" })
map("n", ";;", "A;<ESC>", { desc = "Append semicolon at end of line" })
map("n", "<leader>t", ":%s/\\s\\+$//<CR>", { desc = "Trim trailing whitespace" })
map("n", "<leader>ev", function()
  vim.cmd("e " .. vim.fn.stdpath("config") .. "/init.lua")
end, { desc = "Edit init.lua" })

-- Window navigation
map("n", "<C-J>", "<C-W><C-J>", { desc = "Move to window below" })
map("n", "<C-K>", "<C-W><C-K>", { desc = "Move to window above" })
map("n", "<C-L>", "<C-W><C-L>", { desc = "Move to window right" })
map("n", "<C-H>", "<C-W><C-H>", { desc = "Move to window left" })

-- Tab navigation
map("n", "<C-t>", ":tabnew", { desc = "Open a new tab" })
map("n", "<C-Tab>", ":tabn<CR>", { desc = "Change to next tab" })

-- Scrolling
map("n", "<C-e>", "3<C-e>", { desc = "Scroll down 3 lines" })
map("n", "<C-y>", "3<C-y>", { desc = "Scroll up 3 lines" })

-- Insert mode navigation
map("i", "<C-b>", "<Left>", { desc = "Move cursor left" })
map("i", "<C-f>", "<Right>", { desc = "Move cursor right" })
map("i", "<C-e>", "<End>", { desc = "Move cursor to end of line" })

-- Open file manager
local open_cmd = vim.loop.os_uname().sysname == "Windows_NT" and "explorer ." or "open ."
map("n", "<leader>o", ":!" .. open_cmd .. "<CR>", { desc = "Open current directory in file manager" })

-- Terminal command
vim.cmd([[command! OpenTerminal split | terminal]])

-- Telescope mappings lazy loaded
map("n", "<leader>ff", function()
  require("telescope.builtin").find_files({
    hidden = true,
    find_command = { "rg", "--files", "--hidden", "--glob", "!.git/*" }
  })
end, { desc = "Find hidden files" })

map("n", "<leader>fg", function()
  require("telescope.builtin").live_grep()
end, { desc = "Grep text" })

map("n", "<leader>fb", function()
  require("telescope.builtin").buffers()
end, { desc = "Find buffers" })

-- LSP specific keymaps (these will be active when LSP attaches)
vim.api.nvim_create_autocmd('LspAttach', {
  desc = 'LSP actions',
  callback = function(event)
    -- Buffer-local mappings
    local opts = { buffer = event.buf }

    map("n", "gd", vim.lsp.buf.definition, opts)
    map("n", "gD", vim.lsp.buf.declaration, opts)
    map("n", "gi", vim.lsp.buf.implementation, opts)
    map("n", "go", vim.lsp.buf.type_definition, opts)
    map("n", "gr", vim.lsp.buf.references, opts)
    map("n", "gs", vim.lsp.buf.signature_help, opts)
    map("n", "K", vim.lsp.buf.hover, opts)
    map("n", "<leader>rn", vim.lsp.buf.rename, opts)
    map("n", "<leader>ca", vim.lsp.buf.code_action, opts)
    map("n", "<leader>F", function()
      vim.lsp.buf.format { async = true }
    end, opts)
  end,
})

-- Define commands for switching themes
vim.api.nvim_create_user_command("DARK",
  function()
    vim.opt.background = 'dark'
  end,
  {})

vim.api.nvim_create_user_command("LITE",
  function()
    vim.opt.background = 'light'
  end,
  {})
