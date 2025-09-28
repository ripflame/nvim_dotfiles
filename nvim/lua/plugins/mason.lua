-- Mason for LSP server management - Native LSP Integration
return {
  "mason-org/mason.nvim",
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
      "python-lsp-server",           -- for pylsp (replaces pyright)
      "lua-language-server",         -- for lua_ls
      "emmet-ls",                    -- for emmet_ls
      "marksman",                    -- for marksman
      -- Formatters
      "black",                       -- Python formatter
      "prettier",                    -- JS/TS/HTML/CSS formatter
      "stylua",                      -- Lua formatter
    }
    
    -- Install servers if not already installed
    for _, server in ipairs(servers) do
      local package = mason_registry.get_package(server)
      if not package:is_installed() then
        package:install()
      end
    end
  end
}