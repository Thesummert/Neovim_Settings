return {
	{
		"stevearc/overseer.nvim",
		---@module 'overseer'
		---@type overseer.SetupOpts
		config = function()
			require("overseer").setup()
			require("config.project_tasks").setup()
		end,
		opts = {},
	},
}
