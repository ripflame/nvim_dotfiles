---------------------------------------------------------------------------------------------------
-- KEY MAPPINGS - MINIMAL VERSION FOR NATIVE LSP TEST
---------------------------------------------------------------------------------------------------

-- Helper function for easier key mapping
local map = function(mode, key, cmd, opts)
  local options = { noremap = true, silent = true }
  if opts then options = vim.tbl_extend("force", options, opts) end
  vim.keymap.set(mode, key, cmd, options)
end

-- NAVIGATION
-- Window navigation
map("n", "<C-J>", "<C-W><C-J>", { desc = "Move to window below" })
map("n", "<C-K>", "<C-W><C-K>", { desc = "Move to window above" })
map("n", "<C-L>", "<C-W><C-L>", { desc = "Move to window right" })
map("n", "<C-H>", "<C-W><C-H>", { desc = "Move to window left" })

-- LSP COMMANDS
-- LSP specific keymaps (these will be active when LSP attaches)
vim.api.nvim_create_autocmd('LspAttach', {
  desc = 'LSP actions',
  callback = function(event)
    -- Buffer-local mappings
    local opts = { buffer = event.buf }

    local function map_with_desc(mode, key, cmd, description)
      local options = vim.tbl_extend("force", opts, { desc = description })
      map(mode, key, cmd, options)
    end

    map_with_desc("n", "gd", vim.lsp.buf.definition, "Go to Definition")
    map_with_desc("n", "gD", vim.lsp.buf.declaration, "Go to Declaration")
    map_with_desc("n", "gi", vim.lsp.buf.implementation, "Go to Implementation")
    map_with_desc("n", "gr", vim.lsp.buf.references, "Find References")
    map_with_desc("n", "K", vim.lsp.buf.hover, "Show Hover Documentation")
    map_with_desc("n", "<leader>rn", vim.lsp.buf.rename, "Rename Symbol")
    map_with_desc("n", "<leader>ca", vim.lsp.buf.code_action, "Code Actions")
    map_with_desc("n", "<leader>e", vim.diagnostic.open_float, "Show Diagnostic Message")
  end,
})