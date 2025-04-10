--
-- Requirements:
--  language tools must be installed on the system before you can set up
--
local conform = require("conform")

---
---
--- how do we know these filetypes are the ones that nvim or the plugin
--- supports?
---   naturally when a plugin takes in a file type where you can customize
---   it will be relative to what nvim can detect. Nvim can detect the file
---   type when possible, so many plugins leverage that idea when you want specify
---   something for something. It sucks seeing these file types mentioned within
---   plugin config files with no mention or some type of list, where it maps
---   what filetypes can be a possible value within the option...but i digress.
--- nvim can detect file types through :=vim.bo.filetype
--- more info :h filetype
--- you can also modify the status line to include the filetype....
---
---

conform.setup({
	formatters_by_ft = {
		lua = { "stylua" },
		css = { "prettier" },
		html = { "prettier" },
		javascript = { "prettier" },
		javascriptreact = { "prettier" },
		typescript = { "prettier" },
		typescriptreact = { "prettier" },
		json = { "prettier" },
	},
})

-- god i love a nice macro
local format_file_ext = {
	"*.lua",
	"*.js",
	"*.jsx",
	"*.ts",
	"*.tsx",
	"*.html",
	"*.css",
	"*.json",
}

local augroup = vim.api.nvim_create_augroup("formatter_config", { clear = true })
vim.api.nvim_create_autocmd("BufWritePre", {
	desc = "Formatting based on file types",
	pattern = format_file_ext,
	group = augroup,
	callback = function()
		conform.format()
	end,
})

-- We are going to support linters, even if (in our opinion) it gets
-- in the way of doing simple things. As linting prevents erroneous
-- errors. Remember, we can turn things off if we want to, its our config
-- its our choice

local nvim_lint = require("lint")

nvim_lint.linters_by_ft = {
	javascript = { "eslint_d" },
	javascriptreact = { "eslint_d" },
	typescript = { "eslint_d" },
	typescriptreact = { "eslint_d" },
}

-- the linting nvim tie in is abstracted into a user commmand
