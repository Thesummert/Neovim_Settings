local M = {}

local function find_from(dir)
	while dir do
		local path = vim.fs.joinpath(dir, ".nv", "tasks.json")
		if vim.fn.filereadable(path) == 1 then
			return path
		end
		local parent = vim.fs.dirname(dir)
		dir = parent ~= dir and parent or nil
	end
end

-- Prefer the active file's project, then fall back to the current directory.
function M.find(dir)
	if not dir then
		local name = vim.api.nvim_buf_get_name(0)
		dir = vim.bo.buftype == "" and name ~= "" and vim.fs.dirname(name) or vim.fn.getcwd()
	end
	return find_from(dir) or find_from(vim.fn.getcwd())
end

function M.edit()
	local path = M.find()
	if not path then
		local root = vim.fs.root(0, ".git") or vim.fn.getcwd()
		path = vim.fs.joinpath(root, ".nv", "tasks.json")
		vim.fn.mkdir(vim.fs.dirname(path), "p")
	end
	vim.cmd.edit(vim.fn.fnameescape(path))
	if vim.fn.filereadable(path) == 0 and vim.api.nvim_buf_line_count(0) == 1 and vim.fn.getline(1) == "" then
		vim.api.nvim_buf_set_lines(0, 0, -1, false, {
			'{',
			'  "version": "2.0.0",',
			'  "tasks": [',
			'    {',
			'      "label": "hello",',
			'      "type": "shell",',
			'      "command": "echo Hello from ${workspaceFolderBasename}"',
			'    }',
			'  ]',
			'}',
		})
	end
end

function M.setup()
	vim.api.nvim_create_user_command("ProjectTasksEdit", M.edit, { desc = "Edit .nv/tasks.json" })
	vim.keymap.set("n", "<leader>tr", "<cmd>OverseerRun<cr>", { desc = "Run task" })
	vim.keymap.set("n", "<leader>tt", "<cmd>OverseerToggle<cr>", { desc = "Toggle tasks and output" })
	vim.keymap.set("n", "<leader>ta", "<cmd>OverseerTaskAction<cr>", { desc = "Task actions" })
	vim.keymap.set("n", "<leader>te", M.edit, { desc = "Edit project tasks" })
end

return M
