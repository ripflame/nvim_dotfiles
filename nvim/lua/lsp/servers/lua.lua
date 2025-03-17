--------------------------------------------------------------------------------
-- LUA LSP CONFIGURATION
--------------------------------------------------------------------------------

local lspconfig = require("lspconfig")
local lsp = require("lsp")

lspconfig.lua_ls.setup({
  capabilities = lsp.capabilities,
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
        checkThirdParty = false, -- Disable prompt about third-party libraries
      },
      telemetry = {
        enable = false,
      },
    },
  },
})
