local gitsigns = require("gitsigns")

local function map(mode, l, r, opts)
	opts = opts or {}
	opts.buffer = bufnr
	vim.keymap.set(mode, l, r, opts)
end

-- outside from the sign posts that gitsigns provide
-- tpopes version of git is so much more powerful IMO
-- the real good parts of this configuration are the opt in
-- keybinds it offers. Especially in specifying specific hunks
-- for commits - the unstaging process is 60% of what i would
-- of used the undo tree plugin lol

gitsigns.setup({

	on_attach = function()
		-- Navigation
		map("n", "]c", function()
			if vim.wo.diff then
				vim.cmd.normal({ "]c", bang = true })
			else
				gitsigns.nav_hunk("next")
			end
		end)

		map("n", "[c", function()
			if vim.wo.diff then
				vim.cmd.normal({ "[c", bang = true })
			else
				gitsigns.nav_hunk("prev")
			end
		end)

		-- Actions
		map("n", "<leader>hs", gitsigns.stage_hunk)
		map("n", "<leader>hr", gitsigns.reset_hunk)

		-- staging a specific hunk in a file
		map("v", "<leader>hs", function()
			gitsigns.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
		end)

		map("v", "<leader>hr", function()
			gitsigns.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
		end)

		-- i prefer doing stages or hard resets manually
		-- through git... still carry some trauma from
		-- using jetbrains git gui shenanigans
		-- map("n", "<leader>hS", gitsigns.stage_buffer)
		-- map("n", "<leader>hR", gitsigns.reset_buffer)

		map("n", "<leader>hp", gitsigns.preview_hunk_inline)

		map("n", "<leader>hb", function()
			gitsigns.blame_line({ full = true })
		end)

		map("n", "<leader>hd", gitsigns.diffthis)

		map("n", "<leader>hD", function()
			gitsigns.diffthis("~")
		end)

		map("n", "<leader>hq", function()
			gitsigns.setqflist("all")
		end)

		-- Really nice way to see what changed through a toggle
		map("n", "<leader>tb", gitsigns.blame)
		map("n", "<leader>td", gitsigns.toggle_deleted)
		map("n", "<leader>tw", gitsigns.toggle_word_diff)
	end,
})
