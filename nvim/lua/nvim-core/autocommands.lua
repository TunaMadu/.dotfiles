-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	group = vim.api.nvim_create_augroup("ks-highlight-yank", { clear = true }),
	callback = function()
		vim.highlight.on_yank()
	end,
})

local util = require("nvim-core.installed_language_info")
local filtered_info

-- list containing all file type extensions for all installed languages
filtered_info = util.get_lang_info(function(lang_info, _)
	return lang_info.filetype
end)

vim.api.nvim_create_autocmd("FileType", {
	desc = "Start treesitter based on specified filetypes",
	pattern = filtered_info,
	group = vim.api.nvim_create_augroup("treesitter_autocommand", { clear = true }),
	callback = function()
		vim.treesitter.start()
	end,
})

local formatter = require("conform")
-- list containing filetypes with formatters
filtered_info = util.get_lang_info(function(lang_info, _)
	if lang_info.formatters then
		return lang_info.filetype
	end
end, { "go", "lua" })

vim.api.nvim_create_autocmd("BufWritePre", {
	desc = "Format on save",
	pattern = filtered_info,
	group = vim.api.nvim_create_augroup("format_on_save", { clear = true }),
	callback = function(args)
		formatter.format({ bufnr = args.buf })
	end,
})

local linter = require("lint")
-- list containing filetypes with linters
filtered_info = util.get_lang_info(function(lang_info)
	if lang_info.linter then
		return lang_info.filetype
	end
end, { "go" })

vim.api.nvim_create_autocmd("BufWritePost", {
	desc = "Lint after save",
	pattern = filtered_info,
	group = vim.api.nvim_create_augroup("Lint_after_save", { clear = true }),
	callback = function(args)
		linter.try_lint()
	end,
})
