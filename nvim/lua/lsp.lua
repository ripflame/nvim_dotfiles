local lspconfig = require("lspconfig")
local cmp_lsp = require("cmp_nvim_lsp")
local capabilities = cmp_lsp.default_capabilities()

lspconfig.ts_ls.setup({
  capabilities = capabilities,
  -- This is the official name in nvim-lspconfig for TypeScript
  cmd = { "typescript-language-server", "--stdio" },
  filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact", "html" },
  on_attach = function(client, bufnr)
    print("LSP ts_ls attached to buffer " .. bufnr)
    client.server_capabilities.documentFormattingProvider = false
  end,
})

-- Other LSP servers
lspconfig.html.setup({ capabilities = capabilities })
lspconfig.cssls.setup({ capabilities = capabilities })
lspconfig.jsonls.setup({ capabilities = capabilities })
lspconfig.pyright.setup({ capabilities = capabilities })
lspconfig.lua_ls.setup({ capabilities = capabilities })

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

require 'lspconfig'.emmet_ls.setup {
  filetypes = { 'html', 'css', 'scss', 'javascriptreact', 'typescriptreact', 'javascript', 'typescript' },
  init_options = {
    showExpandedAbbreviation = "always",
    showAbbreviationSuggestions = true,
    syntaxProfiles = {},
    variables = {},
  }
}
