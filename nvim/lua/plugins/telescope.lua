local tele = require("telescope")
tele.setup({
	extensions = {
		["ui-select"] = {
			require("telescope.themes").get_dropdown({}),
		},
	},
})
tele.load_extension("fzf")
tele.load_extension("ui-select")

local builtin = require("telescope.builtin")

vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Tele: Find File" })
vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Tele: Grep" }) -- should get more used to this idea of greping. So powerful!
vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Tele: Find Buffers" })
vim.keymap.set("n", "<leader>fk", builtin.keymaps, { desc = "Tele: Find Keymap" })
vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Tele: Find Help Tags" }) -- really nice to find some help instead opening help menu file constantly, sure we can tab but this is faster lol
-- mostly used to see and check what changed without having to go out of nvim to check via git
vim.keymap.set("n", "<leader>fc", builtin.git_status, { desc = "Tele: Find Changes" })
