return {
  "nvimtools/none-ls.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    local null_ls = require("null-ls")
    null_ls.setup({
      sources = {
        null_ls.builtins.formatting.black,
        null_ls.builtins.formatting.prettierd.with({
          filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact",
            "vue", "css", "scss", "less", "html", "json", "jsonc", "yaml", "markdown",
            "markdown.mdx", "graphql", "handlebars", "svelte", "astro", "htmlangular", "txt" },
          extra_args = { "--print-width", "80" },
        }),
      },
    })
  end,
}