return {
	{
		"folke/tokyonight.nvim",
		lazy = false,
		priority = 1000,
		config = function()
			vim.cmd("colorscheme tokyonight")
		end,
	},
	-- 标签栏
	{
		"akinsho/bufferline.nvim",
		lazy = false,
		dependencies = "nvim-tree/nvim-web-devicons",
		keys = {
			{ "<M-1>", "<CMD>BufferLineGoToBuffer 1<CR>" },
			{ "<M-2>", "<CMD>BufferLineGoToBuffer 2<CR>" },
			{ "<M-3>", "<CMD>BufferLineGoToBuffer 3<CR>" },
			{ "<M-4>", "<CMD>BufferLineGoToBuffer 4<CR>" },
			{ "<M-5>", "<CMD>BufferLineGoToBuffer 5<CR>" },
			{ "<M-6>", "<CMD>BufferLineGoToBuffer 6<CR>" },
			{ "<M-7>", "<CMD>BufferLineGoToBuffer 7<CR>" },
			{ "<M-8>", "<CMD>BufferLineGoToBuffer 8<CR>" },
			{ "<M-9>", "<CMD>BufferLineGoToBuffer 9<CR>" },
			{ "<M-d>", "<CMD>bdelete<CR>" },
		},
		init = function()
			require("bufferline").setup({})
		end,
	},
	-- 控制标签栏
	{
		"tiagovla/scope.nvim",
		init = function()
			require("scope").setup({})
		end,
		keys = {
			{ "<S-L>", "<CMD>bnext<CR>" },
			{ "<S-H>", "<CMD>bprevious<CR>" },
		},
	},
	-- 平滑滚动
	{
		"declancm/cinnamon.nvim",
		version = "*", -- use latest release
		opts = {
			-- change default options here
			keymaps = {
				basic = false,
				extra = false,
			},
		},
	},
	-- 光标动画
	{
		"sphamba/smear-cursor.nvim",
		opts = {},
	},
	{
		"hiphish/rainbow-delimiters.nvim",
	},
	{
		"xiyaowong/transparent.nvim",
	},
}
