vim.g.mapleader = " "
vim.g.localleader = " "
vim.keymap.set("n", "<leader>fp", "<cmd>Ex<CR>", { desc = "LET ME SEE MY FILES" }) -- ahhhh
vim.keymap.set("n", "<esc>", "<cmd>nohlsearch<CR>", { desc = "CLEAR HIGHLIGHT" }) -- compromise!

-- thanks tj
vim.keymap.set("n", "<leader><leader>x", "<cmd>source % <CR>")
vim.keymap.set("n", "<leader>x", ":.lua<CR>")
vim.keymap.set("v", "<leader>x", ":.lua<CR>")

-- ditch the mouse embrace the jump
-- note: there is a weird though intended interaction with the
-- scroll off option. Where if we jump, vim will correct the jump
-- when given a high enough scroll off
vim.keymap.set("n", "<C-U>", "10<C-u>", { desc = "Scroll up by 10", noremap = true })
vim.keymap.set("n", "<C-D>", "10<C-d>", { desc = "Scroll down by 10", noremap = true })

-- let me peak!!!
vim.keymap.set("n", "<C-y>", "10<C-y>", { desc = "Peak 10 lines up", noremap = true })
vim.keymap.set("n", "<C-e>", "10<C-e>", { desc = "Peak 10 lines below", noremap = true })

-- from kickstart
-- Keybinds to make split navigation easier.
-- but by default we navigate by using <C-w><C-hjkl>
--
-- vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
-- vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
-- vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
-- vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })
-- See `:help wincmd` for a list of all window commands
--

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
