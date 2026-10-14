# Claude Code examples

Rules are in `../global/` and `../project/`; this directory holds separately selectable settings, MCP configuration, and prompts. It does not configure Claude web/desktop account instructions. See the [Claude guide](../README.md) and [installation map](../../docs/installation.md).

| Source | Native destination / use |
|---|---|
| [settings.example.json](settings.example.json) | Review and merge into `~/.claude/settings.json` |
| [settings.project.example.json](settings.project.example.json) | Review and merge into `{project}/.claude/settings.json` |
| [mcp.example.json](mcp.example.json) | Review and merge into `{project}/.mcp.json` |
| [PROMPTS.md](PROMPTS.md) | Claude Code task prompts; select the local or account-synced Skill name |

Back up existing files and merge selected keys. JSON does not accept comments. Project-local personal overrides belong in `.claude/settings.local.json` and should stay out of Git. User/local MCP definitions use `~/.claude.json`, managed through `claude mcp`; `mcpServers` does not belong in settings JSON. [Settings scopes](https://code.claude.com/docs/en/settings), [MCP scopes](https://code.claude.com/docs/en/mcp)

## Core settings

The user example chooses `opus` and sets `xhigh` for `claude-opus-5-5` in `modelSettings`. Confirm account/provider access. The alias can move to a newer model; recheck the per-model key when it does. A user-level top-level `effortLevel` does not apply to Opus 5.5, so it is not a substitute for this entry. Model choice, effort, context-window settings and actual backend identity are separate observations. [Official model configuration](https://code.claude.com/docs/en/model-config)

User settings protect common home-directory credentials. Project settings protect `.env`, `.env.*`, and `secrets/**`, with `Read(!.env.example)` placed after the broad `.env.*` denial in the same list so the public example remains readable. A negation cannot cancel a deny from another settings source. Existing Bash and PowerShell ask rules remain for commit, push, tag, publish, delete and uncommitted-work-discarding Git operations. These are tool permission guardrails, not OS isolation or protection against all wrapper scripts. [Permission semantics](https://code.claude.com/docs/en/permissions)

Both settings examples retain attribution preferences and `enableAllProjectMcpServers = false`. The latter is an approval preference, not proof that a headless session cannot connect. Verify effective permissions and server status in the intended client.

## Recommended MCP pair

The example contains DeepWiki and Tavily using native HTTP entries:

- DeepWiki: public repository research through `https://mcp.deepwiki.com/mcp`, no API key. Verify important answers against the relevant source revision. [Official service](https://docs.devin.ai/work-with-devin/deepwiki-mcp)
- Tavily: web search and extraction through `https://mcp.tavily.com/mcp`, using `Authorization: Bearer ${TAVILY_API_KEY}`. The variable must be available to the client process; copying `.env` alone does not configure this HTTP connection. The service can expose additional research/crawl tools; invoke them only when the task needs them. [Official service and authentication](https://docs.tavily.com/documentation/mcp)

Configure credentials before copying the complete MCP example. For a DeepWiki-only installation, merge only that entry. Approve selected project servers through Claude Code's native flow. Reuse an existing account connector or plugin when it already supplies the service. See [credential setup](../../docs/installation.md#environment-variables).

For Tavily OAuth instead, remove its `headers` block and authenticate through `/mcp` in the target client. For user scope, add the server with `claude mcp add --scope user --transport http tavily https://mcp.tavily.com/mcp`, then complete OAuth. These instructions do not mean the repository has authenticated an account.

For the local Tavily alternative, replace that entry with the following, after checking Node.js/npm and the resolved package version:

```json
{
  "tavily": {
    "command": "npx",
    "args": ["-y", "tavily-mcp"],
    "env": {"TAVILY_API_KEY": "${TAVILY_API_KEY}"}
  }
}
```

Merge this entry under the existing `mcpServers` object. Some local server implementations load `.env` themselves; client environment inheritance is the explicit portable setup used here. [Claude environment expansion](https://code.claude.com/docs/en/mcp#environment-variable-expansion-in-mcp-json)

Context7 is optional for library/SDK documentation; OpenAI Docs is valid in Claude for OpenAI research; Microsoft Learn is optional for Microsoft technologies. Browser MCPs are for tasks that need real page interaction. Add only the needed native entry; see [MCP routing](../../docs/mcp-routing.md).

## Optional settings, not universal defaults

Merge only the fragment that fits the target environment:

| Choice | Example | Scope and tradeoff |
|---|---|---|
| Native PowerShell tool | `"env": {"CLAUDE_CODE_USE_POWERSHELL_TOOL": "1"}` | Windows/provider-specific; often already enabled on current Windows clients. On other systems it requires `pwsh`. |
| Earlier bounded compaction | `"modelSettings": {"claude-opus-5-5": {"effortLevel": "xhigh", "autoCompactWindow": 400000}}` | A workload trial, not an optimum. Keep existing per-model keys when merging. |
| Long foreground operations | `"env": {"BASH_DEFAULT_TIMEOUT_MS": "600000", "BASH_MAX_TIMEOUT_MS": "3600000"}` | Applies to Bash/PowerShell and permits longer waits. Use only for workloads that need it. |
| Agent Teams | `"env": {"CLAUDE_CODE_EXPERIMENTAL_AGENT_TEAMS": "1"}` | Experimental, disabled by default; opt in deliberately. |

`CLAUDE_AUTOCOMPACT_PCT_OVERRIDE` can lower the trigger percentage but cannot raise it above the model's default threshold. Do not combine a copied percentage and window without understanding their interaction. Personal status lines, plugins, theme and timezone are not public requirements. See [environment variables](https://code.claude.com/docs/en/env-vars) and [compaction](https://code.claude.com/docs/en/model-config#context-window-and-auto-compaction).

## Verification and recovery

Parse JSON and check the selected keys against the current official contracts. Run `claude doctor` and inspect `/status`, `/model`, `/permissions`, and `/mcp` in a fresh intended session. A successful `-p` request alone does not prove every setting loaded: Claude can skip invalid settings in non-interactive mode. Check MCP connection, tool discovery and one bounded public-data call separately. [Settings diagnostics](https://code.claude.com/docs/en/settings)

Before claiming permission enforcement, test synthetic denied and allowed files without real credentials. Restore only the keys introduced by the trial, preserving later user edits; disconnect an added MCP through the native client flow. The [compatibility record](../../docs/compatibility.md) states which checks were actually completed in this repository.
