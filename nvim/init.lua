vim.g.mapleader = " "
vim.g.localleader = " "

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
	if vim.v.shell_error ~= 0 then
		vim.api.nvim_echo({
			{ "Failed to clone lazy.nvim:\n", "ErrorMsg" },
			{ out, "WarningMsg" },
			{ "\nPress any key to exit..." },
		}, true, {})
		vim.fn.getchar()
		os.exit(1)
	end
end
vim.opt.rtp:prepend(lazypath)

-- Setup lazy.nvim
require("lazy").setup("plugins") -- WATCH OUT FOR OPTS

-- Some plugins don't need config to run setup.
-- Though if you want to modify the plugin in config and rely on
-- opts... Lazy will not run setup immediately! So you're required
-- to run setup yourself.
--
-- If using config, and you require the plugin to be loaded
-- don't rely or even use opts! Manually invoke and set things up in
-- config!

--
-- custom configuration starts.
--
local util = require("nvim-core.installed_language_info")

require("nvim-treesitter").install(
	util.get_lang_info(function(_, lang)
		return lang
	end)
	-- ,{summary = true}
)

-- lsp configuration/setup
-- Thanks to nvim 0.11 for making this so much easier!

vim.lsp.config("*", {
	capabilities = require("blink.cmp").get_lsp_capabilities(),
})

vim.lsp.enable(util.get_lang_info(function(lang_info, _)
	if lang_info.language_server then
		return lang_info.language_server
	end
end))

--
-- :h diagnostic
-- keymaps exist for diagnostics!
--
vim.diagnostic.config({
	-- pretty cool error integration
	-- though the effect is a little jarring
	virtual_lines = {
		severity = {
			vim.diagnostic.severity.ERROR,
			vim.diagnostic.severity.WARN,
		},
	},
	virtual_text = {
		severity = {
			vim.diagnostic.severity.INFO,
			vim.diagnostic.severity.HINT,
		},
	},
})

require("nvim-core.options")
require("nvim-core.keybinds")
require("nvim-core.autocommands")
