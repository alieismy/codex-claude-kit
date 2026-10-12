# Compatibility

The npm registry latest versions were rechecked on 2026-10-12; the installed Codex CLI and release schema baseline are `0.162.1`, and the installed Claude Code CLI is `2.1.296`. The earlier Claude Code `2.1.287` observation retains its 2026-10-02 date; registry latest does not establish runtime testing. Other installed versions and runtime observations retain their original dates: Cursor version 2026-09-11, Cursor Rules/Skills/FAQ documentation 2026-09-16, detailed Claude Code documentation 2026-09-04, and the bounded Context7 stdio probe 2026-08-14. Recheck registry versions and decision-relevant tool/API surfaces before each release.

## 2026-10-12 layout and platform contracts

The source migration moves the shared project core to `rules/project/AGENTS.md.template`, uses template suffixes and non-native source directories for distributable instructions, consolidates Chinese Cursor files under `zh-CN/cursor/`, and removes four platform Skill mirrors. Only `skills/` and `zh-CN/skills/` are maintained sources. See [layout migration](layout-migration.md) and [current installation](installation.md). Dated records below retain their former paths, sample counts, versions, fixtures, and results as historical-layout evidence; they do not validate this new layout.

Official pages actually opened on 2026-10-12 confirm that Claude settings and MCP use distinct carriers/scopes: project MCP is root `.mcp.json`; user/local MCP is in `~/.claude.json`. Claude Skills lists `.claude/skills` rather than a common `.agents/skills` discovery root. Cursor supports project/user `.agents/skills` and compatible client roots; User Rules, project MDC, IDE settings, and CLI config remain distinct. [Claude settings](https://code.claude.com/docs/en/settings), [Claude MCP](https://code.claude.com/docs/en/mcp), [Claude Skills](https://code.claude.com/docs/en/skills), [Cursor Skills](https://cursor.com/docs/skills), [Cursor rules](https://cursor.com/help/customization/rules), [Cursor CLI config](https://cursor.com/docs/cli/reference/configuration)

The new Codex project config and Claude user settings/project MCP are selected local entry points; Cursor global rules are selected in Customize → Rules. They do not establish comprehensive CLI/cloud support. The Claude MCP example is the official OpenAI documentation HTTP service and becomes project configuration only when installed as `.mcp.json`. `enableAllProjectMcpServers=false` does not prove headless connections are blocked. The claude.ai packager reads the canonical language sources; account caches are read-only comparison targets.

Root maintainer `.claude/settings.json` is now an empty object; former `claudeMdExcludes` entries are removed after source-template renaming. Source shape and static gates alone do not prove maintenance-session isolation. This migration does not change personal installations or upload account Skills, and has no real Cursor client verification.

The [new sanitized evidence](evidence/layout-migration-2026-10-12.json) records one Windows Claude Code `2.1.296` isolated fixture: eight exact current bilingual rule templates at source-relative paths in an independent temporary Git repository, with native memory/Skill positive controls. All nine requested reads executed. `InstructionsLoaded` recorded root, inherited user/managed, and control-directory native `CLAUDE.md` loads, with no `.template` memory event. The control Skill launched; both former directory-qualified `rd-research` names returned `Unknown skill`. Nine account RD Skills appeared initially but were not all invoked. The process exited 0 in 14.5 seconds. User settings and account Skills remained inherited; this single-fixture result does not generalize to Cursor, Codex instruction loading, MCP connections, desktop behavior, or current remote account state. `InstructionsLoaded` does not report direct `AGENTS.md` loading, so hooks alone cannot prove AGENTS-template loading or isolation. The eight files are fixture inputs, not eight hook-observable loads.

The same record's `installationRecipes` extracts the Cursor/Claude project PowerShell blocks verbatim from both installation guides and executes them against four independent temporary targets. All four successful paths produced native files matching source SHA-256 values (ten `.mdc` files per Cursor target, three project files per Claude target); all four repeated installs refused without changing the targets. Claude recipes created no project Skills. This establishes PowerShell file installation only, not personal-directory changes, Bash execution, client startup/discovery, MCP activation, or runtime acceptance.

The same record retains exact payload comparison of nine ZIPs per language (24 runtime payload files each) with the canonical source and pre-migration baseline. Each language's 62 source files remains unchanged; `evals/` and `agents/` are excluded by the packaging contract. This establishes package payload equality, not upload or server-side replacement.

| Current surface | English source | Chinese source |
|---|---|---|
| Shared project rules | `rules/project/AGENTS.md.template` | `zh-CN/rules/project/AGENTS.md.template` |
| Cursor user rules | `cursor/global/RULES.md.template` | `zh-CN/cursor/global/RULES.md.template` |
| Cursor project rules/MCP | `cursor/project/rules/*.mdc.template`; `cursor/project/mcp.example.json` | same layout under `zh-CN/cursor/project/` |
| Claude global/project rules | `claude/{global,project}/CLAUDE.md.template` | same layout under `zh-CN/claude/` |
| Claude settings/MCP | `claude/global/settings.example.json`; `claude/project/{settings,mcp}.example.json` | same layout under `zh-CN/claude/` |
| Skills | `skills/rd-*` | `zh-CN/skills/rd-*` |

## Codex

The separate 2026-10-05 [forward-looking RD update](forward-looking-rd.md) changes shared instruction and selected RD contracts and records a bounded Astra `max` / Sol 6.1 `high` supplied-text comparison. It does not establish native Skill discovery, delegation, or cross-client loading for those changes.

The 2026-10-05 [configuration and Skill follow-up](config-skill-tuning.md) used CLI `0.160.0` for a bounded supplied-text comparison of Astra `xhigh/max` and Sol 5.6/6.1 `high`, with retained failures and inherited-context limits. It also checked a narrowed Hugging Face description, removed the retired personality setting from public examples, and clarified explorer permission wording. Native tool execution was blocked; this does not expand the broader runtime baseline below.

| Component | Tested version | Registry latest checked | Notes |
|---|---:|---:|---|
| `@openai/codex` npm package | `0.147.0` | `0.162.1` | Registry latest and installed CLI `0.162.1` were rechecked on 2026-10-12. The tagged `0.162.1` schema was fetched for this release baseline; the release gate compares it with the current live schema and checks every maintained public user/project example. The broader tested baseline remains `0.147.0`. Do not hardcode this into the repository name or AGENTS rules. |

The repository vendors the Codex `0.162.1` configuration schema as an offline snapshot with provenance and SHA-256 metadata under `schemas/`. `scripts/validate.ps1` uses the snapshot deterministically; the release-only `scripts/validate-release.ps1` compares it with the current official schema, checks the installed CLI version, validates all six maintained user/project examples against the live copy, and strict-loads each example from an isolated temporary `CODEX_HOME`.

The separate 2026-09-20 [dual-model evaluation](dual-model-compatibility.md) used CLI `0.155.1` and requested `gpt-5.6-sol` and `gpt-6-astra`, both with high reasoning and high verbosity. Supplied-text assertions scored 42/48 and 46/48 respectively; four native attempts were blocked. The report preserves failures and limits, does not verify backend identity or implicit routing, and does not replace the release schema or broader baseline above.

The 2026-10-02 [native routing smoke record](evidence/skill-routing-smoke-2026-10-02.json) retains five synthetic English attempts: four passed the loading expectations and one Codex orchestration attempt timed out after loading the delivery body. Both tools kept `rd-delivery` unloaded for a PRD plus summary without orchestration; Claude completed the unnamed orchestration request. Existing user-level context remained active. This checks bounded selection/loading, not output quality, clean-environment behavior, import completeness, or Cursor compatibility.

The [matched-budget follow-up](evidence/skill-routing-followup-2026-10-02.json) ran T3 and the unhinted T6 with a 300-second limit on both Codex and Claude: all four attempts passed. Explicit orchestration loaded `rd-delivery`; a PRD plus short summary without a negative routing hint did not. These bounded observations preserve the earlier timeout and do not establish statistical stability or document quality.

The [timed Chinese CLI follow-up](evidence/skill-routing-zh-cli-2026-10-02.json) copied Chinese project templates and all nine Chinese Skills into temporary projects. With corrected UTF-8 capture and event-based selection checks, all four 300-second attempts passed; each process and launcher duration is retained. The initial four scoring failures and two file-encoding diagnostic failures remain recorded: the PowerShell collector inherited codepage 936 and misdecoded UTF-8 CLI output, while the old scorer omitted actual Claude Skill calls. A deterministic capture probe verified the fix. These are measurement failures, not established routing regressions. The corrected phase uses the original Chinese prompts without an encoding or routing hint. Existing user-level context and same-name precedence limits remain; this is not desktop acceptance or a reliability estimate. Earlier English elapsed times and the exact Oct 1 invocation timeout remain unmeasured or unknown.

The 2026-10-05 [upstream-learning comparison](upstream-learning-pilot.md) used CLI `0.160.0` with requested `gpt-6-astra`, reasoning `max`, and verbosity `medium`. Six first-attempt native cells compared a staged Chinese `rd-review` with the target disabled: both enabled review requests successfully read the complete target body, neither disabled counterpart read it, and both factual near-miss arms left it unread. All 24 frozen semantic assertions passed under blinded task-agent grading and maintainer review. This establishes the selected loading boundaries and equivalent observed assertion results, not an incremental quality benefit or justification to disable the existing Skill. The record retains per-cell elapsed time, cache and token fields, local exact-file selector probes, and separate supplied-text document-method comparisons. Shared inherited context, backend identity, repeated reliability, English behavior, other clients, and real-workflow benefits remain outside this result.

The 2026-10-09 release-baseline review found the tagged `0.162.0` schema byte-identical to the official live copy. Relative to `0.160.0`, it adds optional capabilities and removes plugin `ema_auth` configuration; none of the four public examples uses the removed fields, so their configuration values and permission defaults remain unchanged. A schema field does not establish feature availability. The release gate checks schema, CLI version, and strict loading separately without expanding historical runtime claims.

The 2026-10-10 release preflight initially failed because installed Codex `0.162.1` differed from the `0.162.0` schema pin. The tagged `0.162.1` schema and license were then checked: the tagged schema, current live schema, and existing snapshot are byte-identical, and the license is unchanged. Only provenance, version comments, and compatibility records were refreshed; example configuration values and permissions were not changed. The unchanged release gate must pass on the refreshed baseline.

<a id="codex-configuration-guidance-2026-10-11"></a>

### 2026-10-11 configuration guidance

The [configuration guide](codex-configuration-guidance.md) adds optional Markdown recipes and verification/recovery guidance. Public configuration values, permission defaults, global instructions, and Skills remain unchanged. The installed CLI was rechecked as `0.162.1`; the offline schema baseline remains `0.162.1`. This is not a new registry or release-baseline check.

The official [configuration reference](https://learn.chatgpt.com/docs/config-file/config-reference), [memory controls](https://learn.chatgpt.com/docs/customization/memories), and [profile guidance](https://learn.chatgpt.com/docs/config-file/config-advanced#profiles) were reviewed on this date. Profiles use separate `<name>.config.toml` files. Model access, generation eligibility, use of existing memories, and successful configuration loading are separate questions.

The official [Standard token rates](https://learn.chatgpt.com/docs/pricing#token-rates) on this date were:

| Model | Input credits / 1M tokens | Cached input credits / 1M tokens | Output credits / 1M tokens |
|---|---:|---:|---:|
| GPT-5.6 Sol | 100 | 10 | 500 |
| GPT-6.1 Sol | 50 | 2.5 | 250 |

These rates do not establish actual background-memory usage or quality. Credit prices alone do not determine included subscription usage; API-key usage and some Enterprise agreements follow different pricing. The guide therefore treats two GPT-6.1 Sol phases as an optional candidate, not a measured optimum or a public default, and does not assume that an older extraction model is cheaper.

The [Windows guide](https://learn.chatgpt.com/docs/windows/windows-sandbox#enable-mxc) recommends MXC preference on compatible devices, while local `codex features list` reports `prefer_mxc` as `under development`. The reference documents the standalone default as disabled; Desktop rollout and local overrides are separate. These statements describe different evidence and do not establish universal maturity. The official [MXC compatibility probe](https://learn.chatgpt.com/docs/windows/windows-sandbox#mxc-compatibility) requires CLI `0.162.0` or newer. The published command checks startup only; this documentation change does not verify sandbox isolation or detached-server behavior.

The guide distinguishes base app-server strict loading from a profile-aware CLI load. In CLI `0.162.1`, `codex app-server --help` lists `--strict-config` but no profile selector, while the main CLI exposes `--profile`. Loading configuration does not verify MCP calls, memory generation, billing, quality, or Desktop preservation of profile/base separation. The Markdown snippets are outside the existing four-file public TOML inventory; future distributed profiles must join the maintained validation inventory.

The subsequent v1.8.6 release preflight on 2026-10-11 rechecked the Codex, Claude Code, and seven MCP package registry entries: their listed latest versions remained unchanged. The networked release gate matched the live schema to the tracked snapshot and passed four isolated strict loads with Codex `0.162.1`. Separately, all eight bilingual guide TOML snippets and their eight merged candidates passed the pinned schema; the four public examples retained exactly the same parsed values. These checks do not expand runtime or model-quality claims.

## Claude Code

The release follow-up [installation guard probe](evidence/claude-installation-guards-2026-10-02.json) executed all eleven published Claude Bash installation blocks with isolated HOME and project targets on Windows Git Bash. All 52 cases passed, including existing project/user memory, existing settings, empty shared cores, and effective overrides. Guarded failures preserved the original files and did not copy user memory before project preflights. This establishes bounded installation file behavior, not Claude instruction loading; concurrent installers were not tested.

| Component | Tested/pinned version | Registry latest checked | Notes |
|---|---:|---:|---|
| `@anthropic-ai/claude-code` npm package | Not pinned by this repository | `2.1.296` | Registry latest and installed CLI `2.1.296` were rechecked on 2026-10-12. The earlier `2.1.287` observation was on 2026-10-02. The settings schema, adapter structure, and `claude doctor` were last re-checked with `2.1.260` on 2026-09-04. Dangerous-command permission behavior was not exercised; settings validation is not proof that every wrapper or compound command will be intercepted. |

The [memory documentation](https://code.claude.com/docs/en/memory#agents-md), checked on 2026-10-01, states that Claude Code reads `AGENTS.md` directly from v2.1.277 only when no `CLAUDE.md` is present, and that an `@AGENTS.md` import in `CLAUDE.md` is never read twice. The project adapter therefore uses the import. This is documentation evidence; loading was not verified on the maintainer's installed CLI.

Official Claude Code docs checked: [memory](https://code.claude.com/docs/en/memory), [settings](https://code.claude.com/docs/en/settings), [permissions](https://code.claude.com/docs/en/permissions), and [skills](https://code.claude.com/docs/en/skills).

The 2026-10-09 claude.ai Skill packaging check observed installed CLI `2.1.295`. Synced copies of nine RD Skills uploaded on 2026-10-01 had `SKILL.md` files byte-identical to historical Claude adapter blobs and no added files. After the nine English archives from `scripts/package-claude-ai-skills.ps1` were uploaded on 2026-10-09, the synced copies contained no added files and byte-identical references and `SKILL.md` bodies, but each folded `description: >-` block had been rewritten as a single-line scalar; parsed `name` and `description` values matched for all nine. A byte-only `-Changed` comparison therefore reported all nine as changed; the script now compares that metadata by value and reports them current, and treats frontmatter forms it does not parse as changed. In the same session, personal `~/.claude/skills/rd-*` copies and the synced `anthropic-skills:rd-*` copies were both listed, consistent with the documented short-name precedence without deduplication. Same-name replacement behavior on claude.ai and sync latency were not measured.

A same-day smoke check copied the revised English project adapter without `.claude/skills/` into an isolated temporary project. One headless run selected the account-synced `anthropic-skills:rd-requirement` for a PRD request; one run asked where to change `rd-review` answered with the account source and cited the instruction not to edit synced copies or add a project copy. Each case ran once with inherited user-level context and no baseline comparison. While maintaining this repository, editing `claude/project/CLAUDE.md` and `zh-CN/claude/project/CLAUDE.md` caused Claude Code to load each adapter's `.claude/skills/rd-*` as directory-scoped nested Skills (`claude/project:rd-*`, `zh-CN/claude/project:rd-*`) alongside the account copies; the probe below tests a maintainer-local mitigation.

The [2026-10-09 nested Skill override probe](evidence/claude-nested-skill-overrides-2026-10-09.json) used headless `claude -p` runs on CLI `2.1.295`, one per variant, in temporary fixtures holding both adapters' `rd-research`. Without overrides, reading a file in one adapter loaded that copy under the bare name `rd-research`, which then ran in place of the account copy; reading files in both adapters loaded `claude/project:rd-research` and `zh-CN/claude/project:rd-research`, and bare `rd-research` returned `Unknown skill`. Two `skillOverrides` forms failed. Directory-qualified `off` keys blocked both qualified copies but missed the single-adapter load, which kept the bare name. A bare `"rd-research": "off"` alone also removed `anthropic-skills:rd-research` from the session's initial Skill list. A bare `off` key paired with `"anthropic-skills:rd-research": "on"` blocked the nested copy in both load shapes and kept the account copy listed and invocable.

The same pairing for all nine names, in an ignored `.claude/settings.local.json`, was then checked read-only in this repository. After both adapter `CLAUDE.md` files were read, `claude/project:rd-review` and `zh-CN/claude/project:rd-review` returned the `skillOverrides` error, all nine `anthropic-skills:rd-*` stayed in the initial Skill list, and `anthropic-skills:rd-review` ran. The skills documentation does not state that a bare key matches a directory-qualified nested Skill, so recheck this after CLI upgrades. A bare `off` key also hides personal or project Skills of the same name. Once a nested copy has loaded, the bare name reaches that disabled copy or returns `Unknown skill` instead of running the account copy, so invoke `anthropic-skills:rd-*` by its full name. Only `rd-research` and `rd-review` were invoked, and the interactive `/` menu was not checked. The repository does not commit this override because it depends on each maintainer's Skill source; the maintainer `.claude/settings.json` in that historical layout held only `claudeMdExcludes`.

The [2026-10-09 Opus 5.5 instruction review](opus-5-5-instruction-review.md) originally applied three edits to the Claude global template and its Chinese mirror: a restriction on using subagents to verify the model's own work, removal of Pre-Output Self-Review, and removal of three Thinking Methods. Before adoption, 12 headless `claude -p` runs on CLI `2.1.295` with `claude-opus-5-5` at `xhigh` covered four eval tasks × three arms, one sample each. Every historical arm passed 28 of 29 frozen assertions, and all three failed the same T2 word limit. The [historical evidence record](evidence/opus-5-5-instruction-ab-2026-10-09.json) retains the full responses. The result shows no detected regression in those arms, not an improvement.

On 2026-10-10, the user required first-principles decomposition, task classification, and multi-perspective reasoning to remain. The Claude global templates restore all six Thinking Methods while retaining R1/R2; the current template is not historical arm A2, and the old comparison does not validate this new combination. The follow-up corrects the rationale: these methods are analytical preferences, not a request to reveal internal reasoning. For explicit hard length limits, the `rd-writing` follow-up establishes the counting unit and scope, requires deterministic counting of final text and recounting after the last edit, and discloses unavailable counting instead of claiming a pass, with necessary adapter mirrors. The [follow-up evidence](evidence/claude-instruction-followup-2026-10-10.json) records the new probes and results separately. The packaging script's no-change message now refers only to the local last-synced copies; local equality does not confirm current claude.ai state. The [official Skills upload contract](https://code.claude.com/docs/en/skills#using-skill-frontmatter-outside-claude-code), checked on 2026-10-10, permits only standard Agent Skills fields on claude.ai, excludes Claude Code's `effort`, and rejects unsupported fields at packaging or upload. No personal installation or account update follows from these repository changes.


The [2026-10-01 historical smoke record](evidence/skill-routing-smoke-2026-10-01.json) preserves four completed Codex attempts and four Claude authentication blocks (`Not logged in`). The user confirmed logging in before the Oct 2 Claude passes. No upgrade-fix claim follows. Codex T3 previously completed after about 271 seconds of file capture, while the Oct 2 attempt had a 180-second limit; this is not a controlled routing-regression comparison.

The [2026-10-02 source-maintenance isolation probe](evidence/claude-source-isolation-2026-10-02.json) reproduced nested loading of both Claude global language templates. Excluding their paths suppressed those loads while a control instruction still loaded and synthetic files remained readable. A final-config fixture subsequently read all eight template directories, the positive control and the root maintainer rules. The historical source layout therefore had a maintainer-only `.claude/settings.json` excluding eight declared instruction templates; that result does not validate the current renamed templates with an empty configuration. Do not copy this root configuration into downstream projects. Direct AGENTS loading does not emit `InstructionsLoaded`, so that hook alone does not establish AGENTS loading or exclusion behavior. Existing user-level context remained active.

A prior installation probe inadvertently executed a user-level copy from a combined installation block and overwrote the user's `~/.claude/CLAUDE.md` with the then-current Chinese public template. The deviation was identified during this follow-up; the original file has not been recovered from a verified backup. Current installation probes isolate HOME and targets, and preserve this limit when interpreting inherited context. No personal identifier or credential is retained here.

The user subsequently confirmed that no original backup exists and authorized the revised Chinese global template as the new baseline. The current personal file was backed up before updating `~/.claude/CLAUDE.md`, and its hash matches the revised template. This adopts a new baseline rather than restoring unknown original content; the probes above precede this update.

## Cursor

The Cursor Rules, Skills, and FAQ documentation was rechecked on 2026-09-16; the installed Windows desktop version observed on 2026-09-11 was `3.20.10` (system setup):

- [Rules](https://cursor.com/docs/rules.md): Project Rules live in `.cursor/rules` as `.mdc` files. Plain `.md` files are ignored by the rules system; use `AGENTS.md` for plain Markdown guidance. Cursor supports nested `AGENTS.md` files, applies them when working with files in their directory or descendants, combines them with parent instructions, and gives more-specific instructions precedence.
- [Skills](https://cursor.com/docs/skills.md): Agent Skills are portable, version-controlled packages that can include scripts, templates, and references. Cursor discovers project and user Skills from `.agents/skills/`, `.cursor/skills/`, `~/.agents/skills/`, and `~/.cursor/skills/`, and also loads `.claude/skills/`, `.codex/skills/`, `~/.claude/skills/`, and `~/.codex/skills/`. The official documentation does not define precedence or deduplication for same-name Skills found in multiple roots. A shared/Codex installation under an Agents root combined with the Cursor adapter's `.cursor/skills/` is already a multi-source installation even without Claude Code. Since 2026-10-01 the shared, Claude Code, and Cursor `rd-delivery` copies carry identical content and no platform-specific invocation flag; same-name selection ambiguity remains.
- [MCP](https://cursor.com/docs/mcp.md): project-specific MCP servers are configured through `.cursor/mcp.json`; global servers use `~/.cursor/mcp.json`.
- [Rules FAQ](https://cursor.com/help/customization/rules#how-does-claudemd-work-in-cursor) (checked 2026-09-16): Cursor reads `CLAUDE.md` the same way it reads `AGENTS.md`, and `CLAUDE.md` files are always applied to every conversation regardless of any `alwaysApply` frontmatter setting. Combining the Claude Code and Cursor adapters therefore adds another always-on instruction file as well as another discoverable Skill source; see `cursor/README.md`.

A 2026-09-16 maintainer session reported that the four distributable `AGENTS.md` templates under `codex/` and `zh-CN/codex/`, plus the English and Chinese Cursor `00-global-principles.mdc` files, were surfaced together as effective instructions. Those six files in the historical record total 64,928 bytes and contain conflicting language directives. This is a single-session runtime observation, not an independently reproduced loading contract; the official nested-`AGENTS.md` documentation describes directory-scoped application instead. That historical observation has no verified isolation mechanism; runtime isolation after this migration requires separate verification. Treat the observation as an unresolved source-repository compatibility risk, not proof that every Cursor session loads all six files or that the root maintainer file overrides them.

The following table preserves the pre-migration adapter layout; use the current table above and migration guide for new installations.

| Historical adapter surface | Historical repository path | Former public-release posture |
|---|---|---|
| English rules | `cursor/project/.cursor/rules/*.mdc` | Cursor-native project rules |
| English skills | `cursor/project/.cursor/skills/rd-*/SKILL.md` | Mirrored from root `skills/rd-*` |
| English MCP example | `cursor/project/.cursor/mcp.example.json` | Example only; copy to `.cursor/mcp.json` after review |
| Chinese rules | `cursor/zh-CN/.cursor/rules/*.mdc` | Cursor-specific Simplified Chinese compatibility pack |
| Chinese skills | `cursor/zh-CN/.cursor/skills/rd-*/SKILL.md` | Mirrored from `zh-CN/skills/rd-*` |
| Chinese MCP example | `cursor/zh-CN/.cursor/mcp.example.json` | Example only; copy to `.cursor/mcp.json` after review |

This repository does not ship an active Cursor `.cursor/mcp.json` and does not rely on undocumented `disabled` or `alwaysAllow` fields in Cursor MCP templates.

## MCP Packages

| MCP server | Package | Tested version | Registry latest checked | Default in public config |
|---|---|---:|---:|---|
| Context7 | `@upstash/context7-mcp` | `4.0.2` | `4.3.0` | Codex example disabled; sole Cursor minimal example, inactive until copied and credentialed |
| Tavily | `tavily-mcp` | `0.2.19` | `0.2.22` | Codex example disabled; omitted from Cursor minimal example |
| Sequential Thinking | `@modelcontextprotocol/server-sequential-thinking` | `2025.12.18` | `1.0.0` | Omitted from public minimal examples |
| Brave Search | `@brave/brave-search-mcp-server` | `2.0.82` | `2.1.4` | Omitted from public minimal examples |
| Playwright MCP | `@playwright/mcp` | `0.0.75` | `0.0.83` | Codex example disabled; omitted from Cursor minimal example |
| Chrome DevTools MCP | `chrome-devtools-mcp` | `1.1.1` | `1.10.1` | Codex example disabled; omitted from Cursor minimal example |
| Augment Context Engine | `ace-tool-rs` | `0.1.16` | `0.1.16` | Omitted from public minimal examples |

The 2026-10-12 v2.0.0 release preflight re-queried the Codex, Claude Code, and seven MCP package registry entries and checked the installed CLIs. Eight registry values matched the preceding record; Sequential Thinking returned a `latest` tag of `1.0.0` through both the registry `/latest` endpoint and `npm view ... dist-tags` with the official registry specified. The previous snapshot recorded `2026.8.31`. This reports the current tag without inferring why it changed or an upgrade order; the server remains omitted from public minimal examples, and no new MCP runtime acceptance is established.

Context7 `4.0.2` was verified against the [npm package metadata](https://www.npmjs.com/package/@upstash/context7-mcp/v/4.0.2) and the [official GitHub release](https://github.com/upstash/context7/releases/tag/%40upstash%2Fcontext7-mcp%404.0.2) published on 2026-08-11. The package requires Node.js `>=20.18.1`. On Windows with Node.js `24.18.0`, the package reported the expected CLI version and options, completed a stdio `initialize` exchange for MCP protocol `2025-06-18`, and returned `resolve-library-id` and `query-docs` from `tools/list`.

This is package, static-configuration, and stdio-protocol evidence. It does not prove authenticated Context7 queries, real Codex/Cursor/Claude Code host integration, or business/production acceptance. Those higher evidence layers must be tested in the target client before being claimed.

All Codex/Cursor Context7 examples use the unversioned `@upstash/context7-mcp` package; other npm MCP invocations are also unpinned. The table's `4.0.2` remains a historical tested baseline, not proof that the version resolved by a future installation has been tested. Check the resolved version and runtime requirements before enabling it; consumers needing reproducible installs should pin their own verified version. Other servers remain routing candidates in `docs/mcp-routing.md` and should be added one at a time for a verified need rather than copied as a full catalog. The versions above remain compatibility evidence and must be re-checked before release.

## Optional Jev pilot

On 2026-09-21, a PowerShell synthetic preflight and 22 Python `3.13.12` standard-library evaluation requests on Windows called `https://api.typesafe.ai/v1/systemone` and returned `jev-1.13.0`; no SDK was installed. The [pilot report](jev-pilot.md) records 78 narrow judgments, a high-confidence false positive, deterministic checks and bounded Codex review. This is authenticated API evidence for this experiment, not native Skill-routing integration, calibrated accuracy, Chinese parity, future service/model compatibility, or production acceptance. Jev is optional and absent from default configurations and repository gates.

## Release Rule

Before tagging a release:

1. run `npm view <package> version` for each npm MCP package;
2. update the registry latest column if versions changed;
3. update tested versions only after re-verification;
4. keep every Context7 Codex/Cursor example on the unversioned package name; `scripts/validate.ps1` checks this policy and the bilingual historical version records;
5. leave npm MCP examples unpinned without an explicit `@latest` suffix; check the resolved version and do not treat registry latest as a tested version;
6. run `pwsh ./scripts/validate-release.ps1` to detect official Codex schema drift and strict-load the examples with the matching installed CLI;
7. document any tool-name or API-surface changes in the release notes.
