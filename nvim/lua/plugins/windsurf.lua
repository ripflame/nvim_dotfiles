return {
	"Exafunction/windsurf.vim",
	event = "BufEnter",
	config = function()
		-- Disable default Tab mapping to avoid conflicts with snippets/completion
		vim.g.codeium_disable_bindings = 1

		-- Set up custom keymaps for Windsurf/Codeium
		vim.keymap.set("i", "<C-g>", function()
			return vim.fn["codeium#Accept"]()
		end, { expr = true, silent = true, desc = "Accept Codeium suggestion" })
		vim.keymap.set("i", "<C-;>", function()
			return vim.fn["codeium#CycleCompletions"](1)
		end, { expr = true, silent = true, desc = "Next Codeium suggestion" })
		vim.keymap.set("i", "<C-,>", function()
			return vim.fn["codeium#CycleCompletions"](-1)
		end, { expr = true, silent = true, desc = "Previous Codeium suggestion" })
		vim.keymap.set("i", "<C-x>", function()
			return vim.fn["codeium#Clear"]()
		end, { expr = true, silent = true, desc = "Clear Codeium suggestion" })
	end,
}
