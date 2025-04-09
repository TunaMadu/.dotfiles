--
-- Requirements:
--  run :FetchTools to install the language
--  servers on the system...
--

local lspconfig = require("lspconfig")
local capabilities = require("blink.cmp").get_lsp_capabilities()

local tele_builtin = require("telescope.builtin")

local ls_list = {
	"lua_ls",
	"html",
	"cssls",
	"ts_ls",
}

for _, lsp in ipairs(ls_list) do
	lspconfig[lsp].setup({ capabilities = capabilities })
end

-- helper
local function map(keymap, func, desc, mode)
	mode = mode or "n"
	vim.keymap.set(mode, keymap, func, { desc = desc, noremap = true })
end

--
-- LSP MAPPING
-- although we can use the builtin lsp... telescope has some wrapper mechanisms super charging it
--
local augroup = vim.api.nvim_create_augroup("lsp_keymaps", { clear = true })
vim.api.nvim_create_autocmd("LspAttach", {
	desc = "Lsp keymaps",
	group = augroup,
	callback = function()
		-- CORE ACTIONS
		map("gd", tele_builtin.lsp_definitions, "Goto Definition")
		map("gr", tele_builtin.lsp_references, "Goto References")

		map("gD", vim.lsp.buf.declaration, "Goto Declaration")
		map("<leader>rn", vim.lsp.buf.rename, "Rename")
		map("<leader>ca", vim.lsp.buf.code_action, "Code Action", { "n", "v" })

		-- THE FOLLOWING WILL BE DEPENDENT ON LSP SERVER SUPPORT

		map("gi", tele_builtin.lsp_implementations, "Goto Implementations") -- like goto defintion but meant for scenarios where we have abstract interface shenanigins
		map("<leader>gt", tele_builtin.lsp_type_definitions, "Goto Type Definitions")

		-- shows everything in our current buffer
		map("<leader>ds", tele_builtin.lsp_document_symbols, "Show Doc Symbols")
		-- same as prev but on a workspace level!
		map("<leader>ws", tele_builtin.lsp_workspace_symbols, "Show Workspace Symbols")
	end,
})
