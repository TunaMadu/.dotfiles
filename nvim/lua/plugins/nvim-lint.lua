return {
	"mfussenegger/nvim-lint",
	config = function()
		require("lint").linters_by_ft = require("nvim-core.installed_language_info").get_lang_info(
			function(lang_info, _)
				if lang_info.linter then
					return lang_info.linter
				end
			end
		)
	end,
}
