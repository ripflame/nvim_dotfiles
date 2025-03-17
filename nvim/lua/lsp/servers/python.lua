--------------------------------------------------------------------------------
-- PYTHON LSP CONFIGURATION
--------------------------------------------------------------------------------

local lspconfig = require("lspconfig")
local lsp = require("lsp")

lspconfig.pyright.setup({
  capabilities = lsp.capabilities,
  settings = {
    python = {
      analysis = {
        autoSearchPaths = true,
        diagnosticMode = "workspace",
        useLibraryCodeForTypes = true
      }
    }
  }
})
