local lspconfig = require("lspconfig")
local cmp_lsp = require("cmp_nvim_lsp")

-- Set up default capabilities for LSP servers, integrating cmp_nvim_lsp.
local lspconfig_defaults = require('lspconfig').util.default_config
lspconfig_defaults.capabilities = vim.tbl_deep_extend(
  'force',
  lspconfig_defaults.capabilities,
  require('cmp_nvim_lsp').default_capabilities()
)

-- Define LSP capabilities with snippet support.
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities.textDocument.foldingRange = {
  dynamicRegistration = false,
  lineFoldingOnly = true
}

--------------------------------------------------------------------------------
-- LSP-based or indendt-base folding
--------------------------------------------------------------------------------
require("ufo").setup({
  open_fold_hl_timeout = 0,
  close_fold_kinds = {},
  provider_selector = function(_, _, _)
    if filetype == "html" then
      return { "indent" }
    else
      return {"lsp", "indent" }
    end

  end
})

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
  cmd = { "html-languageserver", "--stdio" },
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

--------------------------------------------------------------------------------
-- Marksman LSP (For Markdown)
--------------------------------------------------------------------------------
require('lspconfig').marksman.setup({
  capabilities = capabilities,
})

--------------------------------------------------------------------------------
-- LSP Keybindings (Active only when LSP is attached)
--------------------------------------------------------------------------------
-- Create an autocmd that triggers when an LSP client attaches to a buffer.
vim.api.nvim_create_autocmd('LspAttach', {
  desc = 'LSP actions', -- Description for the autocmd
  callback = function(event)
    -- Define options for keybindings, scoped to the current buffer.
    local opts = { buffer = event.buf }

    -- Keybinding: Go to the definition of the symbol under the cursor.
    vim.keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>', opts)

    -- Keybinding: Go to the declaration of the symbol under the cursor.
    vim.keymap.set('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>', opts)

    -- Keybinding: Go to the implementation of the symbol under the cursor.
    vim.keymap.set('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>', opts)

    -- Keybinding: Go to the type definition of the symbol under the cursor.
    vim.keymap.set('n', 'go', '<cmd>lua vim.lsp.buf.type_definition()<cr>', opts)

    -- Keybinding: Show all references to the symbol under the cursor.
    vim.keymap.set('n', 'gr', '<cmd>lua vim.lsp.buf.references()<cr>', opts)

    -- Keybinding: Show signature help (e.g., function parameters) for the symbol under the cursor.
    vim.keymap.set('n', 'gs', '<cmd>lua vim.lsp.buf.signature_help()<cr>', opts)
  end,
})
