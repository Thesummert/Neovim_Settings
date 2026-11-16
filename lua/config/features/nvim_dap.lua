local dap = require("dap")

dap.adapters.gdb = {
	type = "executable",
	command = "gdb",
	args = { "--interpreter=dap", "--eval-command", "set print pretty on" },
}

local function load_project_dap()
	local root = vim.fn.getcwd()

	local config_file = root .. "/dap.lua"

	if vim.fn.filereadable(config_file) == 0 then
		print("No .dap.lua found")
		return {}
	end

	local project_config = dofile(config_file)

	return {
		{
			name = project_config.name,

			type = project_config.adapter,

			request = "launch",

			program = function()
				return root .. "/" .. project_config.program
			end,

			cwd = project_config.cwd,

			args = project_config.args,

			target = project_config.target,
			stopAtBeginningOfMainSubprogram = true,
		},
	}
end

-- dap.configurations.c = load_project_dap()
dap.configurations.c = {
  {
    name = "Launch",
    type = "gdb",
    request = "launch",
    program = function()
      return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
    end,
    args = {}, -- provide arguments if needed
    cwd = "${workspaceFolder}",
    stopAtBeginningOfMainSubprogram = false,
  },
  {
    name = "Select and attach to process",
    type = "gdb",
    request = "attach",
    program = function()
      return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
    end,
    pid = function()
      local name = vim.fn.input('Executable name (filter): ')
      return require("dap.utils").pick_process({ filter = name })
    end,
    cwd = '${workspaceFolder}'
  },
  {
    name = 'Attach to gdbserver :1234',
    type = 'gdb',
    request = 'attach',
    target = 'localhost:1234',
    program = function()
      return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
    end,
    cwd = '${workspaceFolder}'
  }
}
