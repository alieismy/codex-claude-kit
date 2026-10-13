# Changelog

All notable changes to this project should be documented here.

This project uses GitHub releases for versioning. Directory names should not contain edition or version suffixes such as `v4` or `-en`.

## 3.0.0 - 2026-10-13

- Adopt **Codex & Claude Kit** (`codex-claude-kit`) as the project name. Describe configurations, global/project rules, custom instructions, prompts, and Skills as separately selectable assets for professional work. Retain the three-layer rule/Skill model and the existing RD responsibilities.
- **Breaking support change:** retire Cursor adapters, installation recipes, and current platform checks. Preserve dated release notes, research, and evidence as historical records; existing personal installations are not changed.
- Move the shared Cursor/Claude Code prompt templates to `claude/project/PROMPTS.md` and `zh-CN/claude/project/PROMPTS.md`, retaining task bodies and local/account-synced Skill invocation guidance.
- Make Codex and Claude Code the primary local-agent entry points, retain Claude web/desktop instructions and applicable Skills, and preserve support for the existing ChatGPT web custom-instruction profile. Account instruction bodies and canonical RD Skills are unchanged.
- Update bilingual installation, compatibility, migration, MCP, and release documentation. Replace Cursor-specific negative cases with a retired-source-root regression and preserve Claude prompt invocation checks; the negative runner now defines 28 cases.
- Recheck both installed CLIs and all nine registry entries for release; versions remain unchanged from 2026-10-12. Verify the live Codex schema and all six public configuration examples, including isolated strict-load checks under Codex `0.162.1`; this does not establish MCP, account-upload, or production acceptance.

## 2.0.1 - 2026-10-12

- Corrected the English and Chinese Cursor engineering-discipline and spec-injection rules, which still directed RD Skills to a project `.cursor/skills` copy after v2.0.0 removed that mirror. They now point to the discovered `rd-*` Skill and the default `.agents/skills` roots, including the spec-check step. The validator rejects `.cursor/skills/` path references in Cursor rules, with a new Chinese-rule negative case (31 cases).
- Documented mixed-client Skill-root arrangements and their costs, using Codex, Claude Code, and Cursor Skills documentation checked on 2026-10-12. Also documented that Cursor MDC project rules are maintained separately from the shared project core and can overlap with an installed root `AGENTS.md`. Scoped the README and Claude installation "one shared source" statements to Codex and Claude Code. None of these arrangements was verified in a real Cursor client.
- Split the Codex user-configuration recipe from the project-configuration subsection in both installation guides, removed stray blank lines from the Claude adapter READMEs, and corrected the stale negative-case count in both READMEs.

## 2.0.0 - 2026-10-12

- **Breaking source-layout change:** Separate the shared project core into `rules/project/AGENTS.md.template`, rename distributable instructions with `.template` suffixes, and keep native installation destinations explicit. Consolidate the Chinese Cursor adapter under `zh-CN/cursor/` and add bilingual source-layout migration guidance.
- Remove four content-identical platform Skill mirrors. Keep only the English and Chinese canonical Skill trees; optional project/team and Claude local fallback installations, and claude.ai upload packaging, read those sources directly. Default project-rule recipes do not install another Skill copy; account caches remain read-only comparison targets. Cursor orchestration resolves the discovered Skill instead of a removed project-local link.
- Add selected local configuration entry points for Codex project settings, Claude user settings/project MCP, and Cursor user rules. Preserve native platform settings/MCP distinctions and opt-in activation; this does not introduce comprehensive CLI/cloud support, change personal installations, or upload account Skills.
- Update layout, installation, compatibility, and release documentation plus the applicable validation contracts and negative regressions. Preserve dated evidence with its historical paths and report new static/runtime results separately; real Cursor client selection remains unverified.

- Rechecked the nine registry version entries and installed Codex/Claude CLIs for release. The Sequential Thinking package now reports a `latest` tag of `1.0.0`; the former recorded value remains historical. This does not add the server to public examples or establish new MCP runtime coverage.

## 1.8.8 - 2026-10-11

- Added the approved English-only Instructions for Claude profile for the web account setting, preserving the self-reviewed text exactly. Documented character counts, product scope, setup sources, and unverified account-save and behavior boundaries; linked it from both READMEs. This does not change local-agent instructions or account settings.

## 1.8.7 - 2026-10-11

- Refined the ChatGPT web custom-instruction profile to the approved final revision after self-review, with a synchronized complete English reference. Restored explicit evidence, stakeholder, upstream-constraint, and failed-verification safeguards; clarified personal/project context versus general knowledge and continuing authorization; refreshed character counts and documented project-instruction scope. This changes only the web profile and its documentation, not local-agent instructions or verified account behavior.

## 1.8.6 - 2026-10-11

- Updated the ChatGPT web custom instructions with the user's approved Chinese text and a complete English reference translation. Added explicit innovation and bounded-trial guidance, accessible-context limits, and proportionate authorization/verification wording; refreshed independent character counts and the official field-limit check. This does not modify local-agent instructions or establish account-level behavior.
- Added English and Simplified Chinese Codex configuration guidance for instruction boundaries, optional memory models and contribution scope, Fast selection, Windows MXC, and verification/recovery. Linked it from the READMEs and standard configuration examples, with dated compatibility and pricing evidence; public configuration values, permission defaults, and local-agent instruction/Skill contracts remain unchanged.

## 1.8.5 - 2026-10-10

- Restored first-principles decomposition, task classification, and multi-perspective reasoning in the English and Simplified Chinese Claude global templates at the user's request, retaining the subagent restriction and removal of generic self-review. Corrected the R3 rationale and kept the 2026-10-09 A/B arms, outputs, and grades historical; they do not validate the current R1/R2-only combination. The [follow-up record](docs/evidence/claude-instruction-followup-2026-10-10.json) covers new probes separately.
- Corrected the claude.ai packaging script's no-change message to describe local last-synced copies rather than assert current account state. Updated the review's official-field evidence: Claude Code supports Skill `effort`, while claude.ai rejects unsupported upload fields, including `effort`.
- Added targeted checks in `rd-writing` for explicit hard length limits: establish the counting unit and scope, deterministically count the final text, recount after the last edit, and disclose unavailable counting instead of claiming a pass. Necessary English/Chinese platform mirrors follow the same contract, addressing the shared historical T2 word-limit failure.
- Refreshed the release metadata to Codex `0.162.1` after the installed CLI outgrew the `0.162.0` pin. The tagged schema, live schema, and existing snapshot are byte-identical; configuration values and permissions remain unchanged. Rechecked registry versions separately from historical runtime evidence.

## 1.8.4 - 2026-10-09

- Applied three Opus 5.5 guidance edits to the English and Simplified Chinese Claude global templates. Subagents are no longer used to verify the model's own work unless the user asks; the Pre-Output Self-Review section and three Thinking Methods items that prescribed thinking steps are removed. Codex and Cursor surfaces intentionally keep the previous text. The [review](docs/opus-5-5-instruction-review.md) records the guidance mapping and a 12-run Opus 5.5 `xhigh` A/B smoke test with [full responses](docs/evidence/opus-5-5-instruction-ab-2026-10-09.json). Every arm passed 28 of 29 frozen assertions and shared one T2 word-limit failure. This shows no detected regression, not an improvement.
- Added `scripts/package-claude-ai-skills.ps1` to package the nine Claude adapter RD Skills as claude.ai upload archives, with a `-Changed` mode that packages only Skills missing from or different from the copies Claude Code synced from the account. Because claude.ai rewrites `SKILL.md` frontmatter layout on upload, the comparison checks `name` and `description` by value and other content byte for byte. Documented the upload path and the one-source rule for project, personal, and account-synced copies in the English and Chinese Claude adapter READMEs, and made the project adapter's Skill-source line hold for both project and account installation. One English upload was confirmed current through the synced copies; same-name replacement and sync latency were not measured.
- Recorded a 2026-10-09 [nested Skill override probe](docs/evidence/claude-nested-skill-overrides-2026-10-09.json) in the compatibility notes. During source maintenance, a bare `skillOverrides` key set to `off`, paired with the `anthropic-skills:` name set to `on`, hid the Claude adapters' nested `rd-*` Skills and kept the account-synced copies; directory-qualified keys alone and a bare key alone failed. The repository does not commit the override.

## 1.8.3 - 2026-10-09

- Narrowed delivery orchestration and dependent-Skill routing, reused valid writing evidence and stage context, scoped design reads and gates, and merged the inconsistent requirements acceptance checks. Independent blocking questions can be batched while existing authorization, sensitive-operation safeguards, artifact approval boundaries, and required validation remain in force.
- Clarified direct primary-source retrieval, decision-record placement, and proportionate guidance for read-only commands across the applicable English/Chinese and platform surfaces. The initial scope added four output cases and three trigger cases per canonical language tree, reaching 55 output and 81 trigger definitions at that stage; these definitions are not model-execution results. A [bounded six-scenario subagent smoke check](docs/evidence/instruction-scope-smoke-2026-10-09.json) preceded mirror synchronization; it does not establish native discovery or cross-client reliability.
- Completed the research-routing condition across six other specialist Skills, narrowed the research description while retaining single-material-claim research, scoped the solution security gate, and clarified reuse of unchanged passing gate results. Added three output and three trigger cases per canonical language tree (58 output and 84 trigger definitions at that stage). The [initial native follow-up preflight](docs/evidence/astra-instruction-followup-2026-10-09.json) discovered the probe entry but its read was rejected by execution policy; all twelve planned comparison calls were unexecuted at that point.
- Narrowed the remaining `rd-delivery` research-stage pointer and added a sufficient-evidence orchestration regression across six mirrors (59 output and 84 trigger definitions per canonical language). The [resumed read-only MXC preflight and twelve native comparison runs](docs/evidence/astra-instruction-resume-2026-10-09.json) retain first results and the original failure. Both variants met the response criteria; the material-gap requirements pair read extra ancestor/user instructions and is explicitly confounded. No causal behavior improvement, cross-client reliability, or efficiency benefit is claimed.

- Refreshed the release-only Codex schema baseline to `0.162.0`, corrected schema attribution, and rechecked registry versions. Public configuration values and permission defaults remain unchanged; historical client/runtime evidence retains its original scope.

## 1.8.2 - 2026-10-05

- Recorded a seven-upstream source follow-up and a fourteen-response paired pilot separating native Skill loading, semantic quality, and observed cost. Added four synthetic delivery/design regressions across six payload mirrors (51 canonical output definitions), refreshed attribution including the current OMX MIT license, and retained all first responses, grading, diagnostics, and causal limits. Equal observed assertion results leave Skill instructions, routing, permissions, and public model defaults unchanged.
- Checked the actual pilot package through a fresh artifact handoff and offline preparation of all fourteen prompts. Clarified exact manifest serialization with a verified export recipe while preserving the original evidence and separating preparation checks from new model or business results.
- Added a bilingual nine-role method-adoption map and a real current decision-brief exercise with one proxy reader. Retained both first responses, source review, costs, and unverified human/business boundaries. No material explanation defect justified another sample, new eval, or Skill-instruction expansion.
- Recorded a subsequent real requirement case with two repaired acceptance ambiguities and authorized local HTTP/browser verification. Added a sanitized evidence summary while retaining the inconclusive result of both timed-out comparison calls. Adopted the worked example without changing Skill instructions, routing, or the 51 canonical output definitions per language.

## 1.8.1 - 2026-10-05

- Added contextual opportunity seeking, stage-appropriate recommendation strength, adaptable workflow coverage, and bounded subagent task contracts across shared conduct and applicable RD workflows. Synchronized language/platform mirrors and added three synthetic output cases; the forward-looking RD record preserves the bounded two-model comparison, fixture correction, independent review, and native-behavior limits.
- Removed the retired personality setting from bilingual Codex examples and clarified that explorer descriptions do not enforce sandbox permissions. Added a bounded configuration/Skill follow-up with a six-case metadata comparison and twelve supplied-text model samples, preserving failures, presentation differences, and native-execution limits. That earlier follow-up left shared RD Skill bodies unchanged; the later instruction changes are listed above. Public model defaults remain unchanged.

## 1.8.0 - 2026-10-02

- Guarded existing Claude project and user-level destinations before copying, retained 52 isolated Git Bash installation checks, synchronized the schema README version, and labeled historical Jev validation counts explicitly during release review.
- Added bilingual Claude tool-output hygiene to the existing governance regression and retained measured Chinese CLI routing evidence, including UTF-8 capture/scoring failures and their correction; routing defaults remain unchanged.
- Retained two bounded post-integration Codex behavior checks, including a false automatic approval-status flag and its text-grounded disposition; no reliability or causal improvement claim is made.
- Preserved material-decision clarification and routine reversible-choice guidance in the shared project core while retaining thin Claude adapters during worktree integration.
- Tightened the ChatGPT web custom-instruction profile and its Simplified Chinese mirror to clarify ambiguous professional deliverables, condition evidence reuse on valid sources and premises, and require risk-proportionate verification and rollback guidance for commands and configuration; refreshed both character counts without claiming web behavior validation.
- Reject malformed Jev response object shapes with sanitized partial evidence; added offline regressions and preserve the hash-matched historical runner without rerunning or relabeling API results.
- Added an optional standard-library Jev pilot runner, offline regression checks, bilingual usage/reporting guidance, and reproducible API/review evidence over 22 retained synthetic responses. Preserved one high-confidence false positive; no default dependency, Skill routing, permission, or release-gate change is made.
- Preserved the Oct 1 smoke chronology and authentication blocks, added an unhinted multi-output routing case across six mirrors, supplemented bounded Claude research/operations and self-review rules, and documented permission-version and NotebookEdit boundaries.
- Confined Bash installation exits to subshells, added native PowerShell project instructions, and added source-maintainer template exclusions after a reproduced loading probe; validator negatives now total 24.
- Retained a sanitized five-attempt native routing smoke record: four loading checks passed, one Codex orchestration attempt timed out; preserve inherited-context and output-quality limits.
- Fixed the Claude shared-core installation boundary for existing overrides and empty import targets, added request-content and installation negative regressions (22 total), and added a multi-output non-orchestration trigger case across six Skill mirrors. Removed stale mirror exceptions, made the English Claude global template language-neutral, and distinguished deliberate memory edits from automatic generation without changing memory settings or verbosity.
- Refreshed the offline Codex schema to `0.160.0` after byte equality with the tagged and live official copies; preserved the historical `0.155.1` evaluations and the current configuration choices.
- Made `codex/project/AGENTS.md` (and its Simplified Chinese mirror) the shared project core for every agent and reduced both Claude Code project `CLAUDE.md` files to thin v7 adapters that import it with `@AGENTS.md` and keep only Claude Code-specific guidance. Moved the remaining shared rules (validation entry-point discovery, approved-decision persistence, evidence-tool and MCP routing, AI capability/readiness distinction, and preservation of user intent and clause wording) into the shared core; added a validator contract and negative case for the import, and updated installation, adapter, README, and compatibility documentation. Claude Code `AGENTS.md` behavior was checked against the memory documentation on 2026-10-01, not on an installed CLI.
- Changed the `rd-delivery` boundary from named invocation to request content: the Skill is used when the request explicitly asks for multi-stage or multi-document orchestration, phase gates, or a durable cross-session handoff, without requiring the Skill to be named; complexity or multiple outputs alone do not qualify. Removed `policy.allow_implicit_invocation: false` and the Claude/Cursor `disable-model-invocation: true` flags so all platform copies are identical, and updated the validator, its negative case, and the affected documentation.
- Brought the English and Simplified Chinese Claude Code global directives (v7) closer to the Codex global contract: external content is evidence rather than authorization, commands and configurations state verification and rollback, unloaded Skills are not claimed, deterministic failures are not blindly retried, implementation discipline is explicit, and evidence and handoffs are redacted. Scoped the thinking methods to complex, disputed, or high-impact work and limited confidence labels to uncertain, contested, predictive, or inferential conclusions.
- Changed the Claude Code project secret-read denials from working-directory-anchored `./` patterns to any-depth patterns, added confirmation for uncommitted-work-discarding Git commands in Bash and PowerShell, and extended the validator and its negative case accordingly. Permission semantics were checked against the Claude Code permissions documentation on 2026-10-01; runtime interception was not exercised.

## 1.7.7 - 2026-09-20

- Refreshed Codex schema provenance to `0.155.1` after verifying unchanged schema bytes against both the tagged source and live endpoint; refreshed registry observations without changing public configuration behavior.
- Added a bilingual high/high Sol and Astra evaluation of the final shared instructions, retaining failed assertions, a separate diagnostic repeat, and four blocked native attempts without claiming full compatibility.
- Added a synthetic concise decision-brief regression to `rd-writing` and all language/platform mirrors; each canonical language tree now contains 44 output cases. Skill bodies, descriptions, invocation policies, and personal settings remain unchanged.
- Added source-linked explanations when Skill or project instructions block requested work, preserving authorization boundaries across English, Chinese, Codex, Claude, and Cursor conduct templates.
- Added an optional task authority/completion prompt block and a focused baseline/candidate comparison record without changing Skill bodies, descriptions, invocation policies, permissions, or the evaluation framework.

## 1.7.6 - 2026-09-18

- Removed two retired personal instruction drafts from the distributed tree and ignored their local paths; existing Git history remains unchanged.
- Standardized unversioned Context7 package arguments across Codex/Cursor examples, documented the separate historical test baseline, and updated positive/negative package-policy validation.
- Refreshed npm registry snapshots and the Codex configuration schema to `0.155.0` after reviewing additive upstream changes; public configuration behavior remains unchanged apart from the approved Context7 package policy.
- Scoped personalized custom instructions to ChatGPT on the web, synchronized the approved Business-sized Chinese profile with its complete English reference translation, and clarified character limits, paste suitability, and evidence boundaries in both guides and README links.
- Conditioned routine clarification and research depth on material decisions and relevant evidence, tightened completion reporting for failed required gates, and replaced duplicated orchestration instructions with links to the owning Skill across the English, Chinese, Claude and Cursor surfaces.
- Separated proposal completion from stakeholder approval, scoped requirements convergence to the requested change, and added a bounded-revision output eval plus approval-status assertions without changing Skill invocation policies.
- Corrected the optional clarification preamble to handle one or more blocking decisions and updated its validator regression to reject the former single-blocker condition.

## 1.7.5 - 2026-09-17

- Added six fixture-backed output evals for `rd-research` and `rd-review`, with normal/pressure and unauthorized/authorized pairs covering evidence overclaims, prior-reviewer anchoring, and acceptance changes; synchronized English, Chinese, Claude and Cursor eval payloads. Each canonical language tree now contains 42 output cases, including the previously released `rd-design` addition.
- Recorded a bounded Chinese Codex CLI text-behavior pilot with six complete responses, input hashes and 24/24 task-agent-graded assertions. Existing Skill bodies and descriptions remain unchanged; no native-discovery, cross-client, causal-improvement or production claim is made.
- Clarified that eval 8 increases the allowed completion time from 60 to 120 seconds, and pinned the original pilot input snapshot so later expected-output wording changes do not overwrite historical evidence.
- Added bilingual gradual-adoption guidance, a selective-adoption assessment, MIT-source attribution and README acknowledgements for Addy Osmani Agent Skills pinned at `be4e44a9fbc5e8df0beaefadbb28bd22ee61cc39`, without importing upstream code, hooks, routing tools or a new Skill.

## 1.7.4 - 2026-09-17

- Strengthened `rd-design` revisions so ambiguous prose is separated into approved semantic clarification or an exact missing contract before the agent adds responsibilities, sequencing, success semantics, or recovery behavior.
- Added bilingual, platform-mirrored quality gates and output evals for precise domain language, evidence-backed causal and conditional relationships, context-aware wording changes, safe search and mechanical replacement, and preservation of identifiers, normative force, and traceability.

## 1.7.3 - 2026-09-16

- Added English and Simplified Chinese README acknowledgements for seven public inspiration repositories already covered by `ATTRIBUTION.md`, while preserving the no-endorsement, no-partnership, no-compatibility, and no-direct-derivation boundary.
- Added the LINUX DO community acknowledgement and link as the final acknowledgement item so the public project explicitly recognizes the community for open-source discussion and promotion.

## 1.7.2 - 2026-09-16

- Clarified the English and Simplified Chinese README Skill taxonomy as eight independently usable specialist Skills plus the explicit-only `rd-delivery` orchestrator, eliminating the apparent mismatch between the stated count and the nine-row table.
- Corrected the English and Simplified Chinese Cursor adapter README evidence dates by separating the 2026-09-16 Rules and Skills documentation check from the retained 2026-09-11 MCP documentation check and installed-version observation.

## 1.7.1 - 2026-09-16

- Refreshed registry latest snapshots in the compatibility documents: `@anthropic-ai/claude-code` `2.1.273` and `@upstash/context7-mcp` `4.1.1` observed on 2026-09-16; `@openai/codex` remains `0.154.0`. Tested versions and the Context7 `4.0.2` pins are unchanged.
- Documented Cursor's multi-source Skill discovery risk across `.agents`, `.cursor`, `.claude`, and `.codex` roots, including the common shared-Skill plus Cursor-adapter combination, the absence of documented same-name precedence or deduplication, and the always-on behavior of `CLAUDE.md`; added the guidance to the Cursor adapter README, installation guide, and compatibility document with their Simplified Chinese mirrors.
- Clarified in the root maintainer `AGENTS.md` that repository authority intent does not prove editor runtime precedence, and recorded the 2026-09-16 Cursor instruction-loading observation as an unresolved, not independently reproduced compatibility risk rather than a universal loading contract.

## 1.7.0 - 2026-09-13

- Clarified that existing authorization remains effective until scope, risk, or external effects materially change, while retaining approval gates for new external actions.
- Distinguished a primary controlling deliverable from explicitly requested companion outputs and reduced the global RD fallback to routing pointers plus a minimal evidence and authority contract.
- Tightened the personal research, Skill-installation, and handoff workflows so durable files, background delegation, global installation, and task-management actions follow explicit scope and canonical output rules.
- Added least-privilege guidance for external communication, account actions, and personal data access, with read-only, local, and redacted evidence preferred when sufficient.
- Added authorization, recoverability, running-task, recovery-path, and evidence-chain checks for deletion and cleanup across Codex, Claude Code, and Cursor global guidance.

## 1.6.0 - 2026-09-07

- Tuned the Codex runtime and public instruction templates for GPT-6 Astra: unified the personal main and subagent model selection, set main, plan, and subagent reasoning effort to `medium`, reduced developer instructions to three Astra-specific controls, and made low-risk discovery guidance conditional instead of ritualized.
- Aligned the standard Codex examples with the reviewed runtime contract for live search, Memories, full shell inheritance, and default sensitive-name exclusions; added a pinned Codex `0.153.4` configuration schema, offline four-file semantic validation, and a networked release gate for live-schema comparison, CLI-version matching, and isolated strict loads.
- Reduced Cursor's always-on Project Rules from ten to one, made the other nine trigger-oriented, removed arbitrary effort/line/time thresholds and duplicated Skill completion tables, and aligned Claude/Cursor anti-anchoring, context-repair, and approval-gated durable-guidance rules.
- Added Windows PowerShell confirmation patterns and common `.env` read denials to both Claude Code project settings, reduced the Cursor MCP example to Context7 only, refreshed compatibility evidence, and expanded validator regression coverage from sixteen to twenty cases.
- Corrected GSD attribution to identify `open-gsd/gsd-core` as the current canonical repository while retaining `gsd-build/get-shit-done` as an archived historical reference; recorded licenses for the vendored schema and new validation dependencies.

## 1.5.0 - 2026-08-31

- Added a bilingual value-first execution contract across the repository maintainer rules, Codex global/project templates, Claude adapters, and Cursor rules; upgraded Codex global templates to v7.8 and Claude global templates to v5; made `rd-delivery` stage-aware with layered verification and re-entry conditions; and extended the negative runner from fourteen to sixteen cases.
- Added an English canonical and Simplified Chinese copy-ready personalized custom-instructions guide for system-design and architecture work, with explicit boundaries between personal preferences, Codex `AGENTS.md`, project rules, and detailed Skills.
- Documented read-only Codex instruction-source verification and an advanced, bounded Claude Code `@AGENTS.md` import option in the English and Simplified Chinese installation and adapter guides.
- Added a bounded external-stakeholder questionnaire mode to `rd-requirement`, pointer-only orchestration in `rd-delivery`, bilingual and platform-mirrored trigger/output evals, and parser-backed Skill YAML/reference validation with two new negative regressions.

## 1.4.0 - 2026-08-24

- Corrected Claude Code permission and attribution semantics, platform-specific prompt prefixes, Cursor `.mdc` guidance and per-server MCP credential isolation, overwrite-safe Unix Skill installation, bilingual adapter instructions, and current registry snapshots; added executable regression coverage for these platform contracts.
- Upgraded the public Codex global `AGENTS.md` templates to v7.7 with evidence-driven execution-efficiency and context-hygiene controls for long-running waits, locally aggregated output, complete final gates, deterministic-failure analysis, and bounded flaky retries; added bilingual validator markers and a dedicated negative regression without changing Codex configuration or other platform adapters.

## 1.3.0 - 2026-08-23

- Upgraded the public Codex global `AGENTS.md` templates to v7.6 with existing-behavior, compatibility, and instruction-surface protection plus validation-failure attribution; extended bilingual validator and negative coverage, corrected the documented negative runner to twelve cases, and preserved the project, RD Skill, Claude, and Cursor scope boundaries.

## 1.2.0 - 2026-08-21

- Upgraded the public Codex global `AGENTS.md` templates to v7.5 with bounded implementation discipline for speculative abstractions, meaningful duplication, naming, trust-boundary validation, boolean modes, implementation comments, iterative clarification, and uncommitted-work protection; added bilingual validator enforcement and negative coverage without expanding project or RD Skill coding scope.

## 1.1.0 - 2026-08-18

- Added a repository-maintainer root `AGENTS.md`, revision-aware context reuse and dynamic-state boundaries across project adapters, a greenfield open-source research/solution-gate prompt, and an optional high-impact bidirectional-argument clarification preamble with negative validator coverage.
- Corrected Simplified Chinese lifecycle-state, authority, source-of-truth, standards-routing, and platform-installation semantics across canonical Skills, evals, prompts, documentation, and maintained adapter mirrors.
- Updated the public global AGENTS templates to v7.4 and synchronized Codex, Claude, Cursor, English, and Simplified Chinese evidence-state and no-change controls.
- Upgraded the Context7 example baseline to `4.0.2`, documented the bounded stdio probe, and added cross-file version enforcement.
- Added RD research/review evals for evidence-layer boundaries and supported no-change outcomes, plus a real negative regression suite for the repository validator.
- Defined `.tmp/local/` as ignored task-local storage and added a bilingual maintainer release checklist without expanding RD Skill scope.

## 1.0.0 - 2026-08-07

- Created the public `codex-three-layer-delivery` repository layout.
- Split safe Codex configuration from full-access advanced configuration.
- Added GitHub-ready metadata: license, contribution guide, security policy, attribution notes, compatibility docs, and validation script.
- Included Codex rules, Cursor adapter, Claude Code adapter, Simplified Chinese translation pack, and nine `rd-*` skills.
- Added an English Cursor adapter under `cursor/project/`, aligned Cursor `zh-CN` with the same opt-in MCP posture, and documented the official Cursor Rules, Skills, and MCP baseline.
- Refreshed public Codex configuration examples for `codex-cli 0.147.0` and restored the personal normal/high reasoning-profile split.
- Reduced project `AGENTS.md` to a stable control plane and strengthened the nine RD Skills, mirrored evaluations, authority boundaries, and sensitive-evidence handling using the audited `mattpocock/skills v1.2.3` mechanisms.
- Upgraded global `AGENTS.md` to v7.2 with independent always-on truthfulness, response-mode, context-health, pre-output-review, output-contract, Skill-routing, and minimum-RD controls; added a verified PowerShell installer with backup, rollback, staging, and exact-tree validation for all nine RD Skills.
