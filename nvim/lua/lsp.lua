-- Set up Mason and Mason-lspconfig before anything
require("mason").setup({
    ui = {
        icons = {
            package_installed = "+",
            package_pending = ">",
            package_uninstalled = "-"
        }
    }
})

-- Servers that must always be installed
require("mason-lspconfig").setup({
  ensure_installed = {
    "ts_ls",
    "html",
    "cssls",
    "jsonls",
    "pyright",
    "lua_ls",
    "emmet_ls",
    "marksman"

  }
})

local lspconfig = require("lspconfig")
local cmp_lsp = require("cmp_nvim_lsp")

-- Set up default capabilities with snippet support and folding, integrating cmp_nvim_lsp
local capabilities = require('cmp_nvim_lsp').default_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities.textDocument.foldingRange = {
  dynamicRegistration = false,
  lineFoldingOnly = true
}

-- Setup handlers for Mason-lspconfig
require("mason-lspconfig").setup_handlers({
  --Default handler
  function(server_name)
    lspconfig[server_name].setup({
      capabilities = capabilities
    })
  end,

  -- TypeScript/JavaScript LSP (override with your custom settings)
  ["ts_ls"] = function()
    lspconfig.ts_ls.setup({
      capabilities = capabilities,
      -- cmd = { "typescript-language-server", "--stdio" },
      filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact", "html" },
      on_attach = function(client, bufnr)
        -- print("LSP ts_ls attached to buffer " .. bufnr)
        -- client.server_capabilities.documentFormattingProvider = false
      end,
      init_options = {
        preferences = {
          includeCompletionsForModuleExports = true,
          includeCompletionsWithInsertText = true,
        },
      },
    })
  end,

  -- Lua LSP with your custom settings
  ["lua_ls"] = function()
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
  end,

  -- -- HTML LSP custom cmd
  -- ["html"] = function()
  --   lspconfig.html.setup({
  --     capabilities = capabilities,
  --     cmd = { "html-languageserver", "--stdio" },
  --   })
  -- end,

  -- Emmet LSP with your custom settings
  ["emmet_ls"] = function()
    lspconfig.emmet_ls.setup({
      capabilities = capabilities,
      filetypes = { 'html', 'css', 'scss' },
      init_options = {
        showExpandedAbbreviation = "always",
        showAbbreviationSuggestions = true,
        syntaxProfiles = {},
        variables = {},
      }
    })
  end,
})
