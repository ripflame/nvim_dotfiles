-- Formatting configuration - Compatible with Native LSP
return {
  "nvimtools/none-ls.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    local null_ls = require("null-ls")
    
    -- Only configure formatters that are available
    local sources = {}
    
    -- Check if black is available for Python formatting
    if vim.fn.executable("black") == 1 then
      table.insert(sources, null_ls.builtins.formatting.black)
    end
    
    -- Check if prettier/prettierd is available for JS/TS/web formatting
    if vim.fn.executable("prettierd") == 1 then
      table.insert(sources, null_ls.builtins.formatting.prettierd.with({
        filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact",
          "vue", "css", "scss", "less", "html", "json", "jsonc", "yaml", "markdown",
          "markdown.mdx", "graphql", "handlebars", "svelte", "astro", "htmlangular", "txt" },
        extra_args = { "--print-width", "80" },
      }))
    elseif vim.fn.executable("prettier") == 1 then
      table.insert(sources, null_ls.builtins.formatting.prettier.with({
        filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact",
          "vue", "css", "scss", "less", "html", "json", "jsonc", "yaml", "markdown",
          "markdown.mdx", "graphql", "handlebars", "svelte", "astro", "htmlangular", "txt" },
        extra_args = { "--print-width", "80" },
      }))
    end
    
    null_ls.setup({
      sources = sources,
    })
  end,
}