-- Keep the leader and early options in place before loading plugin specs.
require("config.core.early_options")
require("config.core.keymaps")
require("config.core.lazy")

-- These modules run after plugin loading, in their original order.
require("config.features.lualine")
require("config.features.ui")
require("config.core.options")
require("config.features.custom_completion")
require("config.features.nvim_dap")
