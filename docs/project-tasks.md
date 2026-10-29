# 项目任务

在项目根目录创建 `.nv/tasks.json`，使用 VS Code tasks 的 JSON 格式。
也可以按 `<leader>te`（或执行 `:ProjectTasksEdit`）打开配置；不存在时会填入示例，保存即可。

```json
{
  "version": "2.0.0",
  "tasks": [
    {
      "label": "configure",
      "type": "process",
      "command": "cmake",
      "args": ["-S", "${workspaceFolder}", "-B", "${workspaceFolder}/build"]
    },
    {
      "label": "build",
      "type": "process",
      "command": "cmake",
      "args": ["--build", "${workspaceFolder}/build", "-j"],
      "dependsOn": ["configure"],
      "group": "build",
      "problemMatcher": "$gcc"
    },
    {
      "label": "test",
      "command": "ctest --output-on-failure",
      "options": {
        "cwd": "${workspaceFolder}/build",
        "env": { "CTEST_OUTPUT_ON_FAILURE": "1" }
      },
      "dependsOn": ["build"]
    }
  ]
}
```

| 入口 | 功能 |
| --- | --- |
| `<leader>tr` / `:OverseerRun` | 选择并运行任务 |
| `:OverseerRun build` | 按名称运行任务 |
| `<leader>tt` / `:OverseerToggle` | 显示/隐藏任务列表和输出 |
| `<leader>ta` / `:OverseerTaskAction` | 重跑、停止等任务操作 |
| `<leader>te` / `:ProjectTasksEdit` | 编辑项目任务配置 |

从当前文件所在目录向上查找最近的 `.nv/tasks.json`，找不到则从 Neovim 当前目录查找。
工作目录默认为配置所属的项目根目录，`options.cwd` 也可以写相对项目根目录的路径。
每次打开任务选择器都会重新读取文件，保存修改后无需重启 Neovim。

`label` 是任务名称；`command` 是命令。省略 `type` 时默认为 `shell`，可使用管道、重定向和 `&&`；
`process` 使用 `command` 和 `args` 直接启动进程，适合传递带空格的参数。
支持 `${workspaceFolder}`、`${file}`、`${relativeFile}`、`${env:NAME}` 等 Overseer 的 VS Code 变量，
以及 `options.env`、`inputs`、`problemMatcher`、`linux` / `osx` / `windows` 覆盖配置。

`dependsOn` 指定先运行的任务，多个依赖默认并行；设置 `dependsOrder: "sequence"` 可按顺序执行。
可以只写 `label` 和 `dependsOn` 来组合多个任务。
任务默认显示输出，可通过 `presentation.reveal: "never"` 关闭自动显示。
这些功能复用 [Overseer 的 VS Code 任务支持](https://github.com/stevearc/overseer.nvim/blob/master/doc/guides.md#vs-code-tasks)，并非完整实现全部 VS Code 配置项。
任务由你手动选择运行，原有 `<F5>` CMake Debug 构建入口保留。
