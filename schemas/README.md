# Vendored Schemas

`codex-config.schema.json` is an offline snapshot of the OpenAI Codex
configuration schema. It is pinned to Codex `0.167.0`; provenance, retrieval
date, size, and digest are recorded in `codex-config.schema.meta.json`.

The ordinary repository validator uses this snapshot so configuration checks
are deterministic and do not require network access. The release-only
`scripts/validate-release.ps1` gate additionally downloads the current official
schema, verifies that it still matches the tracked snapshot, validates all six
public examples against the live copy, checks the installed Codex version, and
strict-loads each example from an isolated temporary `CODEX_HOME`.

Schema drift is a release blocker, not an instruction to replace the snapshot
silently. Review the upstream change, update the examples and metadata together,
run the ordinary and release gates, and record the compatibility decision.

The schema originates from the Apache-2.0-licensed
[`openai/codex`](https://github.com/openai/codex) project. The upstream Apache
license is reproduced in `LICENSE-APACHE-2.0.txt`; the applicable source notice
is in `NOTICE`. See `ATTRIBUTION.md` for repository attribution.
