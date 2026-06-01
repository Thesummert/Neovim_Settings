return {
	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		opts = {},
	},
	{
		"kylechui/nvim-surround",
		event = "VeryLazy",
		opts = {},
	},
	{
		"catgoose/nvim-colorizer.lua",
		event = "User FilePost",
		opts = {},
	},
	{
		"folke/flash.nvim",
		event = "VeryLazy",
		opts = {},
  -- stylua: ignore
  keys = {
    { "s", mode = { "n", "o", "x" }, function() require("flash").jump() end, desc = "Flash" },
    -- { "S", mode = { "n", "o", "x" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
    { "r", mode = "o", function() require("flash").remote() end, desc = "Remote Flash" },
    { "R", mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
    { "<c-s>", mode = "c", function() require("flash").toggle() end, desc = "Toggle Flash Search" },
  },
	},
	-- format
	{
		"stevearc/conform.nvim",
		cmd = "ConformInfo",
		opts = {
			formatters_by_ft = {
				c = { "clang-format" },
				cpp = { "clang-format" },
				lua = { "stylua" },
				python = { "ruff_format" },
				matlab = { "miss_hit" },
				["*"] = { "trim_whitespace" },
			},
			formatters = {
				miss_hit = {
					command = "mh_style",
					args = { "--fix", "$FILENAME" },
					stdin = false,
					exit_codes = { 0, 1 },
				},
			},
		},
		keys = {
			{
				"<leader>fl",
				function()
					require("conform").format()
				end,
				mode = { "n", "v" },
			},
		},
	},
	-- Comment
	-- {
	-- 	"numToStr/Comment.nvim",
	-- 	opts = {
	-- 		-- add any options here
	-- 	},
	-- },
	{
		"kdheepak/lazygit.nvim",
		lazy = true,
		cmd = {
			"LazyGit",
			"LazyGitConfig",
			"LazyGitCurrentFile",
			"LazyGitFilter",
			"LazyGitFilterCurrentFile",
		},
		-- optional for floating window border decoration
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
		-- setting the keybinding for LazyGit with 'keys' is recommended in
		-- order to load the plugin when the command is run for the first time
		keys = {
			{ "<leader>lg", "<cmd>LazyGit<cr>", desc = "LazyGit" },
		},
	},
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		opts = {
			-- your configuration comes here
			-- or leave it empty to use the default settings
			-- refer to the configuration section below
		},
		keys = {
			{
				"<leader>?",
				function()
					require("which-key").show({ global = false })
				end,
				desc = "Buffer Local Keymaps (which-key)",
			},
		},
	},
	-- 项目管理
	{
		"ahmedkhalf/project.nvim",
		config = function()
			require("project_nvim").setup({
				detection_methods = { "pattern" },
				patterns = { ".git", "CMakeLists.txt", "package.json" },
			})
		end,
	},
	{
		"rmagatti/auto-session",
		config = function()
			require("auto-session").setup({
				auto_restore_enabled = true,

				auto_session_root_dir = vim.fn.stdpath("data") .. "/sessions/",

				auto_session_enable_last_session = false,

				auto_session_suppress_dirs = {
					"~/",
					"~/Downloads",
					"/",
				},

				log_level = "error",
			})
		end,
		keys = {
			{
				"<leader>ss",
				function()
					require("auto-session").SaveSession()
				end,
				{},
			},
			{
				"<leader>sr",
				function()
					require("auto-session").RestoreSession()
				end,
				{},
			},
		},
	},
	-- markdown
	-- {
	-- 	"MeanderingProgrammer/render-markdown.nvim",
	-- 	dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-mini/mini.nvim" }, -- if you use the mini.nvim suite
	-- 	-- dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-mini/mini.icons' },        -- if you use standalone mini plugins
	-- 	-- dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' }, -- if you prefer nvim-web-devicons
	-- 	---@module 'render-markdown'
	-- 	---@type render.md.UserConfig
	-- 	opts = {},
	-- },
}
