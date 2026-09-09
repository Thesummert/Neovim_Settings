return {

	{
		"olimorris/codecompanion.nvim",
		version = "^19.0.0",
		opts = {
			language = "Chinese",
			adapters = {
				http = {
					yapi = function()
						local adapter = require("codecompanion.adapters").extend("openai_responses", {
							name = "yapi",
							formatted_name = "Yapi",
							url = "https://yapi.click/v1/responses",
							env = {
								api_key = function()
									return os.getenv("YAPI_API_KEY")
								end,
							},
						})
						adapter.schema.model = {
							order = 1,
							mapping = "parameters",
							type = "enum",
							desc = "ID of the model to use.",
							default = "gpt-5.5",
							choices = {
								["gpt-5.5"] = { opts = { can_reason = true } },
								["gpt-5.6-terra"] = { opts = { can_reason = true } },
								["gpt-5.6-sol"] = { opts = { can_reason = true } },
							},
						}
						return adapter
					end,
				},
			},
			interactions = {
				chat = {
					-- You can specify an adapter by name and model (both ACP and HTTP)
					adapter = {
						name = "yapi",
						model = "gpt-5.5",
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
				-- cli = {
				-- 	agent = "opencode",
				--
				-- 	agents = {
				-- 		opencode = {
				-- 			cmd = "opencode",
				-- 			args = {},
				-- 			description = "OpenCode CLI",
				-- 			provider = "terminal",
				-- 		},
				-- 	},
				-- },
				cli = {
					agent = "codex",

					agents = {
						codex = {
							cmd = "codex",
							args = {},
							description = "Codex CLI",
							provider = "terminal",
						},
						opencode = {
							cmd = "opencode",
							args = {},
							description = "Opencode CLI",
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
