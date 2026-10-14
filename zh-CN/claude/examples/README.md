# Claude Code 示例

规则位于 `../global/` 与 `../project/`；本目录存放可分别选择的 settings、MCP 配置和提示词，不配置 Claude 网页／桌面账户指令。参见[Claude 指南](../README.md)与[安装映射](../../docs/installation.md)。

| 源文件 | 原生安装目标／用法 |
|---|---|
| [settings.example.json](settings.example.json) | 审查后合并到 `~/.claude/settings.json` |
| [settings.project.example.json](settings.project.example.json) | 审查后合并到 `{project}/.claude/settings.json` |
| [mcp.example.json](mcp.example.json) | 审查后合并到 `{project}/.mcp.json` |
| [PROMPTS.md](PROMPTS.md) | Claude Code 任务提示词；按安装方式选择本地或账户同步的 Skill 名称 |

先备份已有文件，再合并所选字段。JSON 不支持注释。项目内个人覆盖放在 `.claude/settings.local.json`，不提交到 Git。用户／本地 MCP 定义位于 `~/.claude.json`，通过 `claude mcp` 管理；`mcpServers` 不应放进 settings JSON。[设置作用域](https://code.claude.com/docs/en/settings)、[MCP 作用域](https://code.claude.com/docs/en/mcp)

## 核心设置

用户示例选择 `opus`，并通过 `modelSettings` 为 `claude-opus-5-5` 设置 `xhigh`。使用前确认账号／提供商可用。别名可能升级到新模型，届时应重新核对按模型设置的键。用户级顶层 `effortLevel` 不适用于 Opus 5.5，不能替代该条目。模型选择、推理强度、上下文窗口和实际后端身份是不同观察项。[官方模型配置](https://code.claude.com/docs/en/model-config)

用户设置保护常见主目录凭据。项目设置保护 `.env`、`.env.*` 与 `secrets/**`；`Read(!.env.example)` 放在同一列表的宽泛 `.env.*` 拒绝规则之后，使公开示例保持可读。否定模式不能抵消另一设置来源的 deny。保留现有 Bash 与 PowerShell ask 规则，覆盖 commit、push、tag、publish、delete 及会丢弃未提交工作的 Git 操作。这些是工具权限防护，不是操作系统隔离，也不能阻止所有包装脚本。[权限语义](https://code.claude.com/docs/en/permissions)

两份 settings 保留 attribution 偏好与 `enableAllProjectMcpServers = false`。后者是审批偏好，不能证明无交互会话无法连接。应在实际客户端验证生效权限与服务器状态。

## 推荐 MCP 组合

示例以原生 HTTP 条目配置 DeepWiki 与 Tavily：

- DeepWiki：通过 `https://mcp.deepwiki.com/mcp` 研究公共仓库，无需 API key；重要回答仍应核对相应版本源码。[官方服务](https://docs.devin.ai/work-with-devin/deepwiki-mcp)
- Tavily：通过 `https://mcp.tavily.com/mcp` 检索网页和提取正文，使用 `Authorization: Bearer ${TAVILY_API_KEY}`。变量必须位于客户端进程环境中，仅复制 `.env` 不会配置 HTTP 连接。服务可能提供其他研究／抓取工具，只在任务需要时调用。[官方服务与认证](https://docs.tavily.com/documentation/mcp)

复制完整 MCP 示例前先配置凭据。只安装 DeepWiki 时，仅合并该条目。通过 Claude Code 原生流程批准选定的项目服务。已有账户连接器或插件提供相同服务时复用已有入口。参见[凭据配置](../../docs/installation.md#environment-variables)。

改用 Tavily OAuth 时，移除其 `headers` 块，在目标客户端通过 `/mcp` 认证。用户作用域可先运行 `claude mcp add --scope user --transport http tavily https://mcp.tavily.com/mcp`，再完成 OAuth。这些安装指引不代表仓库已完成账户认证。

使用 Tavily 本地替代方式时，先核对 Node.js/npm 与实际解析的包版本，再用下列条目替换：

```json
{
  "tavily": {
    "command": "npx",
    "args": ["-y", "tavily-mcp"],
    "env": {"TAVILY_API_KEY": "${TAVILY_API_KEY}"}
  }
}
```

将该条目合并到现有 `mcpServers` 对象。部分本地服务会自行读取 `.env`；这里采用明确的客户端环境继承作为可移植的配置方式。[Claude 环境变量展开](https://code.claude.com/docs/en/mcp#environment-variable-expansion-in-mcp-json)

Context7 可用于库／SDK 文档；OpenAI Docs 可在 Claude 中用于 OpenAI 研究；Microsoft Learn 可用于微软技术。浏览器 MCP 用于需要真实页面交互的任务。只增加所需原生条目，参见[MCP 路由](../../docs/mcp-routing.md)。

## 可选设置，不作为通用默认值

只合并适用于目标环境的片段：

| 选择 | 示例 | 作用域与权衡 |
|---|---|---|
| 原生 PowerShell 工具 | `"env": {"CLAUDE_CODE_USE_POWERSHELL_TOOL": "1"}` | Windows／提供商相关；当前 Windows 客户端通常已启用。其他系统需要 `pwsh`。 |
| 有界的提前压缩 | `"modelSettings": {"claude-opus-5-5": {"effortLevel": "xhigh", "autoCompactWindow": 400000}}` | 工作负载试验值，不是最优结论；合并时保留同一模型下已有字段。 |
| 长时间前台操作 | `"env": {"BASH_DEFAULT_TIMEOUT_MS": "600000", "BASH_MAX_TIMEOUT_MS": "3600000"}` | 适用于 Bash／PowerShell，允许更长等待；仅在工作负载需要时采用。 |
| Agent Teams | `"env": {"CLAUDE_CODE_EXPERIMENTAL_AGENT_TEAMS": "1"}` | 实验功能，默认关闭；明确选择后再启用。 |

`CLAUDE_AUTOCOMPACT_PCT_OVERRIDE` 可以降低触发比例，不能将其提高到模型默认阈值以上。理解比例与窗口的关系后再组合配置。个人状态栏、插件、主题与时区不作为公开要求。参见[环境变量](https://code.claude.com/docs/en/env-vars)与[压缩说明](https://code.claude.com/docs/en/model-config#context-window-and-auto-compaction)。

## 验证与恢复

解析 JSON，并按当前官方契约核对选中字段。在新的目标会话中运行 `claude doctor`，检查 `/status`、`/model`、`/permissions` 与 `/mcp`。一次 `-p` 请求成功不能证明全部设置已加载：非交互模式可能跳过无效设置。另行检查 MCP 连接、工具发现和一次有界的公共数据调用。[设置诊断](https://code.claude.com/docs/en/settings)

声明权限实际生效前，用不含真实凭据的合成文件验证拒绝与允许行为。恢复时只撤销试验新增字段，保留用户后续修改；新增 MCP 通过原生客户端流程断开。[兼容性记录](../../docs/compatibility.md)说明仓库实际完成了哪些检查。
