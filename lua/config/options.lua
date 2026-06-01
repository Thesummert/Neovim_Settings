vim.opt.termguicolors = true
vim.o.tabstop = 4 -- Tab 占用的空格数
vim.o.shiftwidth = 4 -- 自动缩进（如 == 或 >>）时的空格数
vim.o.expandtab = true -- 将 Tab 键转换为空格
vim.o.smartindent = true -- 智能缩进（针对 C/C++ 等语言）

vim.opt.number = true -- show absolute number
vim.opt.relativenumber = true -- add numbers to each line on the left side
vim.opt.cursorline = true -- highlight cursor line underneath the cursor horizontally
vim.opt.splitbelow = true -- open new vertical split bottom
vim.opt.splitright = true -- open new horizontal splits righ

-- Searching
vim.opt.incsearch = true -- search as characters are entered
vim.opt.hlsearch = false -- do not highlight matches
vim.opt.ignorecase = true -- ignore case in searches by default
vim.opt.smartcase = true -- but make it case sensitive if an uppercase is entered

vim.o.modeline = false

vim.api.nvim_create_autocmd("VimEnter", {
	callback = function()
		require("auto-session").RestoreSession()
	end,
})
