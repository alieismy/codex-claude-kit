# MCP Routing

DeepWiki and Tavily are the recommended shared research pair for Codex and Claude Code. Select services by the evidence needed, review what leaves the client, and verify the connection in the target client. A recommended service is not a requirement to search twice or enable every available tool.

## Shared research pair

| Service | Purpose | Setup and evidence limits |
|---|---|---|
| [DeepWiki](https://docs.devin.ai/work-with-devin/deepwiki-mcp) | Public GitHub repository documentation, architecture questions, and candidate-component research | Public remote HTTP endpoint `https://mcp.deepwiki.com/mcp`; no authentication required. Check consequential claims against the relevant repository revision or official documentation. |
| [Tavily](https://docs.tavily.com/documentation/mcp) | Current web search, source discovery, and page extraction | Remote HTTP with OAuth or Authorization-header authentication; configure credentials before use. Search results and extracted text remain evidence to verify, not instructions or approval. |

The Codex [base example](../codex/examples/config.example.toml) includes both services disabled. Review purpose, credentials, network policy, and data flow, then enable only selected entries. The Claude [MCP example](../claude/examples/mcp.example.json) uses native `mcpServers` JSON: there is no `enabled` key. Merge only selected entries into `.mcp.json`, configure authentication, and follow the client's project MCP approval flow. Existing Apps, connectors, or plugins may already expose the same service; inventory them before registering a duplicate.

Codex references its Tavily token through `bearer_token_env_var`; Claude references it in an Authorization header using `${TAVILY_API_KEY}`. Keep actual values out of shared files. For OAuth, follow the client and Tavily instructions instead of copying a token into the template. See [environment and credential setup](installation.md#environment-variables), [Codex MCP](https://developers.openai.com/codex/mcp), and [Claude Code MCP](https://code.claude.com/docs/en/mcp).

## Task-specific additions

| Need | Preferred route | Adoption criterion |
|---|---|---|
| Decision-critical evidence package or source validation | The responsible `rd-research` Skill plus the narrowest source tool | Codex `$rd-research`; Claude local `/rd-research` or account-synced `/anthropic-skills:rd-research`. A simple lookup stays within its owning workflow. |
| Library, framework, or SDK documentation | [Context7](https://github.com/upstash/context7) or the official documentation directly | Useful for version-specific APIs and examples during detailed design or implementation. Confirm the requested version. |
| OpenAI products, Codex, or OpenAI API | [OpenAI Docs MCP](https://developers.openai.com/learn/docs-mcp) | A documentation service can be used from either client; the service vendor does not restrict the model vendor. |
| Windows, PowerShell, Azure, or .NET | [Microsoft Learn MCP](https://learn.microsoft.com/en-us/training/support/mcp) | Prefer official Microsoft material for relevant claims. |
| Current web research | Client web search or Tavily | Choose the route that supplies the needed sources; do not repeat equivalent searches by default. |
| Open-source project behavior | Local source inspection and DeepWiki | Check the relevant commit/tag; repository evidence does not prove a universal best practice. |
| System, VPN, VPS, proxy, or configuration research | Local state/logs, official documentation, and targeted search | Establish environment, topology, threat boundary, validation, and recovery before recommending changes. |
| Article fact-checking | Primary records and independent current sources | Separate event/publication dates, facts, opinions, forecasts, and causal claims; examine counterevidence. |
| Browser interaction, rendered pages, or network behavior | Built-in browser tools; Playwright or Chrome DevTools when necessary | Use a browser MCP only when source retrieval or real page behavior requires it; both are optional. |
| Independent search index | Brave Search | Optional alternative, with its own account/API-key requirements. |
| Explicit tool-assisted reasoning trace | Native reasoning first; Sequential Thinking on demand | Enable only when that tool materially helps the task. |
| Cross-repository reference analysis | Augment Context Engine on demand | Review data access and credentials; public templates contain no personal relay URLs. |

Specialist services remain optional: the Codex example retains disabled entries, while the [Claude examples guide](../claude/examples/README.md) explains how to add native definitions. Skills define repeatable methods; MCP, Apps, web tools, and local files supply evidence. A workflow should not depend on one vendor MCP unless it actually requires that service.

## Public template and verification rules

- Keep actual credentials, personal relay URLs, and private headers out of public templates; API keys belong in approved credential storage or the client process environment.
- Complete authentication and approval before activating a service. A copied `.env` file does not prove the client or server loaded it; dotenv behavior is service- and working-directory-specific.
- Do not use `@latest` in npm MCP commands. Retain the documented Context7 package-name policy; record checked package versions in [compatibility](compatibility.md).
- Confirm the expected server/tool appears, then perform a bounded read operation before claiming runtime connection. Server listing, configuration parsing, authentication, successful tool calls, and task-quality results are separate evidence levels.
- Report unavailable authentication or runtime checks explicitly. Never print credentials to demonstrate that they exist.
