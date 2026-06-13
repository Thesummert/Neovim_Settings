-- 基础选项
vim.opt.scrolloff = 5
vim.opt.clipboard = "unnamedplus"          -- 与系统剪贴板共享
vim.opt.incsearch = true
vim.opt.ignorecase = true
vim.opt.hlsearch = true
vim.opt.number = true
vim.opt.relativenumber = true

-- 空格作为 <Leader>
vim.g.mapleader = " "

-- 插件（需要安装对应的 Neovim 插件）
-- 1. vim-highlightedyank: 高亮复制区域
--    安装: 'machakann/vim-highlightedyank' (使用 packer/lazy.nvim)
-- 2. vim-commentary: 注释插件
--    安装: 'tpope/vim-commentary' (使用 packer/lazy.nvim)
-- 3. easymotion: 快速跳转 (IdeaVim 内置, Neovim 需安装)
--    安装: 'easymotion/vim-easymotion'
-- 4. which-key: 按键提示 (IdeaVim 内置, Neovim 需安装)
--    安装: 'folke/which-key.nvim'

-- ========== 快捷键映射 ==========

-- 退出插入模式 (jj)
vim.api.nvim_set_keymap('i', 'jj', '<ESC>', { noremap = true })

-- 标签页切换 (L/H)
vim.api.nvim_set_keymap('n', 'L', 'gt', { noremap = true })
vim.api.nvim_set_keymap('n', 'H', 'gT', { noremap = true })
vim.api.nvim_set_keymap('v', 'L', 'gt', { noremap = true })
vim.api.nvim_set_keymap('v', 'H', 'gT', { noremap = true })

-- 快速上下移动 (J/K 5行)
vim.api.nvim_set_keymap('n', 'J', '5j', { noremap = true })
vim.api.nvim_set_keymap('n', 'K', '5k', { noremap = true })
vim.api.nvim_set_keymap('v', 'J', '5j', { noremap = true })
vim.api.nvim_set_keymap('v', 'K', '5k', { noremap = true })

-- 行首/行尾 (<leader>h / <leader>l)
vim.api.nvim_set_keymap('n', '<leader>h', '0', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>l', '$', { noremap = true })
vim.api.nvim_set_keymap('v', '<leader>h', '0', { noremap = true })
vim.api.nvim_set_keymap('v', '<leader>l', '$', { noremap = true })

-- 注释 (Ctrl+/ 或 Ctrl+/ 触发注释切换)
vim.api.nvim_set_keymap('n', '<leader>c', 'gcc', { noremap = false})
vim.api.nvim_set_keymap('v', '<leader>c', 'gc', { noremap = false})

-- 缩进 (Tab / Shift-Tab)
vim.api.nvim_set_keymap('n', '<Tab>', '>>', { noremap = true })
vim.api.nvim_set_keymap('n', '<S-Tab>', '<<', { noremap = true })
vim.api.nvim_set_keymap('v', '<Tab>', '>gv', { noremap = true })
vim.api.nvim_set_keymap('v', '<S-Tab>', '<gv', { noremap = true })

-- 保存/退出 (<leader>w / <leader>q)
vim.api.nvim_set_keymap('n', '<leader>w', ':wa<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>q', ':qa<CR>', { noremap = true })
-- 退出窗口
vim.keymap.set('n', '<S-q>', ':q<CR>', {noremap = true});
-- 取消高亮 (<leader>nhl)
vim.api.nvim_set_keymap('n', '<leader>nhl', ':nohlsearch<CR>', { noremap = true })

-- 跳转到定义 (<leader>fd) —— 使用 LSP 或内置 <C-]>
vim.api.nvim_set_keymap('n', '<leader>fd', '<C-]>', { noremap = true })
-- 或者如果你使用 LSP，可以改为：
-- vim.api.nvim_set_keymap('n', '<leader>fd', '<cmd>lua vim.lsp.buf.definition()<CR>', { noremap = true })

-- 搜索文件 (<leader>ff) —— 使用 Telescope 或 :find
-- 这里使用内置 :find（需要设置 path），或建议安装 telescope.nvim
vim.api.nvim_set_keymap('n', '<leader>ff', ':find ', { noremap = true })
-- 如果你安装了 telescope，可以改为：
-- vim.api.nvim_set_keymap('n', '<leader>ff', '<cmd>Telescope find_files<CR>', { noremap = true })

-- 运行调试 (<leader>fg) —— 需要 nvim-dap 插件
-- 这里映射为启动调试（假设已配置 nvim-dap）
vim.api.nvim_set_keymap('n', '<leader>fg', '<cmd>lua require("dap").continue()<CR>', { noremap = true })

-- 复制全部 (<leader>cca)
vim.api.nvim_set_keymap('n', '<leader>cca', 'ggVG"+y', { noremap = true })

-- 选择全部 (<leader>csa)
vim.api.nvim_set_keymap('n', '<leader>csa', 'ggVG', { noremap = true })

-- 格式化代码 (<leader>fl) —— 使用 LSP 格式化
vim.api.nvim_set_keymap('n', '<leader>fl', '<cmd>lua vim.lsp.buf.format()<CR>', { noremap = true })
-- 或者使用内置 = 格式化（需要设置 formatexpr）
-- vim.api.nvim_set_keymap('n', '<leader>fl', 'gg=G', { noremap = true })

-- 插入模式下插入空行 (Alt+o)
vim.api.nvim_set_keymap('i', '<A-o>', '<ESC>o', { noremap = true })

-- 插入模式下粘贴 (Ctrl+v) —— 使用系统剪贴板
vim.api.nvim_set_keymap('i', '<C-v>', '<ESC>"+pi', { noremap = true })

vim.api.nvim_set_keymap('n', '<leader>rn', "<cmd>lua vim.lsp.buf.rename()<CR>", { noremap = true})

-- 显示报错
vim.keymap.set("n", "<leader>se", vim.diagnostic.open_float)

-- CodeCompletion
vim.keymap.set({ "n", "v" }, "<leader>ac", "<cmd>CodeCompanionChat Toggle<cr>", { noremap = true, silent = true })
vim.keymap.set({ "n", "v" }, "<leader>ai", ":CodeCompanion ", { noremap = true, silent = false})
vim.keymap.set("v", "ga", "<cmd>CodeCompanionChat Add<cr>", { noremap = true, silent = true })

-- 切换窗口
vim.keymap.set({ "n", "v" }, '<C-h>', '<C-w>h');
vim.keymap.set({ "n", "v" }, '<C-k>', '<C-w>k');
vim.keymap.set({ "n", "v" }, '<C-j>', '<C-w>j');
vim.keymap.set({ "n", "v" }, '<C-k>', '<C-w>k');


