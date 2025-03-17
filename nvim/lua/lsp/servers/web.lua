--------------------------------------------------------------------------------
-- WEB DEVELOPMENT LSP CONFIGURATIONS (HTML, CSS, JSON, Emmet)
--------------------------------------------------------------------------------

local lspconfig = require("lspconfig")
local lsp = require("lsp")

-- HTML LSP
lspconfig.html.setup({
  capabilities = lsp.capabilities,
  cmd = { "vscode-html-language-server", "--stdio" },
})

-- CSS LSP
lspconfig.cssls.setup({ 
  capabilities = lsp.capabilities,
  cmd = { "vscode-css-language-server", "--stdio" },
})

-- JSON LSP
lspconfig.jsonls.setup({ 
  capabilities = lsp.capabilities,
  cmd = { "vscode-json-language-server", "--stdio" },
})

-- Emmet LSP
lspconfig.emmet_ls.setup({
  capabilities = lsp.capabilities,
  filetypes = { 'html', 'css', 'scss', 'javascriptreact', 'typescriptreact' },
  init_options = {
    showExpandedAbbreviation = "always",
    showAbbreviationSuggestions = true,
    syntaxProfiles = {},
    variables = {},
  }
})
