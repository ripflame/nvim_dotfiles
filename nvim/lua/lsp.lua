-- Set up Mason and Mason-lspconfig before anything
require("mason").setup({
  ui = {
    icons = {
      package_installed = "✓",
      package_pending = "➜",
      package_uninstalled = "✗"
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
