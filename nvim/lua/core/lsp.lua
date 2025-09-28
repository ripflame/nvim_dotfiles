---------------------------------------------------------------------------------------------------
-- NATIVE LSP CONFIGURATION (NEOVIM 0.11+) - REPLACES nvim-lspconfig
---------------------------------------------------------------------------------------------------

-- Configure LSP servers using native vim.lsp.config() with Mason-installed servers
-- This approach gives us the benefits of Mason (auto-install/update) with native LSP configuration
-- that avoids nvim-lspconfig compatibility issues

-- Set up LSP capabilities for completion (enhanced by nvim-cmp)
local capabilities = vim.lsp.protocol.make_client_capabilities()

-- Helper function to get Mason-installed server path
local function mason_cmd(server_name)
	local mason_registry = require("mason-registry")
	if mason_registry.is_installed(server_name) then
		local pkg = mason_registry.get_package(server_name)
		return pkg:get_install_path()
	end
	return nil
end

-- Define on_attach function for all LSP servers
local function on_attach(client, bufnr)
	-- Only set custom keymaps that aren't provided by Neovim 0.11+ natively
	local opts = { buffer = bufnr, noremap = true, silent = true }

	-- Custom diagnostic keymaps (not provided by native LSP)
	vim.keymap.set(
		"n",
		"<leader>e",
		vim.diagnostic.open_float,
		vim.tbl_extend("force", opts, { desc = "Show Diagnostic Message" })
	)

	vim.keymap.set(
		"n",
		"<leader>q",
		vim.diagnostic.setqflist,
		vim.tbl_extend("force", opts, { desc = "Add Diagnostics to Location List" })
	)

	vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, vim.tbl_extend("force", opts, { desc = "Previous Diagnostic" }))

	vim.keymap.set("n", "]d", vim.diagnostic.goto_next, vim.tbl_extend("force", opts, { desc = "Next Diagnostic" }))

	-- Custom formatting keymap
	vim.keymap.set("n", "<leader>F", function()
		require("conform").format({ async = true, lsp_fallback = true })
	end, vim.tbl_extend("force", opts, { desc = "Format Document" }))

	-- Custom telescope integration
	vim.keymap.set("n", "gp", function()
		require("telescope.builtin").lsp_definitions({
			jump_type = "never",
			preview = { hide_on_edit = true },
		})
	end, vim.tbl_extend("force", opts, { desc = "Peek definition on telescope" }))
end

-- Configure LSP servers using the proper 0.11 API with on_attach
vim.lsp.config.ts_ls = {
	cmd = { vim.fn.stdpath("data") .. "/mason/bin/typescript-language-server", "--stdio" },
	filetypes = { "javascript", "typescript", "javascriptreact", "typescriptreact" },
	root_markers = { "package.json", "tsconfig.json", "jsconfig.json" },
	capabilities = capabilities,
	on_attach = on_attach,
}

vim.lsp.config.html = {
	cmd = { vim.fn.stdpath("data") .. "/mason/bin/vscode-html-language-server", "--stdio" },
	filetypes = { "html" },
	root_markers = { "package.json", ".git" },
	capabilities = capabilities,
	on_attach = on_attach,
}

vim.lsp.config.cssls = {
	cmd = { vim.fn.stdpath("data") .. "/mason/bin/vscode-css-language-server", "--stdio" },
	filetypes = { "css", "scss", "less" },
	root_markers = { "package.json", ".git" },
	capabilities = capabilities,
	on_attach = on_attach,
}

vim.lsp.config.jsonls = {
	cmd = { vim.fn.stdpath("data") .. "/mason/bin/vscode-json-language-server", "--stdio" },
	filetypes = { "json", "jsonc" },
	root_markers = { "package.json", ".git" },
	capabilities = capabilities,
	on_attach = on_attach,
}

vim.lsp.config.pylsp = {
	cmd = { vim.fn.stdpath("data") .. "/mason/bin/pylsp" },
	filetypes = { "python" },
	root_markers = { "pyproject.toml", "setup.py", "requirements.txt", ".git" },
	capabilities = capabilities,
	on_attach = on_attach,
	settings = {
		pylsp = {
			plugins = {
				-- Enable diagnostics and error checking
				pycodestyle = {
					enabled = true,
					maxLineLength = 88,
				},
				mccabe = {
					enabled = true,
					threshold = 15,
				},
				pyflakes = {
					enabled = true,
				},
				pylint = { enabled = false },

				-- Enable Jedi features for hover, completion, etc.
				jedi_completion = {
					enabled = true,
					include_params = true,
					include_class_objects = true,
					include_function_objects = true,
				},
				jedi_hover = {
					enabled = true,
				},
				jedi_references = {
					enabled = true,
				},
				jedi_signature_help = {
					enabled = true,
				},
				jedi_symbols = {
					enabled = true,
					all_scopes = true,
				},
				jedi_definition = {
					enabled = true,
				},

				-- Note: ruff and pylsp-mypy extensions need to be installed separately
				-- They are not available through Mason

				-- Disable formatters (we use conform.nvim)
				autopep8 = { enabled = false },
				yapf = { enabled = false },
				black = { enabled = false },
			},
		},
	},
}

vim.lsp.config.lua_ls = {
	cmd = { vim.fn.stdpath("data") .. "/mason/bin/lua-language-server" },
	filetypes = { "lua" },
	root_markers = { ".luarc.json", ".luarc.jsonc", ".git" },
	capabilities = capabilities,
	on_attach = on_attach,
	settings = {
		Lua = {
			diagnostics = {
				globals = { "vim" },
			},
			workspace = {
				library = vim.api.nvim_get_runtime_file("", true),
			},
			telemetry = {
				enable = false,
			},
		},
	},
}

vim.lsp.config.emmet_ls = {
	cmd = { vim.fn.stdpath("data") .. "/mason/bin/emmet-ls", "--stdio" },
	filetypes = { "html", "css", "javascript", "typescript", "javascriptreact", "typescriptreact" },
	root_markers = { "package.json", ".git" },
	capabilities = capabilities,
	on_attach = on_attach,
}

vim.lsp.config.marksman = {
	cmd = { vim.fn.stdpath("data") .. "/mason/bin/marksman", "server" },
	filetypes = { "markdown", "markdown.mdx" },
	root_markers = { ".marksman.toml", ".git" },
	capabilities = capabilities,
	on_attach = on_attach,
}

-- Enable all configured LSP servers
vim.lsp.enable({
	"ts_ls",
	"html",
	"cssls",
	"jsonls",
	"pylsp",
	"lua_ls",
	"emmet_ls",
	"marksman",
})

