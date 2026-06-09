return {

	{
		"olimorris/codecompanion.nvim",
		version = "^19.0.0",
		opts = {
			language = "Chinese",
			interactions = {
				chat = {
					-- You can specify an adapter by name and model (both ACP and HTTP)
					adapter = {
						name = "deepseek",
						model = "deepseek-v4-flash",
					},
					opts = {
						system_prompt = function(context)
							return context.default_system_prompt .. [[

请始终使用中文回复。
]]
						end,
					},
				},
				-- Or, just specify the adapter by name
				inline = {
					name = "deepseek",
					model = "deepseek-v4-flash",
				},
				cmd = {
					name = "deepseek",
					model = "deepseek-v4-flash",
				},
				background = {
					adapter = {
						name = "deepseek",
						model = "deepseek-v4-flash",
					},
				},
				cli = {
					agent = "opencode",

					agents = {
						opencode = {
							cmd = "opencode",
							args = {},
							description = "OpenCode CLI",
							provider = "terminal",
						},
					},
				},
			},
			-- NOTE: The log_level is in `opts.opts`
			opts = {
				log_level = "DEBUG",
			},
		},
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-treesitter/nvim-treesitter",
		},
	},
}
