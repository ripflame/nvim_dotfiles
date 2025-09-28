return {
	"stevearc/conform.nvim",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		require("conform").setup({
			formatters_by_ft = {
				python = { "black" },
				javascript = { "prettier" },
				javascriptreact = { "prettier" },
				typescript = { "prettier" },
				typescriptreact = { "prettier" },
				vue = { "prettier" },
				css = { "prettier" },
				scss = { "prettier" },
				less = { "prettier" },
				html = { "prettier" },
				json = { "prettier" },
				jsonc = { "prettier" },
				yaml = { "prettier" },
				markdown = { "prettier" },
				graphql = { "prettier" },
				handlebars = { "prettier" },
				svelte = { "prettier" },
				astro = { "prettier" },
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
							return "black" -- fallback
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
				prettier = {
					command = "prettier",
					args = { "--stdin-filepath", "$FILENAME", "--print-width", "120", "--prose-wrap", "always" },
					stdin = true,
				},
			},
		})
	end,
}
