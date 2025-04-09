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

local lint_file_ext = {
	"*.js",
	"*.jsx",
	"*.ts",
	"*.tsx",
}

-- we could wrap this whole idea into a auto command where if we want to, we can turn
-- it on and if we dont we dont...
--

augroup = vim.api.nvim_create_augroup("linter_config", { clear = true })
vim.api.nvim_create_autocmd({ "BufWritePost" }, {
	desc = "Linting based on file types",
	pattern = lint_file_ext,
	callback = function()
		nvim_lint.try_lint()
	end,
})

vim.diagnostic.config({
	virtual_lines = {
		severity = {
			vim.diagnostic.severity.ERROR,
		},
	},
	virtual_text = {
		severity = {
			vim.diagnostic.severity.WARN,
			vim.diagnostic.severity.INFO,
			vim.diagnostic.severity.HINT,
		},
	},
})
vim.api.nvim_set_hl(0, "DiagnosticVirtualTextWarn", { fg = "#3F4F44", bg = "NONE" }) -- Less bold for warnings
