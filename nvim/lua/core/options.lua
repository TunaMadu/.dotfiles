local opt = vim.opt
-- QOL
opt.wrap = false
-- opt.scrolloff = 5
opt.sidescrolloff = 80

--- even though we dont even use numbers while we jump
--- we still like them on the side...
opt.number = true
opt.relativenumber = true

-- TABS AND INDENTATIONS
opt.tabstop = 2
opt.shiftwidth = 2
opt.expandtab = true
opt.smarttab = true
opt.smartindent = true
opt.autoindent = true -- copies indent of current line to new one

-- SEARCH
opt.ignorecase = true -- not only removes casing while searching but also allows you to tab complete commands without caring for casing!
opt.smartcase = true -- if you include a mixed cased while searching, will assume you want case sens

-- SWAG
opt.undofile = true -- not sure if this is a potential sec risk lol - more research needed
opt.termguicolors = true
opt.cursorline = true
opt.updatetime = 250 -- in ms, after set time writes to swap!
opt.signcolumn = "yes" -- adds a white space for any special character we might have to the side of our numbers
opt.splitbelow = true
opt.splitright = true

-- CLIPBOARD
opt.clipboard:append("unnamedplus")
