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
}
