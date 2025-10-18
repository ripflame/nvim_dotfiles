return {
  "kevinhwang91/nvim-ufo",
  dependencies = {
    "kevinhwang91/promise-async"
  },
  event = "BufReadPost",
  opts = {
    open_fold_hl_timeout = 0,
    close_fold_kinds = {},
    provider_selector = function(bufnr, filetype, _)
      -- Force indent for known problematic filetypes
      local force_indent = { html = true, xml = true }

      if force_indent[filetype] then
        return { "indent" }
      end

      local clients = vim.lsp.get_clients({ bufnr = bufnr })
      for _, client in ipairs(clients) do
        if client.server_capabilities and client.server_capabilities.foldingRangeProvider then
          return { "lsp", "marker", "indent" } -- Use LSP if available, then marker, then indent
        end
      end

      return { "marker", "indent" } -- Fallback to marker and indent if no LSP folding
    end
  }
}