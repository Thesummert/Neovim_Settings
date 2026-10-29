local project_tasks = require("config.project_tasks")

local function warn(path, message)
	vim.notify(path .. ": " .. tostring(message), vim.log.levels.ERROR, { title = "Project tasks" })
end

---@type overseer.TemplateFileProvider
return {
	-- Read on every request, so edits outside Neovim are picked up too.
	generator = function(opts)
		local path = project_tasks.find(opts.dir)
		if not path then
			return {}
		end
		local ok, content = pcall(require("overseer.files").load_json_file, path)
		if not ok or type(content) ~= "table" or type(content.tasks) ~= "table" or not vim.islist(content.tasks) then
			warn(path, ok and "Expected an object with a tasks array" or content)
			return {}
		end

		local root = vim.fs.dirname(vim.fs.dirname(path))
		local variables = require("overseer.vscode.variables").precalculate_vars()
		variables.workspaceFolder = root
		variables.workspaceRoot = root
		variables.workspaceFolderBasename = vim.fs.basename(root)
		variables.fileWorkspaceFolder = root
		if variables.file ~= "" then
			variables.relativeFile = vim.fs.relpath(root, variables.file) or variables.file
			variables.relativeFileDirname = vim.fs.dirname(variables.relativeFile)
		end

		local defaults = {
			options = { cwd = root },
			presentation = { reveal = "always" },
		}
		for key, value in pairs(content) do
			if key ~= "version" and key ~= "tasks" then
				defaults[key] = value
			end
		end
		local os_key = vim.fn.has("win32") == 1 and "windows" or (vim.fn.has("mac") == 1 and "osx" or "linux")
		defaults = vim.tbl_deep_extend("force", defaults, content[os_key] or {})

		local templates = {}
		for index, task in ipairs(content.tasks) do
			local converted, template = pcall(function()
				assert(type(task) == "table", "task must be an object")
				assert(type(task.label) == "string" and task.label ~= "", "task needs a label")
				local defn = vim.tbl_deep_extend("force", defaults, task, task[os_key] or {})
				if defn.command and not defn.type then
					defn.type = "shell"
				end
				if defn.type == "shell" or defn.type == "process" then
					assert(type(defn.command) == "string" and defn.command ~= "", "task needs a command string")
				end
				local tmpl = require("overseer.vscode").convert_vscode_task(defn, variables)
				assert(tmpl, "unsupported task type or missing command/dependsOn")
				local builder = tmpl.builder
				tmpl.builder = function(params)
					local result = builder(params)
					-- VS Code resolves relative working directories from the workspace.
					local cwd = result.cwd or root
					if not require("overseer.files").is_absolute(cwd) then
						cwd = vim.fs.joinpath(root, cwd)
					end
					result.cwd = vim.fs.normalize(cwd)
					return result
				end
				return tmpl
			end)
			if converted then
				table.insert(templates, template)
			else
				warn(path, string.format("task #%d: %s", index, template))
			end
		end
		return templates
	end,
}
