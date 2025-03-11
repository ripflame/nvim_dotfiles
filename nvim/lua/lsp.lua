local lspconfig = require("lspconfig")
local cmp_lsp = require("cmp_nvim_lsp")

-- Define LSP capabilities with snippet support.
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

--------------------------------------------------------------------------------
-- TypeScript/JavaScript LSP (ts_ls)
--------------------------------------------------------------------------------
lspconfig.ts_ls.setup({
  capabilities = capabilities,
  cmd = { "typescript-language-server", "--stdio" },
  filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact", "html" },
  on_attach = function(client, bufnr)
    print("LSP ts_ls attached to buffer " .. bufnr)
    client.server_capabilities.documentFormattingProvider = false
  end,
  init_options = {
    preferences = {
      includeCompletionsForModuleExports = true,
      includeCompletionsWithInsertText = true,
    },
  },
})

--------------------------------------------------------------------------------
-- HTML LSP
--------------------------------------------------------------------------------
lspconfig.html.setup({
  capabilities = capabilities,
  on_attach = function(client, bufnr)
    -- Disable HTML LSP's completion provider to avoid conflicts.
    client.server_capabilities.completionProvider = false
  end,
  filetypes = { "html" },
})

--------------------------------------------------------------------------------
-- CSS LSP
--------------------------------------------------------------------------------
lspconfig.cssls.setup({ capabilities = capabilities })

--------------------------------------------------------------------------------
-- JSON LSP
--------------------------------------------------------------------------------
lspconfig.jsonls.setup({ capabilities = capabilities })

--------------------------------------------------------------------------------
-- Python LSP (pyright)
--------------------------------------------------------------------------------
lspconfig.pyright.setup({ capabilities = capabilities })

--------------------------------------------------------------------------------
-- Lua LSP (lua_ls)
--------------------------------------------------------------------------------
lspconfig.lua_ls.setup({
  capabilities = capabilities,
  settings = {
    Lua = {
      diagnostics = {
        globals = { "vim" }, -- Tells the LSP that `vim` is a valid global.
      },
      workspace = {
        library = {
          [vim.fn.expand("$VIMRUNTIME/lua")] = true,
          [vim.fn.stdpath("config") .. "/lua"] = true,
        },
      },
    },
  },
})

--------------------------------------------------------------------------------
-- Emmet LSP (for HTML and CSS)
--------------------------------------------------------------------------------
require 'lspconfig'.emmet_ls.setup {
  filetypes = { 'html', 'css', 'scss' },
  init_options = {
    showExpandedAbbreviation = "always",
    showAbbreviationSuggestions = true,
    syntaxProfiles = {},
    variables = {},
  }
}
