# Source Layout Migration

The source layout separates shared rules and Skills from platform-specific templates. All maintained Simplified Chinese surfaces now live under `zh-CN/`. The source paths below are not installation paths: remove `.template` when installing rules into a client's native location.

## Former and current paths

| Former source | Current source | Installation target |
|---|---|---|
| `codex/project/AGENTS.md` | `rules/project/AGENTS.md.template` | `{project}/AGENTS.md` |
| `zh-CN/codex/project/AGENTS.md` | `zh-CN/rules/project/AGENTS.md.template` | `{project}/AGENTS.md` |
| `codex/global/AGENTS.md` | `codex/global/AGENTS.md.template` | `{CODEX_HOME}/AGENTS.md` |
| `claude/global/CLAUDE.md` | `claude/global/CLAUDE.md.template` | `~/.claude/CLAUDE.md` |
| `claude/project/CLAUDE.md` | `claude/project/CLAUDE.md.template` | `{project}/CLAUDE.md` |
| `claude/project/.claude/settings.json` | `claude/project/settings.example.json` | `{project}/.claude/settings.json` |
| `cursor/project/.cursor/rules/*.mdc` | `cursor/project/rules/*.mdc.template` | `{project}/.cursor/rules/*.mdc` |
| `cursor/project/.cursor/mcp.example.json` | `cursor/project/mcp.example.json` | `{project}/.cursor/mcp.json` (opt-in) |
| `cursor/zh-CN/README.md` | `zh-CN/cursor/README.md` | documentation only |
| `cursor/zh-CN/.cursor/rules/*.mdc` | `zh-CN/cursor/project/rules/*.mdc.template` | `{project}/.cursor/rules/*.mdc` |
| `cursor/zh-CN/.cursor/mcp.example.json` | `zh-CN/cursor/project/mcp.example.json` | `{project}/.cursor/mcp.json` (opt-in) |
| `cursor/zh-CN/PROMPTS.md` | `zh-CN/cursor/project/PROMPTS.md` | selected project prompt reference |
| `claude/project/.claude/skills/rd-*` | `skills/rd-*` | selected local root or account upload |
| `cursor/project/.cursor/skills/rd-*` | `skills/rd-*` | selected local root |
| `zh-CN/claude/project/.claude/skills/rd-*` | `zh-CN/skills/rd-*` | selected local root or account upload |
| `cursor/zh-CN/.cursor/skills/rd-*` | `zh-CN/skills/rd-*` | selected local root |

The Codex and Claude global/project moves also apply to their `zh-CN/` mirrors. The shared project core is platform-neutral; the Claude project template remains a thin `@AGENTS.md` adapter. Existing Codex user-configuration examples retain their published paths. New selected entry points are `codex/project/config.example.toml`, `claude/global/settings.example.json`, `claude/project/mcp.example.json`, and `cursor/global/RULES.md.template`, with Chinese translations.

## Source, installation, and account boundaries

`skills/` and `zh-CN/skills/` are the only maintained Skill source trees. Former adapter copies had the same contents and are removed from the source layout. The claude.ai packager reads the canonical language tree directly, excluding repository-only `evals/` and `agents/`. An account cache under `~/.claude/skills/synced/` is an optional read-only comparison target; it is never an editable source or an upload staging tree.

Moving or deleting a repository source path does not move, delete, update, upload, or disable an installed user/project/account Skill. Existing personal settings and rules remain separate deployments. Choose their update language, scope, backup, and authority independently. Do not remove a personal Skill copy merely because its former repository mirror disappeared.

For Codex and local Cursor, reuse an existing deliberate `.agents/skills` installation rather than adding project copies by default. Cursor's compatible discovery is documented, but this migration does not verify its runtime selection. Claude desktop/chat and account-signed-in Claude Code can share account-uploaded Skills. Public project/team installation and Claude Code local fallback remain supported from the canonical language source using the existing installer with `-DestinationRoot`; public use does not depend on any maintainer's personal state.

## Migration procedure

1. Identify language, platform, rule scope, settings/MCP scope, and Skill source. Inventory existing native destinations and same-name Skills.
2. Update references to former source paths using the table. Keep dated evidence and historical fixture paths unchanged; they describe the layout actually tested.
3. Review and back up existing destinations. For first-time rule installation, copy individual templates to native names without `.template`. Keep settings/MCP opt-in and merge rather than overwrite.
4. Preserve effective `AGENTS.override.md` behavior and the Claude import's non-empty target. If an override exists, choose the matching import deliberately before installing.
5. Verify installed filenames, parsed configuration, references, and source/scope selection in a new target-client session. Repository static gates do not establish client loading, account upload, or business acceptance.

The migration uses non-native source locations and template suffixes to reduce accidental source-maintenance discovery. Root `.claude/settings.json` is a maintainer-only empty object; it is not a downstream configuration. Historical exclusion and nested-Skill probes retain their original layouts and limitations in [compatibility](compatibility.md). New isolation evidence must be recorded separately; the path changes alone are not a runtime result.

See [installation](installation.md#source-and-destination-map) for guarded native copy recipes and optional Skill installation. Git commit, publication, personal installation updates, and account uploads require their own authorization.
