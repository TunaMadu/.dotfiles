local M = {}

local language_info_repo = {

	lua = {
		filetype = "*.lua",
		language_server = "lua_ls",
		formatters = { "stylua" },
	},

	go = {
		filetype = "*.go",
		language_server = "gopls",
		formatters = { "goimports", "gofumpt" },
		linter = { "golangcilint" }, -- using the names specified on nvim-lint not the one from MASON
	},

	markdown = { filetype = "*.md" },
	javascript = { filetype = "*.js" },
	html = { filetype = "*.html" },
	css = { filetype = "*.css" },
	json = { filetype = "*.json" },
}

-- returns a list of language information
-- If not supplied with arguments, will return entire language info
-- If supplied with a list only, will return entire specified language info
--
-- When both or when passed with a filter only, it will return a list
-- corresponding to the filtered return against the list. If no list it will
-- filter enntire language info against filter.
--
-- If the filter returns a string, function returns a list
-- If the filter returns a {}, the return will be structured.
--
-- Will return a table in the following format {"",} or { go = {},}

function M.get_lang_info(filter, lang_list)
	-- when neither is present
	if not filter and not lang_list then
		return language_info_repo -- return entire generic data
	end

	local aux = {}

	---
	--- Either one can exist or both...
	---
	if not filter and lang_list then
		for _, lang in ipairs(lang_list) do
			if language_info_repo[lang] then
				aux[lang] = language_info_repo[lang]
			end
		end
		return aux -- return specific generic data
	end

	--
	-- There is a filter
	-- List can either be true or false
	--

	lang_list = lang_list or M.get_languages()

	-- Where the only possible assumption is both are valid

	for _, lang in ipairs(lang_list) do
		local filtered_return

		if language_info_repo[lang] then
			filtered_return = filter(language_info_repo[lang], lang) -- send lang info and lang itself
		end

		if type(filtered_return) == "string" then
			table.insert(aux, filtered_return)
		end

		-- if the return is structured, a specific format is desired.
		-- Returns a filtered version of the language table
		if type(filtered_return) == "table" then
			aux[lang] = filtered_return
		end
	end
	return aux
end

function M.get_languages()
	local aux = {}
	for language, _ in pairs(language_info_repo) do
		table.insert(aux, language)
	end
	return aux
end

-- While somewhat complicated, it hasn't failed us yet... Jan 2026

return M
