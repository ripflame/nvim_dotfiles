return {
  "stevearc/conform.nvim",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    require("conform").setup({
      formatters_by_ft = {
        python = { "black" },
        javascript = { "prettierd", "prettier", stop_after_first = true },
        javascriptreact = { "prettierd", "prettier", stop_after_first = true },
        typescript = { "prettierd", "prettier", stop_after_first = true },
        typescriptreact = { "prettierd", "prettier", stop_after_first = true },
        vue = { "prettierd", "prettier", stop_after_first = true },
        css = { "prettierd", "prettier", stop_after_first = true },
        scss = { "prettierd", "prettier", stop_after_first = true },
        less = { "prettierd", "prettier", stop_after_first = true },
        html = { "prettierd", "prettier", stop_after_first = true },
        json = { "prettierd", "prettier", stop_after_first = true },
        jsonc = { "prettierd", "prettier", stop_after_first = true },
        yaml = { "prettierd", "prettier", stop_after_first = true },
        markdown = { "prettierd", "prettier", stop_after_first = true },
        graphql = { "prettierd", "prettier", stop_after_first = true },
        handlebars = { "prettierd", "prettier", stop_after_first = true },
        svelte = { "prettierd", "prettier", stop_after_first = true },
        astro = { "prettierd", "prettier", stop_after_first = true },
        lua = { "stylua" },
      },
      format_on_save = false,
      formatters = {
        -- Use system black if available, fallback to pip install
        black = {
          command = function()
            -- Try Mason first, then system python -m black
            local mason_black = vim.fn.stdpath("data") .. "/mason/bin/black"
            if vim.fn.executable(mason_black) == 1 then
              return mason_black
            elseif vim.fn.executable("python3") == 1 then
              return "python3"
            else
              return "black"  -- fallback
            end
          end,
          args = function()
            local mason_black = vim.fn.stdpath("data") .. "/mason/bin/black"
            if vim.fn.executable(mason_black) == 1 then
              return { "--stdin-filename", "$FILENAME", "-" }
            else
              return { "-m", "black", "--stdin-filename", "$FILENAME", "-" }
            end
          end,
          stdin = true,
        },
        -- Use system prettier if prettierd fails
        prettier = {
          command = "prettier",
          args = { "--stdin-filepath", "$FILENAME", "--print-width", "80" },
          stdin = true,
        },
      },
    })
  end,
}