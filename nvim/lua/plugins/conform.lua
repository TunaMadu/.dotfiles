return {
	"stevearc/conform.nvim",
	opts = {
		formatters_by_ft = require("nvim-core.installed_language_info").get_lang_info(function(lang_info, _)
			if lang_info.formatters then
				return lang_info.formatters
			end
		end),
	},
}
