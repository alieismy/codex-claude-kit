# Codex 示例

这里是可分别选择的源示例，不是已安装的 `.codex` 目录。规则位于 `../global/` 和 `../project/`，Skills 另行选择。参见[安装指南](../../docs/installation.md)与[配置指导](../../docs/codex-configuration-guidance.md)。

| 源文件 | 类型 | 安装目标／用法 |
|---|---|---|
| [config.example.toml](config.example.toml) | 用户配置起点 | 审查后合并到 `$CODEX_HOME/config.toml`，默认 `~/.codex/config.toml` |
| [config.project.example.toml](config.project.example.toml) | 最小项目覆盖 | 合并到受信任项目的 `.codex/config.toml`，保留用户模型与 MCP 选择 |
| [config.full-access.example.toml](config.full-access.example.toml) | 可选权限 profile 片段 | 仅当目标不存在时复制到 `$CODEX_HOME/full-access.config.toml`，然后以 `codex --profile full-access` 选用 |
| [PROMPTS.md](PROMPTS.md) | 任务提示词 | 替换占位内容后粘贴到 Codex 会话 |

已有目标文件应先备份再合并，不用示例覆盖正常工作的配置。full-access 片段不能替代用户主配置。Profile 使用独立的 `<name>.config.toml` 文件；项目配置与 CLI 覆盖可能优先，因此使用前需检查实际权限。停止选择 profile 即停止应用其覆盖，但不会撤销已经执行的操作。广泛文件系统访问只适用于明确受信任的工作区。参见[官方配置优先级](https://learn.chatgpt.com/docs/config-file/config-basic#configuration-precedence)。

## 模型与权限

用户示例为主代理选择 `gpt-6-astra` 与 `xhigh` 推理强度，Plan 模式使用 `high`，子代理使用 `gpt-6.1-sol` 与 `high`。最多同时运行两个子代理，不含主代理。这是经审查的研究／设计起点，不是经过测量的最优组合；使用前确认账号和客户端可用这两个模型。显式创建子代理时指定的模型可以覆盖默认值。参见[模型](https://learn.chatgpt.com/docs/models)与[子代理](https://learn.chatgpt.com/docs/agent-configuration/subagents)。

普通配置保留 `on-request`、`workspace-write` 和关闭沙箱 shell 网络访问。内置实时检索与 MCP 是独立能力。角色描述是任务指导，子代理继承父任务当前轮次的权限；仅选择默认子代理模型无需新增角色文件。

Memories 继续启用。记忆模型、Windows MXC、服务层级和恢复方式在配置指导中作为可选项说明，不把个人环境全部复制进示例。

## MCP 选择与启用

推荐组合是用于公共仓库研究的 **DeepWiki**，以及用于网页检索与正文提取的 **Tavily**。源配置中的 MCP 均保持禁用。审查发送到服务的数据，完成必要认证，再只将选中的条目设为 `enabled = true`。

- DeepWiki 使用 `https://mcp.deepwiki.com/mcp`，无需凭据。其回答用于定位证据；重要主张仍应核对相应版本的源码。[官方服务说明](https://docs.devin.ai/work-with-devin/deepwiki-mcp)
- Tavily 使用 `https://mcp.tavily.com/mcp`，从**客户端进程环境**的 `TAVILY_API_KEY` 读取 bearer token。示例只提供 `tavily_search` 和 `tavily_extract`；任务需要时再增加其他工具。仅放置 `.env` 文件不会配置 HTTP MCP 连接。[官方认证说明](https://docs.tavily.com/documentation/mcp)
- 改用 Tavily OAuth 时，先从已安装条目移除 `bearer_token_env_var`，再使用 `codex mcp login tavily`，在目标客户端完成登录。不要把缺少 token 的条目与 OAuth 配方混用。
- HTTP 访问不适用时，可用下面的本地配置替换 Tavily 条目。它需要 Node.js/npm，并应单独核对实际包版本。同一服务只选择一种传输方式。

```toml
[mcp_servers.tavily]
command = "npx"
args = ["-y", "tavily-mcp"]
env_vars = ["TAVILY_API_KEY"]
enabled = false
tool_timeout_sec = 120
enabled_tools = ["tavily_search", "tavily_extract"]
```

`env_vars` 只转发进程中已有的变量。部分本地服务还会自行读取 `.env`，具体取决于实现和工作目录；这不是客户端的共同约定。按[凭据配置说明](../../docs/installation.md#environment-variables)设置，不输出或提交 token 值。

Context7、OpenAI Docs、Microsoft Learn 是可选专用资料源；Playwright、Chrome DevTools 是可选浏览器工具。只保留工作负载需要的来源，已有 App、连接器或插件提供相同服务时复用已有入口。参见[MCP 路由](../../docs/mcp-routing.md)。

## 在目标环境验证

1. 对选定配置执行解析／schema 检查，并使用隔离的 `CODEX_HOME` 检查配置加载。
2. 在实际客户端检查生效模型、权限和 MCP 状态；仅确认环境变量是否存在，不显示其值。修改继承环境变量后重启桌面客户端。
3. 验证服务连接、工具发现与一次有界的公共数据调用。列表显示和 schema 通过不能证明实际调用成功。
4. 修改角色或模型后，另行检查实际创建的子代理与模型。不能从解析结果推导账号权限、模型质量、记忆质量或沙箱隔离。

仓库的[兼容性记录](../../docs/compatibility.md)区分本次实际执行的检查与上述下游验收步骤。
