-- if true then return {} end -- WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE

-- Customize Treesitter

---@type LazySpec
return {
	"nvim-treesitter/nvim-treesitter",
	opts = {
		ensure_installed = {
			"lua",
			"vim",
			-- add more arguments for adding more treesitter parsers
			"bash",
			"comment",
			"go",
			"html",
			"javascript",
			"json",
			"json5",
			"markdown",
			"markdown_inline",
			"sql",
			"terraform",
			"typescript",
			"yaml",
		},
	},
	servers = {
		marksman = {},
	},
}
