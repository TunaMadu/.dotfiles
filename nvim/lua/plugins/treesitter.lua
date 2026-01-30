-- tree sitter syntax highlighting buisness
-- parse trees are pretty cool
return {
	"nvim-treesitter/nvim-treesitter",
	lazy = false,
	build = ":TSUpdate",
	-- doesn't need to run setup to function
}
