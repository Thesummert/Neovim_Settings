# Neovim 配置

入口是 `init.lua`，按原有顺序加载基础设置、插件管理器和插件相关配置。`<Leader>` 是空格。

```text
init.lua                         配置入口及加载顺序
lua/config/core/                 基础选项、快捷键、lazy.nvim 启动配置
lua/config/features/             状态栏、界面、代码片段和调试配置
lua/config/project_tasks.lua     项目任务查找和命令
lua/plugins/                     按功能分类的 lazy.nvim 插件声明
lua/overseer/template/           Overseer 项目任务模板
docs/project-tasks.md            项目任务的配置和用法
```

基础快捷键位于 `lua/config/core/keymaps.lua`；插件快捷键保留在各自的 `lua/plugins/` 文件和项目任务模块中，便于查看对应功能。部分按键在基础配置和插件声明中都有定义，因此调整它们时需要同时检查两处及加载顺序。

基础选项分为插件加载前的 `early_options.lua` 和加载后的 `options.lua`，以保留现有的初始化顺序。插件版本锁文件 `lazy-lock.json` 由 lazy.nvim 管理。
