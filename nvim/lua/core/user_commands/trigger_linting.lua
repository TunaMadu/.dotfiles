--
-- Why this command?
--
-- While linting is great to keep things consistent and what not
-- the added overhead required to remove unwanted error messages
-- within nvim. Limits you from testing out something qcuikly.
-- Removing what i would consider a core idea of nvim. Which is
-- getting out your way in editing text.
-- Which is why this autocommand exists to get back control from
-- linters.
--

local path_to_tmp = vim.fn.stdpath("config") .. "/linter_status"
local augroup = vim.api.nvim_create_augroup("linter_config", { clear = true })

local function turn_linter_on()
	local lint_file_ext = {
		"*.js",
		"*.jsx",
		"*.ts",
		"*.tsx",
	}

	vim.api.nvim_create_autocmd({ "BufWritePost" }, {
		group = augroup,
		desc = "Linting based on file types",
		pattern = lint_file_ext,
		callback = function()
			require("lint").try_lint()
		end,
	})
end

--
-- create directory if it doesn't already exists
--
if vim.fn.finddir(path_to_tmp) == "" then
	vim.fn.mkdir(path_to_tmp)
	vim.fn.writefile({}, path_to_tmp .. "/on")
end

--
-- so long as the file exists, we will turn on linters
--
if vim.fn.filereadable(path_to_tmp .. "/on") == 1 then
	turn_linter_on()
end

--
-- The linter will be on by default, if we remove the linter by calling the
-- function. Subsequent vim openings will not trigger the linter to be active.
-- The only way to get back the linter would be to rerun the function and
-- recreate the linter file flag we are looking our for, to turn the linter on
--

local function trigger_linter()
	-- If the linter status file exists,
	-- it means we have the linter on and we want to De-activate it
	if vim.fn.filereadable(path_to_tmp .. "/on") == 1 then
		vim.fn.delete(path_to_tmp .. "/on")
		vim.api.nvim_clear_autocmds({ group = augroup })
		print("Linter De-activated")

		return
	end

	-- if we reach this point, we will turn on the linter again
	-- and the state will go back to the default behavior
	turn_linter_on()
	vim.fn.writefile({}, path_to_tmp .. "/on")
	print("Linter Activated")
end

vim.api.nvim_create_user_command("TriggerLinter", trigger_linter, {})
