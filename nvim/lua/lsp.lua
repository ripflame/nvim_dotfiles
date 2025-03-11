local lspconfig = require("lspconfig")
local cmp_lsp = require("cmp_nvim_lsp")
-- local capabilities = cmp_lsp.default_capabilities()
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true


-- Configure ts_ls for JavaScript and TypeScript
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

-- Configure html-lsp for HTML files
lspconfig.html.setup({
  capabilities = capabilities,
  on_attach = function(client, bufnr)
    -- Disable HTML LSP's completion provider to avoid conflicts
    client.server_capabilities.completionProvider = false
  end,
  filetypes = { "html" },
})

-- Other LSP servers
lspconfig.cssls.setup({ capabilities = capabilities })
lspconfig.jsonls.setup({ capabilities = capabilities })
lspconfig.pyright.setup({ capabilities = capabilities })
lspconfig.lua_ls.setup({ capabilities = capabilities })

-- Configure Lua LSP
lspconfig.lua_ls.setup({
  capabilities = capabilities,
  settings = {
    Lua = {
      diagnostics = {
        globals = { "vim" }, -- Tells the LSP that `vim` is a valid global
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

-- Optional: Re-enable Emmet LSP for HTML and CSS
require 'lspconfig'.emmet_ls.setup {
  filetypes = { 'html', 'css', 'scss' }, -- Limit Emmet to HTML and CSS
  init_options = {
    showExpandedAbbreviation = "always",
    showAbbreviationSuggestions = true,
    syntaxProfiles = {},
    variables = {},
  }
}
