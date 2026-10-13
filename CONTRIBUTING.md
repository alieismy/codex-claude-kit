# Contributing

Contributions are welcome when they improve the kit without weakening its core constraints: evidence discipline, minimal-change execution, safety defaults, and final verification.

## Contribution Types

- maintainer-rule improvements for the root `AGENTS.md`, or distributable-rule improvements for `codex/global/AGENTS.md.template` and `rules/project/AGENTS.md.template`;
- skill improvements under `skills/rd-*`;
- Claude Code adapter and prompt updates under `claude/`;
- Claude web/desktop guidance and ChatGPT web custom-instruction updates within their documented product scopes;
- documentation updates under `docs/`;
- compatibility updates for Codex CLI or MCP packages;
- Codex configuration schema, example, or validation-gate updates.

## Required Checks

Before opening a pull request:

```powershell
python -m pip install -r requirements-validation.txt
pwsh ./scripts/validate.ps1
pwsh ./scripts/test-validator.ps1
git diff --check
```

Use Python 3.9+ and install the pinned validation dependencies in an isolated environment. The PowerShell gate invokes parser-backed Skill YAML/reference checks and offline Codex TOML/JSON-Schema validation; a missing parser dependency is a failed check, not an optional skip.

When changing the Codex schema snapshot, public config examples, or their compatibility claims, also run `pwsh ./scripts/validate-release.ps1` in an environment with network access and the matching Codex CLI. This dynamic release gate does not replace the ordinary repository checks.

If you change MCP package versions, update `docs/compatibility.md` with:

- package name;
- tested version;
- verification date;
- highest evidence state actually reached and unverified client/runtime layers;
- whether the server is enabled by default.

Use `.tmp/local/` for task-local clones, downloads, logs, and probes. Do not place durable artifacts or the only copy of evidence there. Files already tracked directly under `.tmp/` are not implicitly disposable.

## Rules and Skills Guidelines

- Keep rules concrete and verifiable.
- Do not add broad personality text that does not affect execution.
- Do not hardcode personal paths, tokens, accounts, or private relay URLs.
- Do not use `@latest` for npm-based MCP examples.
- Keep skill descriptions trigger-oriented: start with `Use when...` when possible.
- If a rule compensates for a temporary model limitation, state its applicability boundary and reassess it when model/platform changes, conflicting behavior, or failure evidence indicates staleness; do not assign an arbitrary calendar interval.
- Add a generalized validator, broad test matrix, security-hardening track, or framework only when justified by approved scope, an observed reproducible failure, an authoritative requirement, or a material risk.
- For rule, prompt, or Skill behavior changes, start with a focused changed-surface smoke test. Broaden to related regression and then a full platform matrix only when shared routing, public contracts, release scope, observed cross-surface risk, or an explicit request warrants it; required repository gates still apply before completion.

## Pull Request Summary

Please include:

- what changed;
- why it changed;
- files touched;
- validation performed;
- known risks or unverified areas.

Repository publication follows the [maintainer release checklist](docs/release-checklist.md). Pull-request approval does not by itself authorize merge, tag, or public Release creation.
