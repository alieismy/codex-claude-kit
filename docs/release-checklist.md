# Maintainer Release Checklist

This checklist governs publication of this repository itself. It is not an RD Skill workflow and does not expand the Skills into coding, test execution, deployment, or release-operation deliverables for users.

Commit, push, pull-request mutation, merge, tag creation, and GitHub Release publication are external writes. Perform them only with explicit authority for the specific release.

## 1. Fix the Release Identity and Authority

- [ ] Record the intended version, release title, target branch, target commit, release type, and whether it is a draft or prerelease.
- [ ] Confirm who authorized commit, push, merge, tag, assets, and public Release creation.
- [ ] Define the included change set and explicitly exclude unrelated local work.
- [ ] Confirm that `CHANGELOG.md`, compatibility claims, attribution, license, and security notes cover the intended release.
- [ ] Do not infer publication authority from an earlier edit or validation request.

## 2. Snapshot the Exact Repository State

Run and retain the relevant output:

```powershell
git rev-parse --show-toplevel
git branch --show-current
git status --short --branch
git remote -v
git log -1 --oneline --decorate
git diff --name-status
git diff --cached --name-status
git status --short --ignored -- .tmp/local/
```

- [ ] Account separately for modified, deleted, untracked, ignored, and staged paths.
- [ ] Redact credentials or nonessential private identifiers before retaining or sharing remote URLs and status output.
- [ ] Verify that staged content is exactly the intended release scope; do not rely on a clean summary alone.
- [ ] Inspect `.tmp/local/` and other task-local areas. They are not release artifacts and must not contain the only copy of required evidence or recovery data.
- [ ] Preserve unrelated user changes. Do not clean or reset them merely to simplify the release.

## 3. Recheck Drift-Prone Facts and Evidence Boundaries

- [ ] Re-query current package/CLI versions and inspect the actually installed runtime when compatibility claims changed.
- [ ] Record version, date, platform, configuration, command, expected result, observed result, and limitation for every new compatibility claim.
- [ ] Keep documentation claims, source implementation, static configuration, final generated/effective configuration, runtime state, and business/production acceptance separate.
- [ ] Treat “no change required” as valid when current evidence does not justify a version or behavior change.
- [ ] Ensure all Codex/Cursor Context7 examples use the same unversioned package name and bilingual compatibility records agree on historical tested and current registry versions.
- [ ] Confirm the tracked Codex schema metadata identifies its version, tagged source, live source, retrieval date, byte length, SHA-256 digest, and license.
- [ ] Verify English/Chinese semantics and Codex/Claude/Cursor adapter parity while preserving documented platform differences.

## 4. Inspect Content and Supply-Chain Hygiene

- [ ] Search the final diff for credentials, tokens, private endpoints, cookies, connection strings, personal paths, machine identifiers, and nonessential infrastructure data.
- [ ] Confirm that generated files, caches, dependency directories, coverage output, local logs, and downloaded packages are excluded unless deliberately released.
- [ ] Confirm that every new dependency, external source, copied asset, and attribution has a documented reason and license basis.
- [ ] Check links, version references, document status, authority pointers, and release asset names.
- [ ] Verify the shared project core, `.template` sources, and all Chinese platform directories; native installation names must not retain template suffixes or activate source directories.
- [ ] Confirm Skills are maintained only under `skills/` and `zh-CN/skills/`; optional installation and claude.ai packaging read those sources. Account caches are read-only comparison targets, never editable packaging sources.
- [ ] Check former paths against [layout migration](layout-migration.md), preserving historical evidence paths. Keep rules, settings/MCP, and Skills independent; public installation must not depend on a maintainer's global state.

- [ ] Review the final diff for unrelated formatting, broken references, duplicate authority records, stale mirrors, and local-only assumptions.

## 5. Run the Repository Gates

Required local gates before staging:

```powershell
python -m pip install -r requirements-validation.txt
pwsh ./scripts/validate.ps1
pwsh ./scripts/test-validator.ps1
git diff --check
```

Required networked and runtime release gate:

```powershell
pwsh ./scripts/validate-release.ps1
```

- [ ] Record each command, exit code, material output, and environment.
- [ ] If a diagnostic command itself fails, repair and rerun it; a parser, quoting, network, or tool failure is not a passed check.
- [ ] When Skills change and the official Skill validator is available, run it against all nine English and nine Chinese canonical Skills with UTF-8 enabled and record the exact validator source/version.
- [ ] Use Python 3.9+ with the pinned validation dependency; parse changed JSON, YAML, and TOML with an appropriate real parser, and do not equate visual inspection with parser acceptance.
- [ ] Confirm that the release gate matched the current official Codex schema to the tracked snapshot, validated every maintained public user/project example against the live schema, matched the installed Codex CLI to the schema version, and completed the maintained inventory of isolated strict-load checks.
- [ ] Explain every skipped, unavailable, flaky, or environment-limited check and constrain release claims accordingly.

## 6. Commit and Pull Request

- [ ] Explicitly stage only the approved path allowlist; in a mixed worktree, do not use a broad `git add .`.
- [ ] After staging, run `git diff --cached --name-status`, `git diff --cached --stat`, `git diff --cached --check`, and inspect the full `git diff --cached`. A pre-staging cached check is not evidence for newly staged or previously untracked files.
- [ ] Keep each commit to one logical change and use a Conventional Commit with an imperative subject; include a Jira key only when the project actually uses one and a real key was provided.
- [ ] Push a review branch, not the default branch, unless the user explicitly authorized a different workflow.
- [ ] Confirm the pull request base/head, commit list, file count, generated diff, and release notes.
- [ ] Wait for required checks to finish and record their actual output.
- [ ] Distinguish a green status from substantive review coverage. Record skipped reviews, file limits, exclusions, or checks that only validated workflow execution.
- [ ] Record the selected merge strategy and exact resulting merge commit.

## 7. Tag and Publish

Before creating a tag:

```powershell
git fetch --tags origin
git tag --list "v*"
git show --no-patch --format=fuller <merge-commit>
```

- [ ] Confirm the version does not collide with an existing local or remote tag/Release.
- [ ] Create an annotated tag at the exact reviewed merge commit, then dereference it:

```powershell
git tag -a vX.Y.Z <merge-commit> -m "vX.Y.Z"
git cat-file -t vX.Y.Z
git rev-parse vX.Y.Z
git rev-parse "vX.Y.Z^{}"
```

- [ ] Confirm `git cat-file -t` reports `tag`, record the tag-object ID, then compare the dereferenced tag target with the approved merge commit before push.
- [ ] Push the tag and create the GitHub Release only after explicit publication authority.
- [ ] When using GitHub CLI, prefer `gh release create ... --verify-tag` so Release creation fails instead of silently creating a missing remote tag.
- [ ] Set and verify Draft/Prerelease state intentionally; do not accept tool defaults without checking.
- [ ] Attach only reviewed assets. Record file names, sizes, sources, and SHA-256 checksums where assets are supplied.
- [ ] Do not describe GitHub-generated source archives as separately validated assets unless they were actually downloaded and checked.

## 8. Verify the Remote Result

```powershell
gh release view vX.Y.Z --json tagName,name,isDraft,isPrerelease,targetCommitish,url,assets
git ls-remote origin "refs/tags/vX.Y.Z" "refs/tags/vX.Y.Z^{}"
```

- [ ] Verify Release name, URL, target branch/commit, Draft/Prerelease state, assets, and checksums.
- [ ] Verify that the remote annotated tag dereferences to the exact reviewed merge commit.
- [ ] Verify the pull request is merged and required checks reached their final state.
- [ ] Record residual risks and evidence not obtained, including real client/runtime acceptance not covered by repository checks.

## 9. Correction and Immutability Rule

- [ ] Before public publication, correct an erroneous draft or unpublished local tag only within explicit authority and record what changed.
- [ ] After a tag/Release is public, never move or silently replace it. Publish a new patch release or mark the old release as superseded with a clear correction record.
- [ ] Never force-push or rewrite shared history as a release shortcut.
- [ ] If a secret may have been published, stop normal release work, revoke/rotate it, preserve the incident evidence safely, and follow the repository security process.

## Release Evidence Record

The final maintainer report must identify:

- release version, target branch, reviewed commit, tag object, and dereferenced tag target;
- exact changed/staged scope and excluded local work;
- local gates, remote checks, review coverage, skipped checks, and reasons;
- compatibility evidence and the highest evidence state actually reached;
- Release URL, Draft/Prerelease state, assets, and checksums;
- unresolved risks, rollback/correction posture, approver, and publication time.

The release is complete only when the remote tag and Release are verified against the reviewed commit and the report distinguishes verified facts from unverified runtime or production behavior.
