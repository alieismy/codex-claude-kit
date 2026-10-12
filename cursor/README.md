# Cursor Adapter

This adapter provides user-rule templates, native project MDC rules, an optional MCP example, and prompts. Skills are maintained once in `skills/`; all Chinese surfaces are under `zh-CN/cursor/`. Codex retains the most extensive configuration examples; these entry points do not claim full Cursor CLI/cloud support.

```text
cursor/
  README.md
  global/RULES.md.template
  project/rules/*.mdc.template
  project/mcp.example.json
  project/PROMPTS.md
```

Source paths are inactive. Remove `.template` to install project rules as `.cursor/rules/*.mdc`. Only `00-global-principles` is always-on at project scope; the other nine rules load from trigger-oriented descriptions. Add selected global-template content in Customize → Rules for preferences across projects. The official help also distinguishes local `~/.cursor/rules` files from account-synced User Rules. [Official rules](https://cursor.com/docs/rules), [rules FAQ](https://cursor.com/help/customization/rules)

Select language, rule scope, settings/MCP, and Skill source separately. Project-rule recipes do not copy Skills. See the [Bash/PowerShell installation](../docs/installation.md#cursor-adapter) for guarded recipes and backup/merge boundaries, and the [migration guide](../docs/layout-migration.md) for former paths.

## Skills and combined clients

Cursor documents project/user `.agents/skills/` and `.cursor/skills/`, plus compatible `.claude/skills/` and `.codex/skills/` roots. Same-name source precedence and deduplication are unspecified. Reuse an existing deliberate Codex/shared RD installation instead of adding a `.cursor/skills` tree by default. Optional project/team installations read the canonical source directly. Equal content does not prove runtime deduplication. [Official Skills](https://cursor.com/docs/skills)

Cursor reads `CLAUDE.md` as always-on guidance; review its effect when combining the Claude adapter. Nested `AGENTS.md` applies to its directory and descendants, with more-specific guidance taking precedence. Confirm native discovery and same-name Skill selection in a fresh target Cursor session; this migration has no real Cursor client verification. [Official rules FAQ](https://cursor.com/help/customization/rules)

User `.agents/skills` discovery is local and does not automatically copy those Skills to Cloud Agents, remote SSH, or self-hosted workers. Cursor CLI has its own `~/.cursor/cli-config.json` and project `.cursor/cli.json` (permissions only); project rules and an MCP example are not complete client settings. [CLI configuration](https://cursor.com/docs/cli/reference/configuration)

## Optional MCP

`project/mcp.example.json` contains only Context7. Review use, data flow, and credentials before merging it into project `.cursor/mcp.json` or user `~/.cursor/mcp.json`; preserve existing configuration. Set `CONTEXT7_API_KEY` in the host environment. The example maps exactly one API key into the credentialed server through its own `env` object; do not replace this mapping with a shared `envFile` or place the key in command arguments. Restart Cursor after changing host environment variables, then re-check MCP status in the UI. Verify the resolved npm version and actual connection separately. [Official MCP](https://cursor.com/docs/mcp)

Do not rely on undocumented `disabled` or `alwaysAllow` fields in public examples, or copy the complete MCP routing catalog into configuration. IDE settings, user rules, MCP, and CLI permissions are distinct carriers and scopes.
