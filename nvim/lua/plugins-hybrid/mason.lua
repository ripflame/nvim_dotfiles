-- Mason for LSP server management - Pure Native LSP Integration
return {
  -- Mason for automatic LSP server installation and updates
  "williamboman/mason.nvim",
  config = function()
    require("mason").setup({
      ui = {
        icons = {
          package_installed = "✓",
          package_pending = "➜", 
          package_uninstalled = "✗"
        }
      }
    })
    
    -- Auto-install LSP servers for native LSP configuration
    local mason_registry = require("mason-registry")
    
    local servers = {
      "typescript-language-server",  -- for ts_ls
      "html-lsp",                    -- for html  
      "css-lsp",                     -- for cssls
      "json-lsp",                    -- for jsonls
      "pyright",                     -- for pyright
      "lua-language-server",         -- for lua_ls
      "emmet-ls",                    -- for emmet_ls
      "marksman",                    -- for marksman
    }
    
    -- Install servers if not already installed
    for _, server in ipairs(servers) do
      local package = mason_registry.get_package(server)
      if not package:is_installed() then
        package:install()
      end
    end
    
    -- Emit MasonReady event after setup
    vim.schedule(function()
      vim.api.nvim_exec_autocmds("User", { pattern = "MasonReady" })
    end)
  end
}