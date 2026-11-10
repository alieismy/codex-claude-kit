# Attribution

This project is an independent synthesis of document-delivery, system-design, and agent-operation patterns. It is not affiliated with OpenAI, Cursor, Anthropic, or any referenced framework.

## Inspiration Categories

The framework is influenced by these broad public document and agent-operation patterns:

- spec-driven development and explicit project specification loading;
- verification-first document delivery;
- dual-stage review gates;
- context engineering and search-before-build discipline;
- role-separated requirements, feasibility, design, standards, and document review workflows;
- prompt-injection trust-boundary separation;
- deterministic checks for tasks that should not rely on prompt reminders.

## Inspiration References

The following repositories were reviewed as public inspiration references. They are listed for transparency and comparison. This project does not claim upstream endorsement, compatibility, or direct derivation from these repositories.

License data was checked through GitHub repository metadata and canonical repository files. The 2026-10-05 follow-up refreshed the seven references identified below; other rows retain their earlier observation scope. The [follow-up and bounded pilot](docs/upstream-learning-pilot.md) records source pins, independently expressed methods, execution evidence, and adoption limits. The [professional-scenario follow-up](docs/rd-method-adoption.md) maps those methods to the nine RD responsibilities and applies a reader-use observation to one actual decision brief; proxy results do not establish human or cross-domain benefits. Re-check before making any stronger claim than the recorded scoped use.

| Reference | Canonical URL | License observed | Use in this project |
|---|---|---|---|
| Addy Osmani Agent Skills | https://github.com/addyosmani/agent-skills | MIT | Reviewed Commit `be4e44a9fbc5e8df0beaefadbb28bd22ee61cc39` on 2026-09-17. Pressure-case evaluation, independent finding verification, constraint-change scrutiny, and gradual adoption informed independently written document-delivery fixtures and guidance; see [the earlier pilot](docs/agent-skills-pilot.md). The 2026-10-05 follow-up pinned `main@1401c8b8030e023baeebb31781a6653fe8e93026` and informed the separation of native loading, output quality, and paired cost observations. No upstream Skill body or executable code was copied. |
| Andrej Karpathy Skills | https://github.com/multica-ai/andrej-karpathy-skills | No license detected by GitHub API | Broad inspiration only; do not copy text/code without separate permission or license confirmation. |
| BMAD Method | https://github.com/bmad-code-org/BMAD-METHOD | MIT text with trademark notice | Broad inspiration only; preserve trademark separation and do not imply endorsement. |
| CodeStable | https://github.com/liuzhengdongfortest/CodeStable | No license detected by GitHub API | Broad inspiration only; do not copy text/code without separate permission or license confirmation. |
| Everything Claude Code / ECC | https://github.com/affaan-m/ECC | MIT | Broad inspiration only. |
| flow-kit | https://github.com/rihebty/flow-kit | MIT | Broad inspiration only. |
| GSD Core | https://github.com/open-gsd/gsd-core | MIT | Current canonical GSD repository; reviewed default branch `next` at Commit `97ce61dee26c526714901b3af54bfed79de18587` on 2026-09-04. The 2026-10-05 follow-up pinned `next@a1f3db98cbe16cc5aa2b0482a5e4f664086f44e7`; distinctions between absent, unreadable, and checked evidence informed independently written delivery fixtures and a bounded method comparison. No upstream gate implementation was copied. |
| get-shit-done (archived) | https://github.com/gsd-build/get-shit-done | MIT | Archived historical reference retained for provenance; broad inspiration only. |
| gstack | https://github.com/garrytan/gstack | MIT | The 2026-10-05 follow-up pinned `main@857466ff8b93c0575bc9e46cf2838d1962077d8f`. Observing current workarounds and testing a decision-changing prototype question were considered as problem-selection methods; this pilot does not establish real-user workflow benefits. No upstream workflow body or executable code was copied. |
| Matt Pocock Skills | https://github.com/mattpocock/skills | MIT | The initial review used Commit `2ab958093e83e0ec752e6c1c5932da465bf23e0c`; the 2026-08-07 follow-up pinned release `v1.2.3` to Commit `6acc160e4e0cd062dbbbd7a1b26ae92855edf07e`; the 2026-08-31 source follow-up inspected unreleased `main` at Commit `6654f6b60cd9d5be8b54c6fafe44346dabeb3b76`. The review covered small composable Skills, invocation boundaries, completion criteria, primary-source research, single-source artifact maps, context-load discipline, and external-stakeholder questionnaires. The 2026-10-05 follow-up pinned `v1.3.1` / `main@24fe0ef7737efae15c87225755e9f6f5965e4888` and examined caller knowledge obligations and cross-artifact domain meaning. Compatible mechanisms and fixtures were independently expressed in document-delivery terms; upstream coding workflows were not copied. |
| oh-my-codex | https://github.com/Yeachan-Heo/oh-my-codex | MIT | The earlier observation reported no license detected by GitHub API. The 2026-10-05 follow-up verified an MIT `LICENSE` at `main@1dcf51359f3caeeebfed0bcbeea867ff0838d533`. Example/counterexample elicitation and distinct verification modes were considered; no runtime, scoring formula, Skill body, or executable code was copied. |
| OpenSpec | https://github.com/Fission-AI/OpenSpec | MIT | Broad inspiration only. |
| Rlues | https://github.com/WenJunDuan/Rlues | No applicable license found in the inspected scope | The 2026-10-05 follow-up examined `vibeCoding/athena` at `main@ac99fc55b44aab8622a0f7b784bccea1f431dffb`. Input-bound evidence and rule-retirement reasoning informed independently expressed pilot methods only. No upstream text, hooks, or executable code was copied; further copying requires separate permission or license confirmation. |
| spec-kit | https://github.com/github/spec-kit | MIT | Broad inspiration only. |
| superpowers | https://github.com/obra/superpowers | MIT | Broad inspiration only. |
| Trellis | https://github.com/mindfold-ai/Trellis | AGPL-3.0; inspected package declares AGPL-3.0-only | The 2026-10-05 follow-up pinned `main@f089cb3286071199e84118dee86b6d76aab032f1`. Role-scoped context lists and visible partial/index-only reads informed independently written handoff fixtures and a bounded method comparison. No upstream context injector, directory model, or substantial protected expression was copied; further copying requires AGPL compatibility review. |
| MiniMax Skills | https://github.com/MiniMax-AI/skills | MIT | Broad inspiration only. |

## Validation Dependency

| Dependency | Canonical URL | License observed | Use in this project |
|---|---|---|---|
| PyYAML 6.0.3 | https://pyyaml.org/ | MIT | Pinned, non-runtime validation dependency used to parse Skill frontmatter and `agents/openai.yaml` with a real YAML parser. The repository does not vendor PyYAML source. |
| jsonschema 4.25.1 | https://github.com/python-jsonschema/jsonschema | MIT | Pinned, non-runtime validation dependency used to validate public Codex TOML examples against the tracked JSON Schema. The repository does not vendor jsonschema source. |
| tomli 2.4.1 | https://github.com/hukkin/tomli | MIT | Pinned fallback TOML parser for Python 3.9-3.10 validation environments. Python 3.11+ uses the standard-library `tomllib`; the repository does not vendor tomli source. |
| OpenAI Codex config schema 0.167.0 | https://github.com/openai/codex/blob/rust-v0.167.0/codex-rs/core/config.schema.json | Apache-2.0 | Vendored as an offline validation snapshot with source URL, retrieval date, byte length, SHA-256 metadata, applicable notice, and a copy of the Apache-2.0 license under `schemas/`. The release-only gate compares it with the current official schema before publication. |

## No Upstream Endorsement

References to external tools, frameworks, repositories, products, or documents are for attribution and comparison only. They do not imply endorsement, partnership, or compatibility guarantees.

## Maintainer Note

Before a public release claims detailed absorption from a named external framework or repository, verify:

- the canonical source URL;
- the source license;
- whether copied text, diagrams, or examples are present;
- whether the project name is a trademark or brand that needs clearer wording.

If that verification has not been performed, describe the influence as a general engineering pattern rather than a direct framework-derived feature.
