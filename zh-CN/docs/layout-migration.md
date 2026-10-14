# 源目录布局迁移

codex-claude-kit 将共享规则和 Skills 与 Codex、Claude 平台专有模板分开维护，中文载体放入 `zh-CN/`，共用英文版 Claude 账户指令指南（无中文版指令正文）保留在 `docs/`。下表是源路径，不是安装路径；安装规则时去掉 `.template` 后缀，使用客户端原生文件名。

## 当前规则与示例布局

`global/`、`project/` 只存放规则模板；配置、MCP 和提示词统一放在对应平台的 `examples/`。共享项目核心只有一份，源文件移回 Codex 项目目录；Claude 安装后仍通过 `@AGENTS.md` 导入目标项目根目录的核心。`.template` 后缀继续隔离分发规则与本仓库维护指令。

| 上一版源路径 | 当前源路径 | 安装目标或用途 |
|---|---|---|
| `rules/project/AGENTS.md.template` | `codex/project/AGENTS.md.template` | `{project}/AGENTS.md`，两端共享唯一核心 |
| `codex/project/config.example.toml` | `codex/examples/config.project.example.toml` | `{project}/.codex/config.toml` |
| `claude/global/settings.example.json` | `claude/examples/settings.example.json` | `~/.claude/settings.json` |
| `claude/project/settings.example.json` | `claude/examples/settings.project.example.json` | `{project}/.claude/settings.json` |
| `claude/project/mcp.example.json` | `claude/examples/mcp.example.json` | `{project}/.mcp.json` |
| `PROMPTS.md` 中的 Codex 任务正文 | `codex/examples/PROMPTS.md` | Codex 任务提示词；根文件保留为入口索引 |
| `claude/project/PROMPTS.md` | `claude/examples/PROMPTS.md` | Claude Code 任务提示词 |

对应 `zh-CN/` 路径执行相同迁移。安装位置保持原生作用域，移动源文件不会改动既有安装。以下表格记录更早的迁移步骤，表内“当时目标”应继续按上表解析为当前源路径。

## 更早的源布局迁移记录（历史）

| 更早的源路径 | 当时目标 | 安装目标 |
|---|---|---|
| `codex/project/AGENTS.md` | `rules/project/AGENTS.md.template` | `{project}/AGENTS.md` |
| `zh-CN/codex/project/AGENTS.md` | `zh-CN/rules/project/AGENTS.md.template` | `{project}/AGENTS.md` |
| `codex/global/AGENTS.md` | `codex/global/AGENTS.md.template` | `{CODEX_HOME}/AGENTS.md` |
| `claude/global/CLAUDE.md` | `claude/global/CLAUDE.md.template` | `~/.claude/CLAUDE.md` |
| `claude/project/CLAUDE.md` | `claude/project/CLAUDE.md.template` | `{project}/CLAUDE.md` |
| `claude/project/.claude/settings.json` | `claude/project/settings.example.json` | `{project}/.claude/settings.json` |
| `claude/project/.claude/skills/rd-*` | `skills/rd-*` | 所选本地根或账号上传 |
| `cursor/project/.cursor/skills/rd-*` | `skills/rd-*` | 所选本地根 |
| `zh-CN/claude/project/.claude/skills/rd-*` | `zh-CN/skills/rd-*` | 所选本地根或账号上传 |
| `cursor/zh-CN/.cursor/skills/rd-*` | `zh-CN/skills/rd-*` | 所选本地根 |

Codex、Claude 全局/项目模板迁移同样适用于其 `zh-CN/` 镜像。共享项目核不依赖平台，Claude 项目模板继续使用 `@AGENTS.md` 薄适配。该历史阶段保留 Codex 用户配置示例路径，并新增选定入口： `codex/project/config.example.toml`、`claude/global/settings.example.json`、`claude/project/mcp.example.json` 及其中文版本。

## Cursor 退役与名称迁移

2026-10-13 的支持范围调整将仓库名称改为 `codex-claude-kit`，移除 Cursor 专属规则、配置、安装配方与当前门禁。Claude Code 是 Claude 的主要入口；Claude 网页版／桌面版适用的指令与 Skills，以及 ChatGPT 网页版专用指令仍受支持。

| 旧源路径 | 当前源路径／处置 | 用途 |
|---|---|---|
| `cursor/project/PROMPTS.md` | `claude/project/PROMPTS.md` | Claude Code 任务启动提示词 |
| `zh-CN/cursor/project/PROMPTS.md` | `zh-CN/claude/project/PROMPTS.md` | 中文 Claude Code 任务启动提示词 |
| Cursor 专属规则、MCP 与适配说明 | 从当前分发源移除 | 停止当前支持，历史 Git 记录仍保留 |

上表中的旧 Cursor Skill 镜像描述此前已完成的源合并；共享 Skills 不因 Cursor 退役而删除。2026-10-12 的布局／安装探针保留在[兼容性记录](compatibility.md)，其旧路径是历史测试输入，不是当前安装入口。已有个人 Cursor 安装不会随源码退役自动删除或停用。

名称迁移中的本地源引用与 GitHub 仓库身份是不同状态；远端更名及 remote URL 更新须实际执行并核实后报告。历史报告、证据路径和已发布版本的事实保持原样。

## 源、安装与账户边界

`skills/` 和 `zh-CN/skills/` 是唯一维护的两棵 Skill 源树；内容相同的旧平台适配副本从源码布局移除。claude.ai 打包直接读取对应语言源，排除仅用于仓库的 `evals/` 和 `agents/`。`~/.claude/skills/synced/` 账号缓存仅可作为选配的只读比较目标，不是可编辑源，也不是上传暂存树。

仓库源路径迁移或删除不会移动、删除、更新、上传或停用用户/项目/账号中已安装的 Skill。个人 settings 与规则同样是独立部署，应另外决定更新语言、范围、备份与授权。不能因旧仓库镜像消失就删除个人副本。

Codex 默认复用明确的 `.agents/skills` 来源，不追加项目副本。Claude 桌面/聊天与登录同一账号的 Claude Code 可共享账号上传 Skills。公共项目/团队安装与 Claude Code 本地 fallback 仍可通过既有安装器 `-DestinationRoot` 从所选语言源安装，不依赖维护者的个人机器状态。

## 迁移步骤

1. 明确语言、平台、规则作用域、settings/MCP 作用域及 Skill 来源，盘点已有原生目标和同名 Skills。
2. 按表更新源路径引用；保留日期化证据和历史 fixture 路径，它们描述实际测试过的布局。
3. 审阅并备份已有目标。首次安装逐文件复制规则模板并去掉 `.template`；settings/MCP 按需合并，不覆盖。
4. 保留 `AGENTS.override.md` 的生效边界和 Claude 导入目标非空检查；有 override 时先明确选择相应导入。
5. 检查安装文件名、配置解析、引用和来源/作用域，并在新的目标客户端会话验证。仓库静态检查不证明客户端加载、账号上传或业务验收。

本次使用非原生源路径及模板后缀，减少源码维护时误发现分发材料的机会。根 `.claude/settings.json` 是仅用于维护的空对象，不是下游配置。旧排除与嵌套 Skill 探针的原布局和限制保留在[兼容性记录](compatibility.md)；新的隔离证据须单独记录，改路径本身不是运行验证结果。

原生安装防覆盖配方及可选 Skills 安装见[安装说明](installation.md#source-and-destination-map)。Git 提交、发布、更新个人安装与上传账号分别需要相应授权。
