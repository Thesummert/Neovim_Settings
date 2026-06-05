return {

	-- LSP
	{
		"neovim/nvim-lspconfig",

		event = { "BufReadPre", "BufNewFile" },

		dependencies = {
			"mason-org/mason.nvim",
			"mason-org/mason-lspconfig.nvim",
			"saghen/blink.cmp",
		},

		config = function()
			local capabilities = require("blink.cmp").get_lsp_capabilities()
			local lspconfig = require("lspconfig")
			vim.lsp.enable("lua_ls")
			-- C/C++
			vim.lsp.config("clangd", {
				capabilities = capabilities,
			}, vim.lsp.enable("matlab_ls"))
			vim.lsp.enable("neocmake")
			-- Markdown
			-- require("render-markdown").setup({
			-- 	completions = { lsp = { enabled = true } },
			-- })
		end,
	},

	-- Mason
	{
		"mason-org/mason.nvim",

		cmd = "Mason",

		opts = {},
	},

	{
		"mason-org/mason-lspconfig.nvim",

		opts = {},
	},

	{
		"saghen/blink.cmp",
		-- optional: provides snippets for the snippet source
		dependencies = { "rafamadriz/friendly-snippets", "L3MON4D3/LuaSnip" },

		-- use a release tag to download pre-built binaries
		version = "1.*",
		-- AND/OR build from source
		-- build = 'cargo build --release',
		-- If you use nix, you can build from source with:
		-- build = 'nix run .#build-plugin',

		---@module 'blink.cmp'
		---@type blink.cmp.Config
		opts = {
			-- 'default' (recommended) for mappings similar to built-in completions (C-y to accept)
			-- 'super-tab' for mappings similar to vscode (tab to accept)
			-- 'enter' for enter to accept
			-- 'none' for no mappings
			--
			-- All presets have the following mappings:
			-- C-space: Open menu or open docs if already open
			-- C-n/C-p or Up/Down: Select next/previous item
			-- C-e: Hide menu
			-- C-k: Toggle signature help (if signature.enabled = true)
			--
			-- See :h blink-cmp-config-keymap for defining your own keymap
			keymap = {
				preset = "default",

				["<C-b>"] = { "scroll_documentation_up" },
				["<C-f>"] = { "scroll_documentation_down" },

				["<C-Space>"] = { "show" },

				["<CR>"] = { "accept" },

				["<Tab>"] = {
					"select_next",
					"snippet_forward",
					"fallback",
				},

				["<S-Tab>"] = {
					"select_prev",
					"snippet_backward",
					"fallback",
				},
			},

			snippets = {
				preset = "luasnip",
			},

			appearance = {
				-- 'mono' (default) for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
				-- Adjusts spacing to ensure icons are aligned
				nerd_font_variant = "mono",
			},

			-- (Default) Only show the documentation popup when manually triggered
			completion = { documentation = { auto_show = false } },

			-- Default list of enabled providers defined so that you can extend it
			-- elsewhere in your config, without redefining it, due to `opts_extend`
			sources = {
				default = { "lsp", "path", "snippets", "buffer" },
			},

			-- (Default) Rust fuzzy matcher for typo resistance and significantly better performance
			-- You may use a lua implementation instead by using `implementation = "lua"` or fallback to the lua implementation,
			-- when the Rust fuzzy matcher is not available, by using `implementation = "prefer_rust"`
			--
			-- See the fuzzy documentation for more information
			fuzzy = { implementation = "prefer_rust_with_warning" },
		},
		opts_extend = { "sources.default" },
	},
	{
		"nvim-treesitter/nvim-treesitter",
		lazy = false,
		build = ":TSUpdate",
	},
	-- 优化LSP 类似vscode体验 目前主要使用悬浮提示函数定义
	{
		"nvimdev/lspsaga.nvim",
		config = function()
			require("lspsaga").setup({
				opts = {
					symbol_in_winbar = {
						enable = false,
					},
				},
			})

			-- 触发时间
			vim.o.updatetime = 500

			-- 自动显示 Hover

			-- 自动 Hover 开关
			vim.g.auto_hover_enabled = false

			vim.api.nvim_create_autocmd("CursorHold", {
				callback = function()
					if not vim.g.auto_hover_enabled then
						return
					end

					if vim.fn.mode() ~= "n" then
						return
					end

					-- 或者：
					require("lspsaga.hover"):render_hover_doc()
				end,
			})

			-- 切换自动 Hover
			vim.keymap.set("n", "<leader>uh", function()
				vim.g.auto_hover_enabled = not vim.g.auto_hover_enabled

				vim.notify("Auto Hover " .. (vim.g.auto_hover_enabled and "Enabled" or "Disabled"), vim.log.levels.INFO)
			end, {
				desc = "Toggle Auto Hover",
			})
			vim.api.nvim_create_autocmd("LspAttach", {
				callback = function(args)
					local bufnr = args.buf

					if vim.bo[bufnr].filetype == "matlab" then
						vim.b[bufnr].disable_winbar = true
					end
				end,
			})
		end,
		dependencies = {
			"nvim-treesitter/nvim-treesitter", -- optional
			"nvim-tree/nvim-web-devicons", -- optional
		},
		event = "LspAttach",
	},
	-- 提供函数签名提示
	{
		{
			"ray-x/lsp_signature.nvim",
			event = "InsertEnter",
			opts = {
				-- cfg options
			},
		},
	},
}
