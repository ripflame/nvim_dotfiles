--------------------------------------------------------------------------------
-- MARKDOWN LSP CONFIGURATION
--------------------------------------------------------------------------------

local lspconfig = require("lspconfig")
local lsp = require("lsp")

lspconfig.marksman.setup({
  capabilities = lsp.capabilities,
  filetypes = { 'markdown', 'markdown.mdx' },
})
