---------------------------------------------------------------------------------------------------
-- TypeScript/JavaScript LSP CONFIGURATION
---------------------------------------------------------------------------------------------------

local lspconfig = require("lspconfig")
local lsp = require("lsp")

lspconfig.ts_ls.setup({
  capabilities = lsp.capabilities,
  cmd = { "typescript-language-server", "--stdio" },
  filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact", "html" },
  on_attach = function(client, bufnr)
    print("LSP tsserver attached to buffer " .. bufnr)
    -- Disable tsserver formatting in favor of null-ls/prettier
    client.server_capabilities.documentFormattingProvider = false
  end,
  init_options = {
    preferences = {
      includeCompletionsForModuleExports = true,
      includeCompletionsWithInsertText = true,
    },
  },
})
