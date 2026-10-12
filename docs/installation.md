# Installation

This repository provides templates. Merge them into your local Codex and project setup rather than overwriting existing files blindly.

## Source and destination map

Choose rules, settings/MCP, and Skills independently. Source templates are inactive: remove `.template` on installation, and merge existing destinations after a verified backup. Prefix the source paths below with `zh-CN/` for Chinese. Do not copy source directories recursively or use an account-synced cache as a source.

| Surface | Source | Native destination |
|---|---|---|
| Shared project rules | `rules/project/AGENTS.md.template` | `{project}/AGENTS.md` |
| Codex global rules | `codex/global/AGENTS.md.template` | `{CODEX_HOME}/AGENTS.md` (default `~/.codex`) |
| Codex user configuration | `codex/examples/config.example.toml` | `{CODEX_HOME}/config.toml` |
| Codex project configuration | `codex/project/config.example.toml` | `{project}/.codex/config.toml` (trusted project) |
| Claude global/project rules | `claude/{global,project}/CLAUDE.md.template` | `~/.claude/CLAUDE.md`; `{project}/CLAUDE.md` |
| Claude user/project settings | `claude/{global,project}/settings.example.json` | `~/.claude/settings.json`; `{project}/.claude/settings.json` |
| Claude project MCP | `claude/project/mcp.example.json` | `{project}/.mcp.json` |
| Cursor user rules | `cursor/global/RULES.md.template` | selected content in Customize → Rules |
| Cursor project rules | `cursor/project/rules/*.mdc.template` | `{project}/.cursor/rules/*.mdc` |
| Cursor project MCP | `cursor/project/mcp.example.json` | `{project}/.cursor/mcp.json` |
| Local shared Skills | `skills/rd-*` | chosen user/project Skill root |
| Claude account Skills | `skills/rd-*`, via the upload packager | claude.ai Customize → Skills; Code receives account sync |

Claude user/local MCP lives in `~/.claude.json`, managed with `claude mcp add --scope user` or `--scope local`; it is not a settings JSON key. Cursor user MCP can live in `~/.cursor/mcp.json`. Cursor IDE User Rules, IDE settings, and CLI configuration have distinct carriers. CLI/cloud support is not expanded by these examples. See the [Claude adapter](../claude/README.md) and [Cursor adapter](../cursor/README.md) for the current documentation contracts. Repository relocation does not update personal installations; see [layout migration](layout-migration.md).

## Codex Rules

Install global rules:

```bash
codex_home="${CODEX_HOME:-$HOME/.codex}"
mkdir -p "$codex_home"
if [ ! -s "$codex_home/AGENTS.override.md" ] && [ ! -e "$codex_home/AGENTS.md" ]; then
  cp codex/global/AGENTS.md.template "$codex_home/AGENTS.md"
fi
```

Install project rules:

```bash
if [ ! -s /path/to/your-project/AGENTS.override.md ] && [ ! -e /path/to/your-project/AGENTS.md ]; then
  cp rules/project/AGENTS.md.template /path/to/your-project/AGENTS.md
fi
```

If a destination has a non-empty `AGENTS.override.md`, that file is the effective instruction source at the same scope; create a separate backup and merge deliberately instead of creating an inactive `AGENTS.md`. If `AGENTS.md` already exists, back it up and merge only the relevant sections while preserving existing personal or project-specific constraints. Do not blindly replace an existing global file. The templates contain opinionated defaults for role, language behavior, reasoning depth, authorization, and delivery discipline; adapt them to the user, team, and repository. The English global template is language-neutral, while the `zh-CN/` template intentionally defaults to Simplified Chinese.

Codex loads the global and applicable project `AGENTS.md` chain independently of Skill selection. The global v7.8 template therefore keeps truthfulness, response modes, value-first execution, context health, execution efficiency and context hygiene, pre-output review, output rules, evidence-state boundaries, no-change legitimacy, bounded implementation discipline, existing-behavior and instruction-surface protection, validation-failure attribution, and a compact RD delivery baseline active even when no RD Skill is selected; a matching Skill adds the full specialist workflow rather than supplying the only copy of these controls.

Codex discovers the instruction chain once at the start of each run. At a given level, a non-empty `AGENTS.override.md` takes precedence over `AGENTS.md`; global guidance is loaded before project files from the repository root toward the working directory, so closer project guidance has higher precedence. Loading stops at `project_doc_max_bytes`, and changed instructions require a new run or session to take effect. See the official OpenAI documentation for [custom instructions with AGENTS.md](https://learn.chatgpt.com/docs/agent-configuration/agents-md).

### Verify instruction loading

Start a new non-interactive run from the repository root and ask it to report the global and project instruction sources it loaded:

```text
codex --sandbox read-only --ask-for-approval never exec "Summarize the current instructions and list their source files in precedence order."
```

Repeat from a nested directory when you need to verify a closer `AGENTS.md` or `AGENTS.override.md`:

```text
codex --cd path/to/nested-directory --sandbox read-only --ask-for-approval never exec "List the instruction sources you loaded in precedence order, then summarize the effective guidance."
```

`--sandbox read-only` prevents this diagnostic run from modifying the workspace, while `--ask-for-approval never` disables approval prompts; `never` does not establish the read-only boundary. Codex reads global instructions from `CODEX_HOME` when that environment variable is set; otherwise, the default is `~/.codex`. Start another new run after changing an instruction file because the chain is built once per run or launched TUI session. These checks establish only which sources the run reports and how it summarizes them; they do not guarantee future compliance and do not constitute runtime or business acceptance. See the official [`codex exec` reference](https://learn.chatgpt.com/docs/developer-commands#codex-exec) and [read-only non-interactive security combination](https://learn.chatgpt.com/docs/agent-approvals-security#common-sandbox-and-approval-combinations).

## Skills

### Adopt by deliverable

For a new project, start with the specialist that owns the current deliverable: requirements, evidence, feasibility, solution, design, specification, writing, or review. Installing the suite does not make all nine Skills a required workflow. Use `rd-delivery` only when explicitly requesting multi-stage or multi-document coordination.

For an established project, preserve its governing documents, terminology, approvals, and working conventions. Try the appropriate specialist on one bounded real task, inspect its output and evidence limits, and expand use only where it helps. Research and review are useful entry points when those are the actual tasks, not mandatory prerequisites for every document.

Adoption scope and installation scope are different: the PowerShell installer below manages all nine declared `rd-*` directories; it is not a single-Skill selector. Begin by using a small part of the installed suite. Before combining clients, resolve source/scope choices and inspect actual discovery using the platform guidance below; a second installed copy is not proof of a second effective capability.

Reuse a deliberate existing user-level installation; project rules do not add project Skills by default. The recipes below are optional first-time/local installations. Project/team and Claude Code local fallback are separate choices. For desktop/chat and Claude Code account sharing, see [claude.ai upload](../claude/README.md#claudeai-skill-upload).

### Skill sources and scope

The English `skills/` tree is the repository's canonical Skill source. `zh-CN/skills/` is its Simplified Chinese translation pack; a user-level copy under `~/.agents/skills/` (or `$HOME/.agents/skills/`) is an installed personal copy, not a second repository source. Install one deliberate source at one deliberate scope for each project. If the same Skill name exists in more than one discovered user or project directory, Codex does not merge the directories; selection and precedence can be ambiguous, so inspect the discovered copies and remove or relocate an unintended duplicate only with explicit authorization.

Before installing, record the intended language/source, destination scope (user or project), and Skill set. Treat an existing destination as a merge or replacement decision: do not overwrite it blindly. The PowerShell installer below creates a verified backup before replacing the nine declared `rd-*` directories; it does not authorize replacing unrelated Skills or change Codex's runtime selection policy.

Global install:

```bash
skill_target="$HOME/.agents/skills"
mkdir -p "$skill_target"
for skill_source in skills/rd-*; do
  skill_name=$(basename "$skill_source")
  if [ -e "$skill_target/$skill_name" ]; then
    printf 'Refusing to overwrite existing Skill: %s\n' "$skill_target/$skill_name" >&2
    exit 1
  fi
done
cp -R skills/rd-* "$skill_target/"
```

On PowerShell, the preferred user-level installation is the verified installer:

```powershell
pwsh -File ./scripts/install-rd-skills.ps1 -Language en
pwsh -File ./scripts/install-rd-skills.ps1 -Language en -CheckOnly
```

The installer manages only the nine declared `rd-*` directories, verifies a SHA-256 backup under `$HOME/.agents/backups`, stages and verifies the replacement, restores the previous installation if replacement fails, and then compares every installed file with the selected source tree. `-CheckOnly` performs the final comparison without writing.

Project-level install:

```bash
skill_target="/path/to/your-project/.agents/skills"
mkdir -p "$skill_target"
for skill_source in skills/rd-*; do
  skill_name=$(basename "$skill_source")
  if [ -e "$skill_target/$skill_name" ]; then
    printf 'Refusing to overwrite existing Skill: %s\n' "$skill_target/$skill_name" >&2
    exit 1
  fi
done
cp -R skills/rd-* "$skill_target/"
```

### Optional project/team and Claude Code local fallback

```powershell
pwsh -File ./scripts/install-rd-skills.ps1 -Language en -DestinationRoot 'path/to/your-project/.agents/skills'
pwsh -File ./scripts/install-rd-skills.ps1 -Language en -DestinationRoot 'path/to/your-project/.agents/skills' -CheckOnly
# Claude Code local fallback: choose instead of account Skills where required
pwsh -File ./scripts/install-rd-skills.ps1 -Language en -DestinationRoot 'path/to/your-project/.claude/skills'
```

The selected language's shared Skill tree remains the source. Choose an owner for project/team updates and acceptance. Claude Code documents `.claude/skills`; do not claim `.agents/skills` is discovered by all three platforms. A personal fallback can target `$HOME/.claude/skills`. Inventory same-name user/account/project sources before adding a copy; replace only within authorization.

## Codex Configuration

### Project configuration example

Review `codex/project/config.example.toml` and optionally merge it into the target project `.codex/config.toml`. This minimal example uses `on-request`, `workspace-write`, and disabled sandbox network access. Codex loads project config only for trusted projects. It does not replace user `config.toml` or authorize installation/deployment.


Start from the reviewed, opinionated workspace-write example:

```bash
codex_home="${CODEX_HOME:-$HOME/.codex}"
mkdir -p "$codex_home"
if [ ! -e "$codex_home/config.toml" ]; then
  cp codex/examples/config.example.toml "$codex_home/config.toml"
fi
```

If `$CODEX_HOME/config.toml` already exists (default: `~/.codex/config.toml`), inspect it and merge only the relevant sections. Do not replace a working personal configuration blindly.

The standard example deliberately sets `web_search = "live"`, enables `features.memories`, inherits the full parent shell environment, and sets `ignore_default_excludes = false` so Codex still filters environment-variable names containing `KEY`, `SECRET`, or `TOKEN`. These choices align with the maintainer's reviewed operating baseline but are not universal security or privacy defaults; evaluate them for the target account, workspace, and threat model.

The full-access profile is opt-in:

```text
codex/examples/config.full-access.example.toml
```

Do not use full access for untrusted repositories.

## Environment Variables

Copy the environment example:

```bash
cp .env.example .env
```

Fill only the API keys for MCP servers you enable. Never commit `.env`.

On Windows, user-level environment variables can also be set with `setx`, but restart your shell and any affected client—Codex CLI, Codex app, Cursor, or Claude Code—after changing them.

## Cursor Adapter

Cursor documents project and user `.agents/skills/` and `.cursor/skills/`, plus compatible `.claude/skills/` and `.codex/skills/` roots. Same-name precedence is unspecified. Reuse a deliberate shared Skill source by default and do not install another copy with project rules. Confirm discovery and selection in a fresh session; this layout change has no real Cursor client verification. [Official Skills](https://cursor.com/docs/skills)

Install project rules only (Bash, first-time rules directory):

```bash
(
set -e
if [ -e /path/to/your-project/.cursor/rules ] || [ -L /path/to/your-project/.cursor/rules ]; then
  printf '%s\n' 'Stop: merge existing Cursor rules manually before installing.' >&2
  exit 1
fi
mkdir -p /path/to/your-project/.cursor/rules
for rule_source in cursor/project/rules/*.mdc.template; do
  rule_name=$(basename "$rule_source" .template)
  cp "$rule_source" "/path/to/your-project/.cursor/rules/$rule_name"
done
)
```

PowerShell:

```powershell
& {
    $target = (Resolve-Path -LiteralPath 'path/to/your-project').Path
    $rulesTarget = Join-Path $target '.cursor/rules'
    if (Test-Path -LiteralPath $rulesTarget) { throw 'Stop: merge existing Cursor rules manually before installing.' }
    New-Item -ItemType Directory -Path $rulesTarget -ErrorAction Stop | Out-Null
    Get-ChildItem -LiteralPath 'cursor/project/rules' -Filter '*.mdc.template' -File | ForEach-Object {
        Copy-Item -LiteralPath $_.FullName -Destination (Join-Path $rulesTarget ($_.Name -replace '\.template$', '')) -ErrorAction Stop
    }
}
```

Add selected content from `cursor/global/RULES.md.template` in Customize → Rules for user-level preferences across projects. `00-global-principles.mdc` is always-on at project scope, not a global user rule. Cursor also reads `CLAUDE.md`; review its always-on effect when combining adapters. [Official rules](https://cursor.com/help/customization/rules)

MCP is opt-in. Review `cursor/project/mcp.example.json`, then merge it into project `.cursor/mcp.json` or user `~/.cursor/mcp.json`. Set `CONTEXT7_API_KEY` in the host environment and verify the server in the target client. The example contains only Context7; do not copy the complete routing catalog.

## Simplified Chinese Pack

The Simplified Chinese translation pack is available under:

```text
zh-CN/
```

Install Chinese Codex rules:

```bash
codex_home="${CODEX_HOME:-$HOME/.codex}"
mkdir -p "$codex_home"
if [ ! -s "$codex_home/AGENTS.override.md" ] && [ ! -e "$codex_home/AGENTS.md" ]; then
  cp zh-CN/codex/global/AGENTS.md.template "$codex_home/AGENTS.md"
fi
if [ ! -s /path/to/your-project/AGENTS.override.md ] && [ ! -e /path/to/your-project/AGENTS.md ]; then
  cp zh-CN/rules/project/AGENTS.md.template /path/to/your-project/AGENTS.md
fi
```

If a non-empty `AGENTS.override.md` exists at either scope, back up and merge that effective file rather than creating an inactive `AGENTS.md`. If `AGENTS.md` already exists, back it up and merge manually. Do not use the translation pack to overwrite personal or repository-specific rules.

Install Chinese shared skills:

```bash
skill_target="$HOME/.agents/skills"
mkdir -p "$skill_target"
for skill_source in zh-CN/skills/rd-*; do
  skill_name=$(basename "$skill_source")
  if [ -e "$skill_target/$skill_name" ]; then
    printf 'Refusing to overwrite existing Skill: %s\n' "$skill_target/$skill_name" >&2
    exit 1
  fi
done
cp -R zh-CN/skills/rd-* "$skill_target/"
```

Install Chinese Claude Code files (the project `CLAUDE.md` imports the shared `AGENTS.md`; keep and merge an existing `AGENTS.md` instead of overwriting it):

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
if [ -e ~/.claude/CLAUDE.md ] || [ -L ~/.claude/CLAUDE.md ]; then
  printf '%s\n' 'Stop: merge existing user-level Claude memory manually before installing.' >&2
  exit 1
fi
if [ ! -e /path/to/your-project/AGENTS.md ]; then
  cp zh-CN/rules/project/AGENTS.md.template /path/to/your-project/AGENTS.md
fi
if [ ! -s /path/to/your-project/AGENTS.md ]; then
  printf '%s\n' 'Stop: the shared AGENTS.md import target must be non-empty.' >&2
  exit 1
fi
mkdir -p ~/.claude
cp zh-CN/claude/global/CLAUDE.md.template ~/.claude/CLAUDE.md
cp zh-CN/claude/project/CLAUDE.md.template /path/to/your-project/CLAUDE.md
mkdir -p /path/to/your-project/.claude
cp zh-CN/claude/project/settings.example.json /path/to/your-project/.claude/settings.json
)
```

The English root remains the canonical baseline. Use `zh-CN/` as a translation pack and merge manually if destination files already exist.

## Claude Code Adapter

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

Install project-level Claude Code rules and settings without copying Skills. The project `CLAUDE.md` is a thin adapter that imports the shared project core with `@AGENTS.md`; if the target already has `AGENTS.md` (for example from the Codex installation), keep it and merge instead of overwriting:

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

If a non-empty `AGENTS.override.md` exists, the recipe stops before installing the adapter. Merge that effective Codex source deliberately and select the matching Claude import (for example `@AGENTS.override.md`) before continuing; Claude does not discover override files automatically. An existing empty `AGENTS.md` also requires manual repair.

If the target workspace already has `CLAUDE.md` or `.claude/`, merge manually. Claude Code reads `AGENTS.md` directly only when no `CLAUDE.md` exists (v2.1.277 or later); the explicit import works on earlier versions as well and does not load `AGENTS.md` twice. Run `/memory` or `/context` in a new session to confirm that both files loaded.

Project rules have one shared source: change `rules/project/AGENTS.md.template` for project-wide behavior and `claude/project/CLAUDE.md.template` only for Claude Code-specific guidance. User settings can be merged from `claude/global/settings.example.json`; project MCP can be merged from `claude/project/mcp.example.json` into `.mcp.json`. Neither is enabled by the rules recipe.

### Windows PowerShell project installation

Run from this repository root with an existing target project directory. This project-only recipe preserves an existing shared core and stops before overwriting existing Claude files. Replace the target placeholder; merge existing files manually. `throw` stops the installation block while leaving an interactive PowerShell session available.

```powershell
& {
    $target = (Resolve-Path -LiteralPath 'path/to/your-project').Path
    if ((Test-Path -LiteralPath (Join-Path $target 'CLAUDE.md')) -or
        (Test-Path -LiteralPath (Join-Path $target '.claude'))) {
        throw 'Stop: merge existing Claude files manually before installing.'
    }
    $override = Join-Path $target 'AGENTS.override.md'
    if ((Test-Path -LiteralPath $override) -and (Get-Item -LiteralPath $override).Length -gt 0) {
        throw 'Stop: merge the effective override and select the Claude import target manually before installing.'
    }
    $core = Join-Path $target 'AGENTS.md'
    if (-not (Test-Path -LiteralPath $core)) {
        Copy-Item -LiteralPath 'rules/project/AGENTS.md.template' -Destination $core -ErrorAction Stop
    }
    if (-not (Test-Path -LiteralPath $core) -or (Get-Item -LiteralPath $core).Length -eq 0) {
        throw 'Stop: the shared AGENTS.md import target must be non-empty.'
    }
    Copy-Item -LiteralPath 'claude/project/CLAUDE.md.template' -Destination (Join-Path $target 'CLAUDE.md') -ErrorAction Stop
    New-Item -ItemType Directory -Path (Join-Path $target '.claude') -ErrorAction Stop | Out-Null
    Copy-Item -LiteralPath 'claude/project/settings.example.json' -Destination (Join-Path $target '.claude/settings.json') -ErrorAction Stop
}
```

The Bash project recipes run in a subshell so a guard's `exit 1` stops the installation block rather than the parent interactive shell. The commands still require Bash (for example Git Bash on Windows); the PowerShell recipe above uses native cmdlets. After installation, verify the non-empty core, the `@AGENTS.md` import and settings; verify Skills separately for the chosen source/scope. Roll back only files newly created by this installation after checking for subsequent edits; restore any deliberately merged files from their pre-install backup.
