local overseer = require("overseer")

overseer.register_template({
	name = "CMake Build Debug",

	builder = function()
		return {
			cmd = { "cmake", "--build", "--preset", "Debug" },

			components = {
				"default",
				{
					"on_output_quickfix",
					open = true,
				},
			},
		}
	end,
})

-- 快捷键设置
local function run_cmake_build()
	vim.cmd("silent! wa") -- 关键：强制保存

	overseer.run_template({ name = "CMake Build Debug" })
end

vim.keymap.set("n", "<F5>", run_cmake_build)
