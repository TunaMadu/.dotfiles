return {

	cmd = { "lua-language-server" },
	filetypes = { "lua" },

	-- im not sure how root markers works with files types...
	-- according to gpt, (are we really in a world that we're beginning to say this...)
	-- the root_markers and by extension the root_dir atribute, are flags or potential
	-- paths that tell nvim where our project begins if we open nvim within a directory.
	-- It tells nvim where our project begins, so that it has enough context for the lsp
	-- Where instead of having a lsp know everything there is to know about our file we opened
	-- nvim with, it now has the context of our entire project. Where we get that nice cross
	-- directory autocompletions, and so on. p neat.
	root_markers = {
		".luarc.json",
		".luarc.jsonc",
		".luacheckrc",
		".stylua.toml",
		"stylua.toml",
		"selene.toml",
		"selene.yml",
		".git",
	},
}

-- in the past the file type atribute was resolved through a autocommand
-- the manual version of all this was supplying things each to a specific
-- ft.lua file convention, where nvim will try to attach something to a
-- specified filetype within a directory. Because this was a pain, people
-- used an autocommand that wrapped the cofigurations and started the server
-- within one of nvim's filetype events. Where they had the ability to
-- start the server for multiple file extensions simply by listing them
-- out within the event's pattern attribute. Some real clever shit!
