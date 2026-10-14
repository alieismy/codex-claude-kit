# Codex examples

These are selectable source examples, not an installed `.codex` directory. Rules are in `../global/` and `../project/`; Skills are selected separately. See the [installation guide](../../docs/installation.md) and [configuration guidance](../../docs/codex-configuration-guidance.md).

| Source | Kind | Destination / use |
|---|---|---|
| [config.example.toml](config.example.toml) | User configuration starting point | Review and merge into `$CODEX_HOME/config.toml` (default `~/.codex/config.toml`) |
| [config.project.example.toml](config.project.example.toml) | Minimal project overrides | Merge into a trusted project's `.codex/config.toml`; preserves user model/MCP choices |
| [config.full-access.example.toml](config.full-access.example.toml) | Optional permission profile fragment | Copy to `$CODEX_HOME/full-access.config.toml` only if absent, then select `codex --profile full-access` |
| [PROMPTS.md](PROMPTS.md) | Task prompts | Replace placeholders and paste into a Codex session |

Back up and merge existing destinations; copying an example must not replace a working configuration. The full-access fragment is not a replacement for the user configuration. Profiles use separate `<name>.config.toml` files. Project configuration and CLI overrides can take precedence, so inspect the effective permissions before use. Stop selecting the profile to stop applying its overrides; this does not undo actions already taken. Broad filesystem access is appropriate only for explicitly trusted workspaces. See [official configuration precedence](https://learn.chatgpt.com/docs/config-file/config-basic#configuration-precedence).

## Models and permissions

The user example selects `gpt-6-astra` with `xhigh` reasoning for the main agent, `high` in Plan mode, and `gpt-6.1-sol` with `high` reasoning for subagents. Two subagents may run concurrently, excluding the primary agent. This is a reviewed research/design starting point, not a measured optimum; confirm both models are available to the account and client. An explicit spawn model can override the subagent default. See [models](https://learn.chatgpt.com/docs/models) and [subagents](https://learn.chatgpt.com/docs/agent-configuration/subagents).

The standard configuration retains `on-request`, `workspace-write`, and disabled sandbox shell networking. Built-in live web search and MCP are separate capabilities. Role descriptions are task guidance; subagents inherit the parent turn's permissions. No separate role files are required to select the default subagent model.

Memories remain enabled. Optional memory-model choices, Windows MXC, service tiers, and recovery are documented in the configuration guide rather than copied from a personal environment into every example.

## MCP selection and activation

The recommended pair is **DeepWiki** for public repository research and **Tavily** for web search and extraction. All MCP entries remain disabled in the source configuration. Review the data sent to each service, configure authentication where required, then set only the selected entries to `enabled = true`.

- DeepWiki uses `https://mcp.deepwiki.com/mcp` without credentials. Its answers help locate evidence; verify important claims against the relevant source revision. [Official service](https://docs.devin.ai/work-with-devin/deepwiki-mcp)
- Tavily uses `https://mcp.tavily.com/mcp` and reads a bearer token from `TAVILY_API_KEY` in the **client process environment**. The example exposes `tavily_search` and `tavily_extract`; add other tools only for a task that needs them. A `.env` file alone does not configure an HTTP MCP connection. [Official authentication](https://docs.tavily.com/documentation/mcp)
- For Tavily OAuth instead, remove `bearer_token_env_var` from the installed Tavily entry and use `codex mcp login tavily`. Complete login in the target client; do not combine an unconfigured bearer-token entry with the OAuth recipe.
- If HTTP access is unsuitable, replace the installed Tavily entry with the local alternative below. It requires Node.js/npm and an independently checked package version. Use one transport for that server, not both.

```toml
[mcp_servers.tavily]
command = "npx"
args = ["-y", "tavily-mcp"]
env_vars = ["TAVILY_API_KEY"]
enabled = false
tool_timeout_sec = 120
enabled_tools = ["tavily_search", "tavily_extract"]
```

`env_vars` forwards variables already available to the process. Some local servers also load `.env` themselves, depending on implementation and working directory; that is not a shared client contract. Use the [credential setup](../../docs/installation.md#environment-variables), and never print or commit token values.

Context7, OpenAI Docs, and Microsoft Learn are optional specialist sources. Playwright and Chrome DevTools are optional browser tools. Keep only the sources needed for the workload, and reuse an existing App, connector, or plugin when it already supplies the same service. See [MCP routing](../../docs/mcp-routing.md).

## Verify in the target environment

1. Parse/schema-check the chosen configuration and run a configuration-load check with an isolated `CODEX_HOME`.
2. In the intended client, inspect the effective model, permissions and MCP status. Confirm environment-variable presence without displaying its value; restart a desktop client after changing inherited environment variables.
3. Verify the selected server's connection, discovered tools, and one bounded public-data call. Server listings and schema success alone do not prove a call succeeds.
4. For a role or model change, check the actual spawned agent/model separately. Do not infer account access, model quality, memory quality or sandbox isolation from parsing.

The repository's [compatibility record](../../docs/compatibility.md) distinguishes the checks actually run from these downstream acceptance steps.
