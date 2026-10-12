# 源目录布局迁移

本次布局将共享规则和 Skills 与平台专有模板分开维护，所有中文载体统一放入 `zh-CN/`。下表是源路径，不是安装路径；安装规则时去掉 `.template` 后缀，使用客户端原生文件名。

## 旧路径与新路径

| 旧源路径 | 当前源路径 | 安装目标 |
|---|---|---|
| `codex/project/AGENTS.md` | `rules/project/AGENTS.md.template` | `{project}/AGENTS.md` |
| `zh-CN/codex/project/AGENTS.md` | `zh-CN/rules/project/AGENTS.md.template` | `{project}/AGENTS.md` |
| `codex/global/AGENTS.md` | `codex/global/AGENTS.md.template` | `{CODEX_HOME}/AGENTS.md` |
| `claude/global/CLAUDE.md` | `claude/global/CLAUDE.md.template` | `~/.claude/CLAUDE.md` |
| `claude/project/CLAUDE.md` | `claude/project/CLAUDE.md.template` | `{project}/CLAUDE.md` |
| `claude/project/.claude/settings.json` | `claude/project/settings.example.json` | `{project}/.claude/settings.json` |
| `cursor/project/.cursor/rules/*.mdc` | `cursor/project/rules/*.mdc.template` | `{project}/.cursor/rules/*.mdc` |
| `cursor/project/.cursor/mcp.example.json` | `cursor/project/mcp.example.json` | `{project}/.cursor/mcp.json`（选配） |
| `cursor/zh-CN/README.md` | `zh-CN/cursor/README.md` | 仅文档 |
| `cursor/zh-CN/.cursor/rules/*.mdc` | `zh-CN/cursor/project/rules/*.mdc.template` | `{project}/.cursor/rules/*.mdc` |
| `cursor/zh-CN/.cursor/mcp.example.json` | `zh-CN/cursor/project/mcp.example.json` | `{project}/.cursor/mcp.json`（选配） |
| `cursor/zh-CN/PROMPTS.md` | `zh-CN/cursor/project/PROMPTS.md` | 按需安装提示词参考 |
| `claude/project/.claude/skills/rd-*` | `skills/rd-*` | 所选本地根或账号上传 |
| `cursor/project/.cursor/skills/rd-*` | `skills/rd-*` | 所选本地根 |
| `zh-CN/claude/project/.claude/skills/rd-*` | `zh-CN/skills/rd-*` | 所选本地根或账号上传 |
| `cursor/zh-CN/.cursor/skills/rd-*` | `zh-CN/skills/rd-*` | 所选本地根 |

Codex、Claude 全局/项目模板迁移同样适用于其 `zh-CN/` 镜像。共享项目核不依赖平台，Claude 项目模板继续使用 `@AGENTS.md` 薄适配。既有 Codex 用户配置示例路径保留；新增选定入口包括 `codex/project/config.example.toml`、`claude/global/settings.example.json`、`claude/project/mcp.example.json`、`cursor/global/RULES.md.template` 及其中文版本。

## 源、安装与账户边界

`skills/` 和 `zh-CN/skills/` 是唯一维护的两棵 Skill 源树；内容相同的旧平台适配副本从源码布局移除。claude.ai 打包直接读取对应语言源，排除仅用于仓库的 `evals/` 和 `agents/`。`~/.claude/skills/synced/` 账号缓存仅可作为选配的只读比较目标，不是可编辑源，也不是上传暂存树。

仓库源路径迁移或删除不会移动、删除、更新、上传或停用用户/项目/账号中已安装的 Skill。个人 settings 与规则同样是独立部署，应另外决定更新语言、范围、备份与授权。不能因旧仓库镜像消失就删除个人副本。

Codex 与本机 Cursor 默认复用明确的 `.agents/skills` 来源，不追加项目副本。Cursor 官方文档支持兼容发现，但本次迁移没有验证运行选中的定义。Claude 桌面/聊天与登录同一账号的 Claude Code 可共享账号上传 Skills。公共项目/团队安装与 Claude Code 本地 fallback 仍可通过既有安装器 `-DestinationRoot` 从所选语言源安装，不依赖维护者的个人机器状态。

## 迁移步骤

1. 明确语言、平台、规则作用域、settings/MCP 作用域及 Skill 来源，盘点已有原生目标和同名 Skills。
2. 按表更新源路径引用；保留日期化证据和历史 fixture 路径，它们描述实际测试过的布局。
3. 审阅并备份已有目标。首次安装逐文件复制规则模板并去掉 `.template`；settings/MCP 按需合并，不覆盖。
4. 保留 `AGENTS.override.md` 的生效边界和 Claude 导入目标非空检查；有 override 时先明确选择相应导入。
5. 检查安装文件名、配置解析、引用和来源/作用域，并在新的目标客户端会话验证。仓库静态检查不证明客户端加载、账号上传或业务验收。

本次使用非原生源路径及模板后缀，减少源码维护时误发现分发材料的机会。根 `.claude/settings.json` 是仅用于维护的空对象，不是下游配置。旧排除与嵌套 Skill 探针的原布局和限制保留在[兼容性记录](compatibility.md)；新的隔离证据须单独记录，改路径本身不是运行验证结果。

原生安装防覆盖配方及可选 Skills 安装见[安装说明](installation.md#source-and-destination-map)。Git 提交、发布、更新个人安装与上传账号分别需要相应授权。
