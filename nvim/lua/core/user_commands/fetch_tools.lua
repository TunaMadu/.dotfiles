local language_tools = {
	lsp_list = {
		"lua-language-server",
		"typescript-language-server",
		"css-lsp",
		"html-lsp",
	},
	linters = {
		"eslint_d",
	},
	formatters = {
		"stylua",
		"prettier",
	},
}
local function fetch_tools()
	for _, tools in pairs(language_tools) do
		for _, tool in ipairs(tools) do
			vim.cmd("MasonInstall " .. tool)
		end
	end
end

vim.api.nvim_create_user_command("FetchTools", fetch_tools, {})
