# Source Layout Migration

codex-claude-kit separates shared rules and Skills from Codex and Claude platform templates. Simplified Chinese surfaces live under `zh-CN/`; the shared English-only Claude account-instruction profile remains in `docs/`. The source paths below are not installation paths: remove `.template` when installing rules into a client's native location.

## Current rule and example layout

Global/project directories contain only rule templates; configuration, MCP, and prompts live in each platform's `examples/` directory. The single shared project core moves back to the Codex project source directory. Once installed, Claude still imports the target project's root core through `@AGENTS.md`. Template suffixes continue to isolate distributable instructions from source-maintainer instructions.

| Previous source | Current source | Native destination or purpose |
|---|---|---|
| `rules/project/AGENTS.md.template` | `codex/project/AGENTS.md.template` | `{project}/AGENTS.md`, the single core shared by both clients |
| `codex/project/config.example.toml` | `codex/examples/config.project.example.toml` | `{project}/.codex/config.toml` |
| `claude/global/settings.example.json` | `claude/examples/settings.example.json` | `~/.claude/settings.json` |
| `claude/project/settings.example.json` | `claude/examples/settings.project.example.json` | `{project}/.claude/settings.json` |
| `claude/project/mcp.example.json` | `claude/examples/mcp.example.json` | `{project}/.mcp.json` |
| Codex task bodies formerly in `PROMPTS.md` | `codex/examples/PROMPTS.md` | Codex task prompts; root file remains an entry index |
| `claude/project/PROMPTS.md` | `claude/examples/PROMPTS.md` | Claude Code task prompts |

Apply the same moves to corresponding `zh-CN/` paths. Native installation destinations retain their scopes; source relocation does not update an existing installation. The tables below record earlier migration steps: resolve their former destinations through the current table above.

## Earlier source migrations (historical)

| Earlier source | Destination at that stage | Installation target |
|---|---|---|
| `codex/project/AGENTS.md` | `rules/project/AGENTS.md.template` | `{project}/AGENTS.md` |
| `zh-CN/codex/project/AGENTS.md` | `zh-CN/rules/project/AGENTS.md.template` | `{project}/AGENTS.md` |
| `codex/global/AGENTS.md` | `codex/global/AGENTS.md.template` | `{CODEX_HOME}/AGENTS.md` |
| `claude/global/CLAUDE.md` | `claude/global/CLAUDE.md.template` | `~/.claude/CLAUDE.md` |
| `claude/project/CLAUDE.md` | `claude/project/CLAUDE.md.template` | `{project}/CLAUDE.md` |
| `claude/project/.claude/settings.json` | `claude/project/settings.example.json` | `{project}/.claude/settings.json` |
| `claude/project/.claude/skills/rd-*` | `skills/rd-*` | selected local root or account upload |
| `cursor/project/.cursor/skills/rd-*` | `skills/rd-*` | selected local root |
| `zh-CN/claude/project/.claude/skills/rd-*` | `zh-CN/skills/rd-*` | selected local root or account upload |
| `cursor/zh-CN/.cursor/skills/rd-*` | `zh-CN/skills/rd-*` | selected local root |

The Codex and Claude global/project moves also apply to their `zh-CN/` mirrors. The shared project core is platform-neutral; the Claude project template remains a thin `@AGENTS.md` adapter. Existing Codex user-configuration examples retain their published paths. At that historical stage, new selected entry points were `codex/project/config.example.toml`, `claude/global/settings.example.json`, and `claude/project/mcp.example.json`, with Chinese translations.

## Cursor retirement and name migration

The 2026-10-13 scope change adopts `codex-claude-kit` and removes Cursor-specific rules, configuration, installation recipes, and current gates. Claude Code is the primary Claude entry point; applicable Claude web/desktop instructions and Skills, plus ChatGPT web custom instructions, remain supported.

| Former source | Current source / disposition | Purpose |
|---|---|---|
| `cursor/project/PROMPTS.md` | `claude/project/PROMPTS.md` | Claude Code task-starting prompts |
| `zh-CN/cursor/project/PROMPTS.md` | `zh-CN/claude/project/PROMPTS.md` | Chinese Claude Code task-starting prompts |
| Cursor-specific rules, MCP, and adapter guides | Removed from current distributable sources | Current support ends; historical Git records remain |

The former Cursor Skill mirrors in the table above describe the earlier completed source consolidation; shared Skills remain after Cursor retirement. The 2026-10-12 layout/installation probes are retained in [compatibility](compatibility.md), where former paths are historical test inputs, not current installation entry points. Existing personal Cursor installations are not removed or disabled by source retirement.

Local source references and the GitHub repository identity are separate states: remote renaming and remote URL updates must be performed and verified before being reported. Historical reports, evidence paths, and published-version facts retain their original content.

## Source, installation, and account boundaries

`skills/` and `zh-CN/skills/` are the only maintained Skill source trees. Former adapter copies had the same contents and are removed from the source layout. The claude.ai packager reads the canonical language tree directly, excluding repository-only `evals/` and `agents/`. An account cache under `~/.claude/skills/synced/` is an optional read-only comparison target; it is never an editable source or an upload staging tree.

Moving or deleting a repository source path does not move, delete, update, upload, or disable an installed user/project/account Skill. Existing personal settings and rules remain separate deployments. Choose their update language, scope, backup, and authority independently. Do not remove a personal Skill copy merely because its former repository mirror disappeared.

For Codex, reuse an existing deliberate `.agents/skills` installation rather than adding project copies by default. Claude desktop/chat and account-signed-in Claude Code can share account-uploaded Skills. Public project/team installation and Claude Code local fallback remain supported from the canonical language source using the existing installer with `-DestinationRoot`; public use does not depend on any maintainer's personal state.

## Migration procedure

1. Identify language, platform, rule scope, settings/MCP scope, and Skill source. Inventory existing native destinations and same-name Skills.
2. Update references to former source paths using the table. Keep dated evidence and historical fixture paths unchanged; they describe the layout actually tested.
3. Review and back up existing destinations. For first-time rule installation, copy individual templates to native names without `.template`. Keep settings/MCP opt-in and merge rather than overwrite.
4. Preserve effective `AGENTS.override.md` behavior and the Claude import's non-empty target. If an override exists, choose the matching import deliberately before installing.
5. Verify installed filenames, parsed configuration, references, and source/scope selection in a new target-client session. Repository static gates do not establish client loading, account upload, or business acceptance.

The migration uses non-native source locations and template suffixes to reduce accidental source-maintenance discovery. Root `.claude/settings.json` is a maintainer-only empty object; it is not a downstream configuration. Historical exclusion and nested-Skill probes retain their original layouts and limitations in [compatibility](compatibility.md). New isolation evidence must be recorded separately; the path changes alone are not a runtime result.

See [installation](installation.md#source-and-destination-map) for guarded native copy recipes and optional Skill installation. Git commit, publication, personal installation updates, and account uploads require their own authorization.
