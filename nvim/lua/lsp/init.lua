--------------------------------------------------------------------------------
-- LSP CONFIGURATION
--------------------------------------------------------------------------------

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

-- Load individual LSP configurations
require("lsp.servers.typescript")
require("lsp.servers.web")  -- HTML, CSS, JSON, Emmet
require("lsp.servers.python")
require("lsp.servers.lua")
require("lsp.servers.markdown")

-- Configure folding with UFO (Unfolded)
require("ufo").setup({
  open_fold_hl_timeout = 0,
  close_fold_kinds = {},
  provider_selector = function(bufnr, filetype, _)
    -- Force indent for known problematic filetypes
    local force_indent = { html = true, xml = true }

    if force_indent[filetype] then
      return { "indent" }
    end

    local clients = vim.lsp.get_active_clients({ bufnr = bufnr })
    for _, client in ipairs(clients) do
      if client.server_capabilities and client.server_capabilities.foldingRangeProvider then
        return { "lsp", "indent" } -- Use LSP if available
      end
    end

    return { "indent" } -- Fallback to indent if no LSP folding
  end
})

-- Export capabilities for use in individual LSP configurations
return {
  capabilities = capabilities
}
