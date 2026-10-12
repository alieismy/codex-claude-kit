# Codex Three-Layer Delivery

An unofficial, deliverable-driven framework for system design, architecture documentation, feasibility analysis, and document review with Codex, Claude Code, and Cursor. Settings and MCP examples support the rules and Skills while retaining each platform's native installation locations.

This repository packages a three-layer operating model:

1. **Global directives**: personal behavioral rules for accuracy, evidence discipline, and response style.
2. **Project document-delivery discipline**: project-level `AGENTS.md` rules for scope control, quality gates, security, MCP routing, and verification.
3. **Research and document-delivery skills**: eight independent specialist `rd-*` skills plus one explicit delivery orchestrator for requirements, feasibility studies, evidence research, technical proposals, detailed designs, standards work, professional writing, independent review, and cross-session handoff.

Codex retains the most extensive configuration examples. Claude Code and Cursor have native global/project rule adapters and selected settings/MCP entry points; this does not claim identical capabilities or full CLI/cloud coverage.

> This project is independent and is not affiliated with OpenAI, Cursor, Anthropic, or any referenced framework. See `ATTRIBUTION.md` for inspiration references.

Simplified Chinese users can start from `zh-CN/`. The English root remains the canonical baseline; `zh-CN/` is a translation pack, every maintained Chinese platform adapter is under `zh-CN/`, including `zh-CN/cursor/`.

## Who This Is For

Use this repository if you want AI agents to produce verifiable system-design and documentation deliverables instead of unstructured chat output.

It is designed for:

- system designers, solution architects, and technical leads writing PRDs, feasibility reports, proposals, and designs;
- product managers who need requirements to remain structured, prioritized, and traceable;
- standards contributors and reviewers working on national, industry, enterprise, or internal specifications;
- teams that need explicit evidence discipline, clause-level review rigor, and final verification reporting.

## Architecture

```text
Layer 1: Global AGENTS.md
  ~/.codex/AGENTS.md
  - language and tone
  - truthfulness and anti-anchoring
  - reasoning and response patterns

Layer 2: Project AGENTS.md
  {project}/AGENTS.md
  - document delivery discipline
  - spec injection
  - document quality gates
  - security and MCP routing
  - task routing

Layer 3: Document Delivery Skills
  ~/.agents/skills/rd-*/SKILL.md or {project}/.agents/skills/rd-*/SKILL.md
  - rd-requirement
  - rd-feasibility
  - rd-research
  - rd-solution
  - rd-design
  - rd-specification
  - rd-writing
  - rd-review
  - rd-delivery (explicit orchestration only)

Source mappings (templates are inactive until installed):
  Shared project core: rules/project/AGENTS.md.template
  Codex: codex/global/AGENTS.md.template; codex/examples/; codex/project/config.example.toml
  Claude Code: claude/{global,project}/CLAUDE.md.template; settings and MCP examples
  Cursor: cursor/global/RULES.md.template; cursor/project/rules/*.mdc.template; MCP example
  Shared Skills: skills/ (English); zh-CN/skills/ (Chinese)
  Simplified Chinese adapters: zh-CN/{rules,codex,claude,cursor}/
```

The source repository's root `AGENTS.md` is a maintainer-specific Layer 2 instruction file. It governs changes to this repository and is intentionally distinct from the distributable `rules/project/AGENTS.md.template` template copied into downstream document-delivery projects.

## Quick Start

### 1. Install Codex rules

```bash
# Global directives: first-time install only
codex_home="${CODEX_HOME:-$HOME/.codex}"
mkdir -p "$codex_home"
if [ ! -s "$codex_home/AGENTS.override.md" ] && [ ! -e "$codex_home/AGENTS.md" ]; then
  cp codex/global/AGENTS.md.template "$codex_home/AGENTS.md"
fi

# Project document-delivery discipline: only when the target does not exist
if [ ! -s /path/to/your-project/AGENTS.override.md ] && [ ! -e /path/to/your-project/AGENTS.md ]; then
  cp rules/project/AGENTS.md.template /path/to/your-project/AGENTS.md
fi
```

If a destination has a non-empty `AGENTS.override.md`, that file is the effective instruction source at the same scope; back it up and merge deliberately instead of creating an inactive `AGENTS.md`. If `AGENTS.md` already exists, back it up and merge only the relevant sections. Do not replace existing personal or project rules blindly. These templates contain opinionated defaults for role, language behavior, reasoning depth, authorization, and delivery discipline; adapt them to the user, team, and repository. The English global template is language-neutral, while the `zh-CN/` template intentionally defaults to Simplified Chinese.

### 2. Choose a Skill source

Rules, configuration, and Skills are selected separately. If the nine RD Skills are already installed in a deliberate user-level source, reuse that source; the project-rule recipes do not install another Skill tree. Codex supports `~/.agents/skills/`, and Cursor documents compatibility with that root. Confirm actual discovery in a fresh client session; this repository does not establish Cursor runtime selection.

For a new local installation, use the canonical source and the verified PowerShell installer:

```powershell
pwsh -File ./scripts/install-rd-skills.ps1 -Language en
pwsh -File ./scripts/install-rd-skills.ps1 -Language en -CheckOnly
```

Project/team installations and Claude Code local fallback remain available from `skills/` or `zh-CN/skills/` using `-DestinationRoot`. See the [source-to-installation mapping](docs/installation.md#source-and-destination-map). For Claude desktop/chat and Claude Code account sharing, use the [claude.ai upload workflow](claude/README.md#claudeai-skill-upload); account caches are never authoritative source trees.

### 3. Review Codex config examples

Start from the reviewed, opinionated workspace-write example:

```bash
codex_home="${CODEX_HOME:-$HOME/.codex}"
mkdir -p "$codex_home"
if [ ! -e "$codex_home/config.toml" ]; then
  cp codex/examples/config.example.toml "$codex_home/config.toml"
fi
```

If `$CODEX_HOME/config.toml` already exists (default: `~/.codex/config.toml`), review and merge only the sections you need. The example deliberately uses live web search, enables Memories, inherits the full parent shell environment, and keeps Codex's default `KEY`/`SECRET`/`TOKEN` name filtering enabled with `ignore_default_excludes = false`. These choices match the maintainer's reviewed operating baseline; they are not neutral defaults for every user or threat model.

See the [Codex configuration guide](docs/codex-configuration-guidance.md) for optional memory-model and eligibility choices, Fast selection, Windows MXC, and verification/recovery steps. These recipes do not change the public defaults.

The high-permission profile is intentionally separate:

```text
codex/examples/config.full-access.example.toml
```

Use it only for trusted local workspaces where broad filesystem access is explicitly acceptable.

### 4. Configure optional MCP credentials

```bash
cp .env.example .env
```

Fill only the keys for MCP servers you actually enable.

### 5. Use Simplified Chinese templates

Use the Simplified Chinese translation pack:

```text
zh-CN/
```

Cursor English files are available under:

```text
cursor/project/
```

Cursor-specific Chinese files are under:

```text
zh-CN/cursor/project/
```

## Skill Reference: Eight Specialists and One Explicit Orchestrator

| Skill | Primary deliverable | Typical use |
|---|---|---|
| `$rd-requirement` | Structured requirements / PRD | turn raw user needs into verifiable requirements |
| `$rd-feasibility` | Feasibility study / feasibility analysis | evaluate technical, economic, schedule, compliance, operational, and risk feasibility |
| `$rd-research` | Evidence package / research notes / fact-check matrix | research standards, open source, AI tools, configuration behavior, and contested claims |
| `$rd-solution` | Technical proposal / high-level design / construction plan | compare candidate solutions and produce design-ready technical documents |
| `$rd-design` | Detailed design | define interfaces, data models, flows, errors, security, and concurrency |
| `$rd-specification` | Standards/specification draft or clause revision | draft or revise standards and normative clauses |
| `$rd-writing` | Technical article / white paper / evidence report / decision brief | turn verified material into audience-ready professional documents |
| `$rd-review` | Independent review findings | review engineering documents, research reports, standards, and technical or public-affairs articles |
| `$rd-delivery` | Delivery charter / artifact map / phase gates / handoff | explicitly coordinate multi-stage, multi-document, or cross-session engagements |

The first eight specialist Skills in the table are independently usable and do not form a forced pipeline. `rd-delivery` is the ninth Skill and serves only as an explicit orchestrator. Use `$rd-research` when external or contested evidence is needed, `$rd-writing` when verified evidence must become an audience-ready narrative, and `$rd-review` when an independent verdict is required. Use `$rd-delivery` only when the request explicitly asks for cross-artifact orchestration, phase gates, or a durable handoff; the request need not name the Skill, but complexity or multiple outputs alone do not qualify. This boundary lives in the Skill description, the shared routing rules, and the trigger evals; no platform-specific invocation flag restricts it to named invocation.

Each skill includes output and trigger-boundary cases under `evals/` plus ChatGPT/Codex desktop metadata under `agents/openai.yaml`. Multi-mode Skills keep their common workflow in `SKILL.md` and load only the selected checklist from `references/`. Shared bodies use neutral `rd-*` identifiers; Codex examples use `$rd-*`, Cursor and local Claude Code fallback use `/rd-*`, while Claude account-synced Skills use `/anthropic-skills:rd-*`.

For an optional external-model experiment over retained synthetic evaluation responses, see the [Jev semantic-check pilot](docs/jev-pilot.md). It records a high-confidence false positive and keeps Jev advisory; it is not a default dependency, Skill router, or release gate.

The maintained rules and explicit `rd-delivery` workflow are value-first: identify the current stage and primary outcome, validate the shortest evidence path, and reuse applicable gates before expanding support work. New generalized validators, broad test matrices, security-hardening tracks, or frameworks require approved scope, an observed reproducible failure, an authoritative requirement, or a material risk. Behavior evaluation proceeds from an environment smoke test to changed-surface cases and related regression; a full cross-platform matrix is reserved for shared routing, public contracts, release decisions, observed cross-surface risk, or an explicit user request.

See [RD Skills Assessment and Evolution](docs/rd-skills-assessment.md) for the role-coverage matrix, non-goals, external design evidence, and the reason the taxonomy contains eight specialist Skills plus one explicit orchestrator.

For an approved Simplified Chinese profile to paste into ChatGPT on the web, with a complete English reference translation and character-limit guidance, see [ChatGPT Web Custom Instructions](docs/personalized-custom-instructions.md).

For the approved English-only Claude web profile, with exact character counts, account-setting scope, and verification limits, see [Instructions for Claude](docs/claude-personalized-instructions.md).

## Platform Adapters and Languages

The source tree separates shared rules and Skills from platform-specific carriers:

| Surface | English source | Simplified Chinese source | Native destination |
|---|---|---|---|
| Shared project rules | `rules/project/AGENTS.md.template` | `zh-CN/rules/project/AGENTS.md.template` | `{project}/AGENTS.md` |
| Codex global rules | `codex/global/AGENTS.md.template` | `zh-CN/codex/global/AGENTS.md.template` | `{CODEX_HOME}/AGENTS.md` |
| Claude global/project rules | `claude/{global,project}/CLAUDE.md.template` | `zh-CN/claude/{global,project}/CLAUDE.md.template` | `~/.claude/CLAUDE.md`; `{project}/CLAUDE.md` |
| Cursor global/project rules | `cursor/global/RULES.md.template`; `cursor/project/rules/*.mdc.template` | same paths under `zh-CN/` | User Rules in Customize; `{project}/.cursor/rules/*.mdc` |
| Shared RD Skills | `skills/rd-*` | `zh-CN/skills/rd-*` | deliberate user/project root or claude.ai upload |

The Claude project adapter imports the installed shared project core with `@AGENTS.md`; change shared behavior in the shared source. Cursor project rules use native MDC activation semantics. `00-global-principles` is project-wide conduct, distinct from Cursor user-level global rules.

[Claude Code](claude/README.md) and [Cursor](cursor/README.md) explain platform-specific settings, MCP, Skill discovery, and optional installation. The [installation guide](docs/installation.md) gives the complete source → destination mapping. The [layout migration guide](docs/layout-migration.md) maps former paths and explains why a repository move does not change a personal installation. Remove `.template` when installing rule files; do not recursively copy a source adapter directory into a project.

## Reviewed Public Defaults

The public examples combine safety boundaries with explicit capability choices; they are reviewed and opinionated, not universally conservative:

- no `danger-full-access` by default;
- no Windows elevated sandbox by default;
- no hardcoded personal model name;
- no default third-party relay URL;
- Codex uses `workspace-write`, live search, Memories, full shell-environment inheritance, and the default sensitive-name exclusions; merge these choices manually for the target environment;
- Codex MCP servers remain disabled until credentials and use cases are reviewed;
- Cursor adapter MCP config is shipped as a one-server Context7 `mcp.example.json`, not as an active `.cursor/mcp.json`;
- Claude Code project settings deny direct reads of common secret paths at any depth under the working directory and ask for confirmation on matching Bash and Windows PowerShell commit, push, tag, publish, delete, and uncommitted-work-discarding Git command prefixes (`reset --hard`, `clean`, `checkout --`, `restore`); these permission patterns are guardrails, not a complete security boundary for every wrapper or complex command;
- package versions are documented in `docs/compatibility.md` and should be refreshed before release;
- Context7 uses the same unversioned package name across Codex/Cursor examples; compatibility documents retain the historical tested version, and each resolved version needs separate client-runtime verification.

## Repository Layout

```text
codex-three-layer-delivery/
  AGENTS.md                         # repository-maintainer authority
  rules/project/AGENTS.md.template   # shared downstream project core
  skills/rd-*/                      # canonical English Skills
  codex/
    global/AGENTS.md.template
    project/config.example.toml
    examples/config*.example.toml   # existing configuration profiles
  claude/
    README.md
    global/CLAUDE.md.template
    global/settings.example.json
    project/CLAUDE.md.template
    project/settings.example.json
    project/mcp.example.json
  cursor/
    README.md
    global/RULES.md.template
    project/rules/*.mdc.template
    project/mcp.example.json
    project/PROMPTS.md
  zh-CN/
    README.md
    PROMPTS.md
    rules/                          # shared project-rule translation
    skills/                         # Chinese Skills, one source tree
    codex/
    claude/
    cursor/
    docs/
  docs/
    installation.md
    layout-migration.md
    compatibility.md
    release-checklist.md
  scripts/
    install-rd-skills.ps1
    package-claude-ai-skills.ps1
    validate.ps1
    test-validator.ps1
    validate-release.ps1
  schemas/
  requirements-validation.txt
  PROMPTS.md
  ATTRIBUTION.md
  CONTRIBUTING.md
  SECURITY.md
  LICENSE
```

There are no maintained platform Skill payload mirrors. Optional installation and claude.ai packaging read the two canonical language trees directly. Account-synced directories remain read-only comparison targets, never packaging sources.

## Validation

The Skill YAML/reference and Codex TOML/JSON-Schema gates require Python 3.9+ and the pinned validation dependencies. Install them in an isolated environment, then run the repository checks:

```powershell
python -m pip install -r requirements-validation.txt
pwsh ./scripts/validate.ps1
pwsh ./scripts/test-validator.ps1
```

The validator checks common release blockers:

- CRLF drift in Markdown, TOML, MDC, and script files;
- malformed or duplicate-key Skill YAML, missing or invalid frontmatter, unresolved or escaping one-level references, per-step completion criteria, metadata, and eval coverage;
- inconsistent canonical English/Chinese Skill sets or unsupported platform payload mirrors;
- missing evidence-state and no-change controls across Codex, Claude, and Cursor surfaces;
- a missing or weakened repository-maintainer root `AGENTS.md`, revision-aware context-reuse contract, or dynamic task-state boundary;
- loss of the value-first shortest-path and bounded-gate-expansion contract across maintained agent surfaces;
- loss of the public Codex execution-efficiency and context-hygiene contract;
- invalid platform prompt prefixes, Claude permission/attribution settings, Cursor rule extensions or MCP credential transport, or Unix global Skill installation prerequisites;
- Codex TOML parse/schema errors, English/Chinese semantic drift, or loss of the reviewed `web_search`, shell-environment, and Memories contract;
- more than one always-on Cursor Project Rule, non-trigger-oriented on-demand descriptions, or loss of cross-platform anti-anchoring, context-repair, and durable-guidance approval controls;
- loss of the optional greenfield open-source research and approval-gate prompt contract;
- loss of the optional high-impact bidirectional-argument and critical-clarification prompt contract;
- Context7 package-policy drift across Codex/Cursor examples and bilingual historical-version mismatches;
- unsafe or private values in the public Codex config example;
- stale GSD canonical attribution or a missing archived-source marker;
- a missing `.tmp/local/` boundary;
- obvious secret leaks;
- stale private/internal strings.

The negative-test runner copies the current repository into verified system-temporary directories and proves that the real validator rejects twenty-nine regression cases. In addition to the existing Skill, mirror, evidence, global-rule, context, prompt, temporary-data, and platform-configuration cases, it now covers the Codex schema/runtime-aligned configuration contract, Cursor's exactly-one always-on loading policy, cross-platform reasoning and durable-guidance governance, current-versus-archived GSD attribution, the explicit delivery-request boundary, and Claude shared-import installation guards.

Before publishing a release, also run the networked dynamic gate:

```powershell
pwsh ./scripts/validate-release.ps1
```

It compares the tracked Codex schema with the current official schema, validates the maintained public user/project example inventory against the live copy, checks the installed Codex version, and strict-loads each example from an isolated temporary `CODEX_HOME`. A passing static gate does not replace this release check.

## Versioning

Use GitHub releases and tags for versions, for example `v4.0.0`.

Avoid encoding version or language into the repository name. Keep the repository name stable and put edition-specific details in documentation or release notes.

Repository maintainers should follow the [release checklist](docs/release-checklist.md). It governs publication of this repository and does not expand the RD Skills into release-operation workflows.

## Acknowledgements

This project was informed by broad patterns from the following public repositories. Listing them does not imply upstream endorsement, partnership, compatibility, or direct derivation; see [ATTRIBUTION.md](ATTRIBUTION.md).

- [Matt Pocock Skills](https://github.com/mattpocock/skills.git)
- [Everything Claude Code](https://github.com/affaan-m/everything-claude-code.git)
- [GSD Core](https://github.com/open-gsd/gsd-core)
- [Rlues](https://github.com/WenJunDuan/Rlues.git)
- [Superpowers](https://github.com/obra/superpowers.git)
- [oh-my-codex](https://github.com/Yeachan-Heo/oh-my-codex.git)
- [Trellis](https://github.com/mindfold-ai/Trellis.git)
- [Addy Osmani Agent Skills](https://github.com/addyosmani/agent-skills)
- Thanks to the [LINUX DO](https://linux.do/) community for providing a place for open-source discussion and promotion.

## License

MIT. See `LICENSE`.

Source maintainers: root `.claude/settings.json` is a maintainer-only empty configuration, not a distributable Claude adapter; source templates use non-native paths and suffixes. See [compatibility evidence](docs/compatibility.md).
