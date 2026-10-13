# MCP 路由

MCP 服务器应为具体证据或工作流需求启用，不应作为宽泛默认值。

Codex 配置和 Claude 项目 `mcp.example.json` 是按需审阅的起步示例，不是下列全部路由的清单。只有存在已验证用途时才加入其它 server，独立配置其凭据，并在目标客户端确认状态。Claude settings 与 MCP 的存储位置不同，安装入口见[安装说明](installation.md)。

当任务需要来源收集、文献调研、标准或政策核验、开源或 AI 工具评估、仓库证据、系统配置调查、公共事实核实、成本假设或技术成熟度证据时，在 Codex 使用 `$rd-research`、Claude Code 本地 Skills 使用 `/rd-research`、账户同步 Skills 使用 `/anthropic-skills:rd-research` 作为 Skill 层封装。

## 路由表

| 需求 | 优先路径 | 备注 |
|---|---|---|
| 证据包或来源核验 | `$rd-research` 加最窄可用来源工具 | 在可研、方案、标准、写作或事实依赖型评审前或过程中使用。 |
| 库、框架、SDK 文档 | Context7 | 需要官方文档或示例时启用。 |
| 当前 Web 研究 | Codex 内置 `web_search` 或 Tavily | 时效性事实必须使用当前来源。 |
| 开源或仓库研究 | 本地源码检查或 GitHub/DeepWiki | 仓库只能证明该仓库内事实，不能作为通用最佳实践权威。 |
| 系统、VPN、VPS、代理或配置研究 | 本地状态/日志、当前官方文档和定向 Web 检索 | 推荐变更前先建立环境、拓扑、威胁边界、验证证据和回退方案。 |
| 文章事实核查 | 原始记录和独立的当前来源 | 拆分主张，区分事件/发布日期，并检验反证和替代解释。 |
| 复杂多方案推理 | 原生模型推理优先；Sequential Thinking 按需 | 只有明确需要推理轨迹工具时启用。 |
| 开源项目架构 | DeepWiki 按需 | 适用于公开 GitHub 项目。 |
| 独立搜索索引 | Brave Search 按需 | 需要 API key 和账号设置。 |
| 官方页面或文档来源的浏览器检查 | 内置浏览器工具优先 | 只有 MCP 能明显改善来源检查时启用 Playwright MCP。 |
| 被引用系统的网页 / 网络检查 | Chrome DevTools MCP 按需 | 默认禁用。 |
| 跨仓库参考分析 | Augment Context Engine 按需 | 不提交个人 relay URL。 |

## 公开模板规则

- npm MCP 命令中不要使用 `@latest`。
- 需要 API key 的 MCP 服务器在凭据配置前不要启用。
- 不硬编码私有 relay URL。
- 除非仓库明确记录数据流，否则外部服务默认禁用。
- 已验证包版本记录在 `docs/compatibility.md` 和 `zh-CN/docs/compatibility.md`。
- Skill 定义可重复工作流；MCP、App 和 Web 工具提供当前或私有证据。除非 Skill 确实依赖某项能力，不把单一厂商 MCP 写成唯一通路。
