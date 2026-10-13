# Claude Guide

Claude Code is the primary Claude entry point in Codex & Claude Kit. This adapter maps the shared document-delivery model to native rules, selected settings/MCP examples, prompts, and a deliberate Skill source. Claude web/desktop instructions and applicable Skills are also maintained. Codex retains the most extensive configuration examples; platform capabilities are not identical.

Use the [Claude Code prompt templates](project/PROMPTS.md) for local or account-synced Skill calls. For Claude web/desktop personalization, see the separate [Instructions for Claude profile](../docs/claude-personalized-instructions.md); its account setting is distinct from local `CLAUDE.md` rules. The [claude.ai upload workflow](#claudeai-skill-upload) covers account Skills. These entry points do not establish complete runtime coverage across Claude products.

This adapter follows Anthropic's Claude Code documentation for [memory](https://code.claude.com/docs/en/memory), [settings](https://code.claude.com/docs/en/settings), [permissions](https://code.claude.com/docs/en/permissions), and [skills](https://code.claude.com/docs/en/skills), re-checked on 2026-09-04; the memory page was re-checked on 2026-10-01 for `AGENTS.md` support.

## Current Status

```text
claude/
  global/CLAUDE.md.template
  global/settings.example.json
  project/CLAUDE.md.template       # @AGENTS.md + Claude-specific guidance
  project/settings.example.json
  project/mcp.example.json
  project/PROMPTS.md
```

The shared project core is `rules/project/AGENTS.md.template`; Skills live only in `skills/`. Source templates are inactive: remove `.template` when installing. Choose rules, settings, MCP, and Skills separately rather than copying an adapter directory. See the [source-to-destination map](../docs/installation.md#source-and-destination-map) and [migration guide](../docs/layout-migration.md).

Project settings retain secret-path Read denials and dangerous-command ask guardrails. Read denial covers built-in Edit from v2.1.208 and Write from v2.1.228, but not NotebookEdit or arbitrary scripts reading files themselves. It does not establish Windows sandbox isolation. The user settings example supplies selected attribution and MCP approval preferences; `enableAllProjectMcpServers=false` does not prove a headless session cannot connect to project MCP. [Official settings](https://code.claude.com/docs/en/settings), [MCP](https://code.claude.com/docs/en/mcp)

The project MCP example defines the official OpenAI documentation HTTP server at `https://developers.openai.com/mcp`; it becomes project configuration only after deliberate copying/merging into project-root `.mcp.json`. User and local MCP definitions live in `~/.claude.json`, managed with `claude mcp add --scope user` or `--scope local`, not in settings JSON. A static example does not establish a successful runtime connection.

## Installation

Global rules install to `~/.claude/CLAUDE.md`; merge the user settings example into `~/.claude/settings.json`. The project recipe installs only the shared core, thin adapter, and settings, without default project Skills.

Install user-level Claude Code memory:

```bash
(
set -e
if [ -e ~/.claude/CLAUDE.md ] || [ -L ~/.claude/CLAUDE.md ]; then
  printf '%s\n' 'Stop: merge existing user-level Claude memory manually before installing.' >&2
  exit 1
fi
mkdir -p ~/.claude
cp claude/global/CLAUDE.md.template ~/.claude/CLAUDE.md
)
```

Install the shared project core and the Claude Code project adapter. If the target already has `AGENTS.md` (for example from the Codex installation), keep it and merge instead of overwriting:

```bash
(
set -e
if [ -e /path/to/your-project/CLAUDE.md ] || [ -L /path/to/your-project/CLAUDE.md ] || [ -e /path/to/your-project/.claude ] || [ -L /path/to/your-project/.claude ]; then
  printf '%s\n' 'Stop: merge existing Claude project files manually before installing.' >&2
  exit 1
fi
if [ -s /path/to/your-project/AGENTS.override.md ]; then
  printf '%s\n' 'Stop: merge the effective override and select the Claude import target manually before installing.' >&2
  exit 1
fi
if [ ! -e /path/to/your-project/AGENTS.md ]; then
  cp rules/project/AGENTS.md.template /path/to/your-project/AGENTS.md
fi
if [ ! -s /path/to/your-project/AGENTS.md ]; then
  printf '%s\n' 'Stop: the shared AGENTS.md import target must be non-empty.' >&2
  exit 1
fi
cp claude/project/CLAUDE.md.template /path/to/your-project/CLAUDE.md
mkdir -p /path/to/your-project/.claude
cp claude/project/settings.example.json /path/to/your-project/.claude/settings.json
)
```

If the destination files already exist, merge manually. Do not blindly overwrite existing Claude Code memory, settings, or skills.

If a non-empty `AGENTS.override.md` exists, the recipe stops before installing the adapter. Merge that effective Codex source deliberately and select the matching Claude import (for example `@AGENTS.override.md`) before continuing; Claude does not discover override files automatically. An existing empty `AGENTS.md` also requires manual repair.

Bash project installation runs in a subshell; guard failures leave the parent interactive shell available. Windows users can use the [native PowerShell recipe](../docs/installation.md#windows-powershell-project-installation).

## Shared Project Core

`project/CLAUDE.md.template` is a thin adapter. Its `@AGENTS.md` line imports the shared project core from `rules/project/AGENTS.md.template`; the rest contains only Claude Code-specific guidance. Change project-wide behavior in `rules/project/AGENTS.md.template`, not in the adapter.

Claude Code v2.1.277 and later can read `AGENTS.md` directly, but only when no `CLAUDE.md` is present. Because this adapter ships a `CLAUDE.md`, the explicit import keeps `AGENTS.md` loaded; it also works on earlier versions and never loads the file twice ([memory documentation](https://code.claude.com/docs/en/memory#agents-md), checked 2026-10-01). Use the import rather than a symlink on Windows. Run `/memory` or `/context` in a new session to confirm that both files loaded.

The import shares textual instructions only; it does not replace Claude Code settings, permissions, hooks, Skill discovery, or other platform controls. Imported content still consumes context.

<a id="claudeai-skill-upload"></a>

## claude.ai Skill Upload

Use this path when the RD Skills should follow your Claude account into claude.ai chat, Cowork, and Claude Code instead of being installed per project. Uploaded Skills are saved to the account; Claude Code signed in with that account downloads them to `~/.claude/skills/synced/` as `anthropic-skills:rd-*` ([Claude Code skills](https://code.claude.com/docs/en/skills), checked 2026-10-09).

```powershell
pwsh -File ./scripts/package-claude-ai-skills.ps1 -Language en            # all nine archives
pwsh -File ./scripts/package-claude-ai-skills.ps1 -Language en -Changed   # compare with local last-synced copies only
```

- The script packages the selected language's canonical `skills/` or `zh-CN/skills/` source into `.tmp/local/claude-ai-skills/<language>/rd-*.zip` (ignored, reproducible scratch output): one archive per Skill, with the Skill folder at the archive root as claude.ai requires ([Create custom skills](https://claude.com/docs/skills/how-to)). It omits `evals/` and `agents/`, which hold repository test definitions and Codex metadata. `manifest.json` records the source commit and archive hashes.
- It refuses uncommitted changes under the source tree so each upload maps to a commit; pass `-AllowDirty` for a trial package.
- `-Changed` compares the runtime payload with the copies Claude Code last synced, so Claude Code must be signed in with the same account with skill sync on. claude.ai rewrites the `SKILL.md` frontmatter layout on upload, so the comparison checks `name` and `description` by value and everything else byte for byte. Pass `-SyncedRoot` when more than one synced account directory exists.
- Upload each archive from **Customize > Skills**: select **+**, then **Create skill > Upload a skill**. Keep one copy per Skill: the claude.ai documentation does not say whether uploading an existing name replaces it, so remove or replace the older copy. After the next sync, rerun with `-Changed`; "nothing to upload" confirms only that the local last-synced copies match the source, not the current remote account state.
- Keep one source per environment. A project `.claude/skills/rd-*` or personal `~/.claude/skills/rd-*` copy does not hide the synced Skill: both load, the local copy takes `/rd-*`, and the synced copy remains available as `/anthropic-skills:rd-*`. When using uploaded Skills, keep the project-rule recipe Skill-free and do not separately install local fallback copies.

## Support and verification scope

This adapter provides native user/project rules, selected settings/MCP entry points, and a deliberate Skill source. Import syntax, carrier locations, and Skill scopes are checked against official documentation. Current source-maintenance isolation has only bounded Claude CLI fixture verification; it does not establish complete instructions, configuration, MCP, or account acceptance. Report static gates, packaging comparison, and real client results separately; see [compatibility](../docs/compatibility.md).

Project permissions are guardrails. Wrapper/compound-command interception, MCP connections, current remote account state, interactive menus, and business acceptance require target-environment checks. Recheck relevant carriers and versions when changing `CLAUDE.md`, settings, or Skills; do not derive Claude behavior from another product's results.

## Local fallback and verification boundaries

Account upload serves Claude desktop/chat and Claude Code signed in with that account. Project/team or account-independent environments can still install from `skills/` into `.claude/skills/` or `~/.claude/skills/`; see [optional installation](../docs/installation.md#optional-projectteam-and-claude-code-local-fallback). Prefer the account name `/anthropic-skills:rd-*`; use `/rd-*` when a local fallback was deliberately selected. Synced caches are read-only comparison targets, never editable packaging sources. Layout migration neither uploads account Skills nor changes personal installations, and does not establish complete client acceptance.
