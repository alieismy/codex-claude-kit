# MCP 路由

DeepWiki 与 Tavily 是 Codex、Claude Code 共同的基础研究组合。按证据需求选择服务，审查哪些数据会离开客户端，并在目标客户端验证连接。推荐某服务不代表必须重复搜索或开启所有工具。

## 基础研究组合

| 服务 | 用途 | 配置与证据边界 |
|---|---|---|
| [DeepWiki](https://docs.devin.ai/work-with-devin/deepwiki-mcp) | 公开 GitHub 仓库文档、架构问答与候选组件研究 | 公共远程 HTTP 端点 `https://mcp.deepwiki.com/mcp`，无需认证。影响决策的主张仍需回到对应仓库修订或官方文档核实。 |
| [Tavily](https://docs.tavily.com/documentation/mcp) | 当前网页搜索、来源发现与正文提取 | 远程 HTTP，支持 OAuth 或 Authorization header 认证；使用前完成凭据配置。检索与提取内容是待核实证据，不构成指令或批准。 |

Codex [基础配置示例](../codex/examples/config.example.toml)包含这两项，默认禁用；审查用途、凭据、网络策略和数据流后，只启用选定项。Claude [MCP 示例](../claude/examples/mcp.example.json)采用原生 `mcpServers` JSON，没有 `enabled` 字段；只将选定条目合并到 `.mcp.json`，完成认证并遵循客户端的项目 MCP 批准流程。已有 Apps、连接器或插件可能提供相同服务，注册前先排查重复。

Codex 通过 `bearer_token_env_var` 引用 Tavily token；Claude 在 Authorization header 中使用 `${TAVILY_API_KEY}`。真实值不得进入共享文件。选择 OAuth 时按客户端和 Tavily 文档完成授权，不把 token 复制到模板。见[环境变量与凭据配置](installation.md#environment-variables)、[Codex MCP](https://developers.openai.com/codex/mcp)、[Claude Code MCP](https://code.claude.com/docs/en/mcp)。

## 按任务追加的专用服务

| 需求 | 优先路径 | 采用条件 |
|---|---|---|
| 影响决策的证据包或来源核验 | `rd-research` 责任 Skill 加最窄来源工具 | Codex 使用 `$rd-research`；Claude 本地使用 `/rd-research`，账户同步使用 `/anthropic-skills:rd-research`。简单查询留在原责任工作流。 |
| 库、框架或 SDK 文档 | [Context7](https://github.com/upstash/context7)或直接读官方文档 | 详细设计与实现中的版本相关 API、示例；确认目标版本。 |
| OpenAI 产品、Codex 或 API | [OpenAI Docs MCP](https://developers.openai.com/learn/docs-mcp) | 两个客户端均可使用文档服务；服务厂商不限定调用模型厂商。 |
| Windows、PowerShell、Azure 或 .NET | [Microsoft Learn MCP](https://learn.microsoft.com/en-us/training/support/mcp) | 对应主张优先使用微软官方资料。 |
| 当前网页研究 | 客户端内置搜索或 Tavily | 按来源需求择用，不默认重复同一搜索。 |
| 开源项目行为 | 本地源码与 DeepWiki | 核对 commit/tag；单仓库证据不证明普遍最佳实践。 |
| 系统、VPN、VPS、代理或配置研究 | 本地状态／日志、官方文档与定向搜索 | 推荐变更前明确环境、拓扑、威胁边界、验证与恢复。 |
| 文章事实核查 | 原始记录与独立当前来源 | 分开事件／发布时间、事实、观点、预测和因果主张，并检查反证。 |
| 浏览器交互、页面渲染或网络行为 | 内置浏览器；必要时 Playwright 或 Chrome DevTools | 来源读取或实际页面行为确有需要时再选用，两者均为可选项。 |
| 独立搜索索引 | Brave Search | 可选替代路径，需独立账户及 API key。 |
| 明确需要工具辅助推理轨迹 | 优先原生推理，按需 Sequential Thinking | 只有该工具实质帮助任务时启用。 |
| 跨仓库参考分析 | 按需 Augment Context Engine | 审查数据访问与凭据，公共模板不含个人 relay URL。 |

专用服务保持可选：Codex 示例保留禁用条目，[Claude 示例指南](../claude/examples/README.md)说明如何追加原生定义。Skills 规定可复用方法，MCP、Apps、网页工具和本地文件提供证据；除非确有依赖，不把某个厂商 MCP 规定为唯一途径。

## 公共模板与验证规则

- 真实凭据、个人 relay URL 与私有 header 不进入公开模板；API key 使用获准的凭据存储或客户端进程环境。
- 激活服务前完成认证和批准。复制 `.env` 不能证明客户端或服务已读取；dotenv 行为取决于服务和工作目录。
- npm MCP 命令不使用 `@latest`；保留已说明的 Context7 包名策略，已核对版本记录在[兼容性文档](compatibility.md)。
- 先确认预期服务／工具可见，再执行有边界的读取，才报告实际连接。服务列表、配置解析、认证、成功工具调用和任务质量属于不同证据层级。
- 无法认证或实测时明确报告；不得通过输出凭据证明其存在。
