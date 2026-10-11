# Codex Three-Layer Delivery

An unofficial, deliverable-driven rules-and-skills framework for Codex-first system design, architecture documentation, feasibility analysis, and document review.

This repository packages a three-layer operating model:

1. **Global directives**: personal behavioral rules for accuracy, evidence discipline, and response style.
2. **Project document-delivery discipline**: project-level `AGENTS.md` rules for scope control, quality gates, security, MCP routing, and verification.
3. **Research and document-delivery skills**: eight independent specialist `rd-*` skills plus one explicit delivery orchestrator for requirements, feasibility studies, evidence research, technical proposals, detailed designs, standards work, professional writing, independent review, and cross-session handoff.

It also includes optional Cursor and Claude Code adapter areas for teams that want to port the same document-delivery discipline to other agent environments.

> This project is independent and is not affiliated with OpenAI, Cursor, Anthropic, or any referenced framework. See `ATTRIBUTION.md` for inspiration references.

Simplified Chinese users can start from `zh-CN/`. The English root remains the canonical baseline; `zh-CN/` is a translation pack, `cursor/project/` is the English Cursor adapter, and `cursor/zh-CN/` remains the Cursor-specific Simplified Chinese compatibility pack.

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

Adapter mappings:
  Cursor: cursor/project/.cursor/rules/ and cursor/project/.cursor/skills/
  Cursor zh-CN: cursor/zh-CN/.cursor/rules/ and cursor/zh-CN/.cursor/skills/
  Claude Code: claude/project/CLAUDE.md (imports the shared project AGENTS.md) and claude/project/.claude/skills/
  Simplified Chinese: zh-CN/
```

The source repository's root `AGENTS.md` is a maintainer-specific Layer 2 instruction file. It governs changes to this repository and is intentionally distinct from the distributable `codex/project/AGENTS.md` template copied into downstream document-delivery projects.

## Quick Start

### 1. Install Codex rules

```bash
# Global directives: first-time install only
codex_home="${CODEX_HOME:-$HOME/.codex}"
mkdir -p "$codex_home"
if [ ! -s "$codex_home/AGENTS.override.md" ] && [ ! -e "$codex_home/AGENTS.md" ]; then
  cp codex/global/AGENTS.md "$codex_home/AGENTS.md"
fi

# Project document-delivery discipline: only when the target does not exist
if [ ! -s /path/to/your-project/AGENTS.override.md ] && [ ! -e /path/to/your-project/AGENTS.md ]; then
  cp codex/project/AGENTS.md /path/to/your-project/AGENTS.md
fi
```

If a destination has a non-empty `AGENTS.override.md`, that file is the effective instruction source at the same scope; back it up and merge deliberately instead of creating an inactive `AGENTS.md`. If `AGENTS.md` already exists, back it up and merge only the relevant sections. Do not replace existing personal or project rules blindly. These templates contain opinionated defaults for role, language behavior, reasoning depth, authorization, and delivery discipline; adapt them to the user, team, and repository. The English global template is language-neutral, while the `zh-CN/` template intentionally defaults to Simplified Chinese.

### 2. Install skills

```bash
# Global install: available to all projects
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

# Or project-level install
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

For a verified PowerShell user-level install with backup and exact tree comparison:

```powershell
pwsh -File ./scripts/install-rd-skills.ps1 -Language en
pwsh -File ./scripts/install-rd-skills.ps1 -Language en -CheckOnly
```

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

Cursor-specific Chinese files remain under:

```text
cursor/zh-CN/
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

Each skill includes output and trigger-boundary cases under `evals/` plus ChatGPT/Codex desktop metadata under `agents/openai.yaml`. Multi-mode Skills keep their common workflow in `SKILL.md` and load only the selected checklist from `references/`. Shared bodies use neutral `rd-*` identifiers; Codex examples use `$rd-*`, while explicit Cursor and Claude Code invocation uses `/rd-*`.

For an optional external-model experiment over retained synthetic evaluation responses, see the [Jev semantic-check pilot](docs/jev-pilot.md). It records a high-confidence false positive and keeps Jev advisory; it is not a default dependency, Skill router, or release gate.

The maintained rules and explicit `rd-delivery` workflow are value-first: identify the current stage and primary outcome, validate the shortest evidence path, and reuse applicable gates before expanding support work. New generalized validators, broad test matrices, security-hardening tracks, or frameworks require approved scope, an observed reproducible failure, an authoritative requirement, or a material risk. Behavior evaluation proceeds from an environment smoke test to changed-surface cases and related regression; a full cross-platform matrix is reserved for shared routing, public contracts, release decisions, observed cross-surface risk, or an explicit user request.

See [RD Skills Assessment and Evolution](docs/rd-skills-assessment.md) for the role-coverage matrix, non-goals, external design evidence, and the reason the taxonomy contains eight specialist Skills plus one explicit orchestrator.

For an approved Simplified Chinese profile to paste into ChatGPT on the web, with a complete English reference translation and character-limit guidance, see [ChatGPT Web Custom Instructions](docs/personalized-custom-instructions.md).

For the approved English-only Claude web profile, with exact character counts, account-setting scope, and verification limits, see [Instructions for Claude](docs/claude-personalized-instructions.md).

## Cursor Adapter

The `cursor/` directory contains Cursor adapter documentation, an English adapter, and a Simplified Chinese compatibility pack:

```text
cursor/
  README.md
  project/
    .cursor/rules/*.mdc
    .cursor/skills/rd-*/SKILL.md
    .cursor/mcp.example.json
    PROMPTS.md
  zh-CN/
    .cursor/rules/*.mdc
    .cursor/skills/rd-*/SKILL.md
    .cursor/mcp.example.json
    PROMPTS.md
```

Codex remains the primary target of this repository. Treat Cursor support as optional. The Cursor MCP file is published as `mcp.example.json` and contains only the tested Context7 entry; copy it to `.cursor/mcp.json` only after reviewing credentials, data flow, and the target workspace's MCP status. Add other servers one at a time for a verified use case rather than copying the full routing catalog.

## Simplified Chinese Pack

The `zh-CN/` directory contains a Simplified Chinese translation pack for Codex, Claude Code, shared `rd-*` skills, documentation, and prompts.

```text
zh-CN/
  README.md
  PROMPTS.md
  codex/
  claude/
  skills/
  docs/
```

The English root is the canonical baseline. Use `zh-CN/` as a translation pack, not as a separate source of truth. Cursor English support is in `cursor/project/`; Cursor-specific Chinese support remains in `cursor/zh-CN/`.

## Claude Code Adapter

The `claude/` directory contains a Claude Code compatibility pack:

```text
claude/
  README.md
  global/CLAUDE.md
  project/CLAUDE.md
  project/.claude/settings.json
  project/.claude/skills/rd-*/SKILL.md
```

The project `CLAUDE.md` is a thin adapter: it imports the shared project core with `@AGENTS.md` (installed from `codex/project/AGENTS.md`) and adds only Claude Code-specific guidance, so project rules have one source across Codex and Claude Code.

Codex remains the primary target of this repository. Treat Claude Code support as optional and re-check Claude Code file conventions before changing `CLAUDE.md`, `.claude/settings.json`, or `.claude/skills/` behavior.

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
  AGENTS.md
  codex/
    global/AGENTS.md
    project/AGENTS.md
    examples/
      config.example.toml
      config.full-access.example.toml
  cursor/
    README.md
    project/.cursor/rules/
    project/.cursor/skills/
    project/.cursor/mcp.example.json
    zh-CN/.cursor/rules/
    zh-CN/.cursor/skills/
    zh-CN/.cursor/mcp.example.json
  zh-CN/
    README.md
    PROMPTS.md
    codex/
    claude/
    skills/
    docs/
  claude/
    README.md
    global/CLAUDE.md
    project/CLAUDE.md
    project/.claude/settings.json
    project/.claude/skills/
  skills/
    rd-*/SKILL.md
  docs/
    compatibility.md
    installation.md
    mcp-routing.md
    design-principles.md
    personalized-custom-instructions.md
    claude-personalized-instructions.md
    rd-skills-assessment.md
    release-checklist.md
  scripts/
    install-rd-skills.ps1
    package-claude-ai-skills.ps1
    validate-codex-configs.py
    validate-release.ps1
    validate-skill-metadata.py
    validate.ps1
    test-validator.ps1
  schemas/
    codex-config.schema.json
    codex-config.schema.meta.json
    LICENSE-APACHE-2.0.txt
    NOTICE
  requirements-validation.txt
  PROMPTS.md
  ATTRIBUTION.md
  CONTRIBUTING.md
  SECURITY.md
  LICENSE
```

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
- inconsistent mirrored Skill directory sets or file content;
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

The negative-test runner copies the current repository into verified system-temporary directories and proves that the real validator rejects twenty-four regression cases. In addition to the existing Skill, mirror, evidence, global-rule, context, prompt, temporary-data, and platform-configuration cases, it now covers the Codex schema/runtime-aligned configuration contract, Cursor's exactly-one always-on loading policy, cross-platform reasoning and durable-guidance governance, current-versus-archived GSD attribution, the explicit delivery-request boundary, and Claude shared-import installation guards.

Before publishing a release, also run the networked dynamic gate:

```powershell
pwsh ./scripts/validate-release.ps1
```

It compares the tracked Codex schema with the current official schema, validates all four examples against the live copy, checks the installed Codex version, and strict-loads each example from an isolated temporary `CODEX_HOME`. A passing static gate does not replace this release check.

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

Source maintainers: root `.claude/settings.json` is a repository-only instruction-template exclusion, not a distributable Claude adapter. See [compatibility evidence](docs/compatibility.md).
