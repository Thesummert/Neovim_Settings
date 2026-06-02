return {

	-- LSP
	{
		"neovim/nvim-lspconfig",

		event = { "BufReadPre", "BufNewFile" },

		dependencies = {
			"mason-org/mason.nvim",
			"mason-org/mason-lspconfig.nvim",

			"hrsh7th/cmp-nvim-lsp",
		},

		config = function()
			local capabilities = require("cmp_nvim_lsp").default_capabilities()

			vim.lsp.config("lua_ls", {
				capabilities = capabilities,

				settings = {
					Lua = {
						diagnostics = {
							globals = { "vim" },
						},
					},
				},
			})

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

	-- nvim-cmp
	{
		"hrsh7th/nvim-cmp",

		event = "InsertEnter",

		dependencies = {

			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"saadparwaiz1/cmp_luasnip",

			"L3MON4D3/LuaSnip",
			"rafamadriz/friendly-snippets",
		},

		config = function()
			local cmp = require("cmp")
			local luasnip = require("luasnip")

			require("luasnip.loaders.from_vscode").lazy_load()

			cmp.setup({

				snippet = {
					expand = function(args)
						luasnip.lsp_expand(args.body)
					end,
				},

				mapping = cmp.mapping.preset.insert({

					["<C-b>"] = cmp.mapping.scroll_docs(-4),
					["<C-f>"] = cmp.mapping.scroll_docs(4),

					["<C-Space>"] = cmp.mapping.complete(),

					["<CR>"] = cmp.mapping.confirm({
						select = true,
					}),

					["<Tab>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_next_item()
						elseif luasnip.expand_or_jumpable() then
							luasnip.expand_or_jump()
						else
							fallback()
						end
					end, { "i", "s" }),

					["<S-Tab>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_prev_item()
						elseif luasnip.jumpable(-1) then
							luasnip.jump(-1)
						else
							fallback()
						end
					end, { "i", "s" }),
				}),

				sources = cmp.config.sources({

					{ name = "nvim_lsp" },
					{ name = "luasnip" },
					{ name = "buffer" },
					{ name = "path" },
				}),
			})
		end,
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
			require("lspsaga").setup({})

			-- 触发时间
			vim.o.updatetime = 500

			-- 自动显示 Hover

			-- 自动 Hover 开关
			vim.g.auto_hover_enabled = true

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
