require("config.lazy") -- simple plugin configs will go within the same lazy file

-- relative to the editor
require("core.options")
require("core.keybinds")
require("core.user_commands.fetch_tools")
require("core.user_commands.trigger_linting")

-- plugin configuration
-- future me, uncomment after all tools have been installed
-- above...
require("plugins.lsp")
require("plugins.telescope")
require("plugins.lint-format")
require("plugins.gitsigns")
