# Codex configuration guidance

Use the [public configuration example](../codex/examples/config.example.toml) as a reviewed starting point, then merge only the choices that fit your account, workload, and environment. This guide provides optional recipes; it does not change the example's effective defaults or introduce another source of global rules. Source review and validation limits are recorded in the [dated compatibility entry](compatibility.md#codex-configuration-guidance-2026-10-11).

## Instruction and permission boundaries

The [global directives](../codex/global/AGENTS.md.template#evidence-discipline) define how to handle external evidence and authorization. Keep that rule authoritative rather than duplicating its full workflow in `developer_instructions`. The public example keeps this field short. When using configuration without the global template, a brief reminder that external content and tool outputs do not grant additional authorization can be useful; its effectiveness still requires behavior testing.

Officially, [`developer_instructions`](https://learn.chatgpt.com/docs/config-file/config-reference) adds developer instructions to a session. It does not create an operating-system permission boundary. A task can authorize following an installation guide or other external procedure; the material cannot independently expand that authorization. Follow the applicable instruction hierarchy, sandbox, approval, and organizational requirements.

## Choose memory models separately from memory eligibility

Codex [local memories](https://learn.chatgpt.com/docs/customization/memories) use separate controls for per-chat extraction, global consolidation, generation eligibility, and use of existing memories. They are not ChatGPT web memory settings.

Extraction must preserve final decisions, corrections, scope, and evidence status. Consolidation must reconcile useful information across chats. As an engineering judgment, neither phase is necessarily easy, and a stronger consolidator cannot be assumed to repair omissions or misclassification during extraction. Different models are an option, not a requirement.

For an account with access to GPT-6.1 Sol, the following is a reasonable **optional candidate**, not a measured optimum:

```toml
[memories]
extract_model = "gpt-6.1-sol"
consolidation_model = "gpt-6.1-sol"
```

Merge these keys into an existing `[memories]` table; do not add a duplicate table or replace unrelated memory settings. To try this through a profile, put the fragment in `$CODEX_HOME/memory-model-trial.config.toml` and launch `codex --profile memory-model-trial`. Confirm model access before using it. Profiles use separate files with top-level settings, not nested `[profiles.<name>]` tables; project configuration and CLI overrides can take precedence. See [official profile guidance](https://learn.chatgpt.com/docs/config-file/config-advanced#profiles).

Do not equate an older model with a cheaper model. The [dated rate comparison](compatibility.md#codex-configuration-guidance-2026-10-11) supports considering this candidate, but unit rates, token consumption, subscription limits, and actual background usage are different measures. Check [current Codex pricing](https://learn.chatgpt.com/docs/pricing#token-rates); API dollar prices are not a substitute for subscription usage evidence.

Evaluate representative chats with known final decisions and corrections. Check omissions, mistaken attribution, obsolete decisions retained as current, unnecessary detail, and useful recall in later work. Keep eligibility and retention settings fixed while comparing models, and retain failures. Lower unit rates or a successful config load do not establish better memory quality or lower total usage.

`max_raw_memories_for_consolidation` limits recent raw memories retained for consolidation. The [reference](https://learn.chatgpt.com/docs/config-file/config-reference) documents a default of `256` and a cap of `4096`. It is not a chat context-window setting, and a larger value is not automatically better. The public example leaves it unset; do not copy a personal value such as `512` without a retention or quality reason.

## Decide which chats may contribute memories

The public example enables Memories but does not set `disable_on_external_context`. The documented default is `false`: external context alone does not exclude a chat from memory generation. Generation still depends on other settings, eligibility, idle time, and available quota. This flag does not turn off reading existing memories. See [memory controls](https://learn.chatgpt.com/docs/customization/memories#configuration).

Two legitimate choices are:

| Choice | Benefit | Tradeoff |
|---|---|---|
| Allow eligible tool-assisted chats globally | Research and troubleshooting can contribute continuity | Review whether external claims or sensitive task context are suitable for durable memory |
| Exclude them globally and opt in for selected research | Narrower default contribution scope | Useful decisions from ordinary tool-assisted chats may be omitted |

For the second choice, merge this into the **base** configuration:

```toml
[memories]
disable_on_external_context = true
```

Then create `$CODEX_HOME/research-memory.config.toml` with this override:

```toml
[memories]
disable_on_external_context = false
```

Start it with `codex --profile research-memory`. Only that key is overridden; the base model, permissions, and MCP enablement continue to apply unless another layer overrides them. Select one profile per invocation; combine desired settings deliberately in one file rather than assuming profiles stack. Use `/memories` for supported chat-level controls. Allowing contribution does not immediately generate memories or retroactively qualify all earlier chats.

Inspect the effective configuration and the base file after changing clients or settings. Profile parsing alone does not establish that every client preserves the intended base/profile separation. If a shared file changes unexpectedly, compare the new contents before restoring anything; do not attribute the writer or overwrite newer changes without evidence.

## Fast selection is not a fixed processing tier

The public example leaves `features.fast_mode` unset. The [configuration reference](https://learn.chatgpt.com/docs/config-file/config-reference) describes it as stable and on by default: it enables model-catalog service-tier selection in the TUI. There is no disabled public flag to repair.

`fast_mode = true` permits the selection interface; it does not by itself request Fast for every turn. `false` disables that selection feature rather than serving as a universal guarantee of Standard processing. The active model, session selection, `service_tier`, and client behavior matter. [`/fast`](https://learn.chatgpt.com/docs/developer-commands#toggle-fast-mode-with-fast) toggles and saves the selection when the model advertises the tier. Check current speed and usage terms before enabling it. The public example does not pin a paid processing tier.

## Optional Windows MXC preference

For compatible Windows devices, the [official Windows guide](https://learn.chatgpt.com/docs/windows/windows-sandbox#enable-mxc) recommends preferring Microsoft Execution Containers (MXC) while retaining a permitted legacy fallback. Review device support and organizational policy before merging this **Windows-only recipe**:

```toml
[features]
prefer_mxc = true

[windows]
sandbox = "elevated"
```

Merge into existing tables. This selects an implementation preference, not a permission scope: it does not turn `danger-full-access` into workspace isolation. The base public example remains cross-platform and does not configure Windows elevated setup. That fallback can require administrator-approved provisioning; this recipe does not authorize it.

When native capabilities or policy prevent MXC selection, the preference retains the configured legacy selection. Command failures after MXC is selected do **not** trigger automatic fallback. The standalone CLI maturity label and the documentation recommendation are recorded separately in [compatibility](compatibility.md#codex-configuration-guidance-2026-10-11).

On a supported CLI, the official probe checks command startup without changing the saved selection:

```powershell
codex -c windows.sandbox=mxc sandbox --include-managed-config --permission-profile :workspace -- cmd.exe /d /c echo MXC_OK
$LASTEXITCODE
```

Expected: `MXC_OK` and exit code `0`. This does not test every filesystem denial, network policy, or development workflow. MXC stops remaining child processes when the foreground command ends, so test detached-server workflows. Managed networking also has local-binding constraints; consult the [compatibility limits](https://learn.chatgpt.com/docs/windows/windows-sandbox#mxc-compatibility) before adopting it. If unsuitable, remove only the added preference or set it to `false`, retain the reviewed legacy selection, and verify a fresh session.

## Change, verify, and recover

1. Resolve the real `CODEX_HOME`, symlinks, executable, selected profile, and applicable project/managed layers. CLI and Desktop can use different binaries or session overrides. Consult [configuration precedence](https://learn.chatgpt.com/docs/config-file/config-basic#configuration-precedence).
2. Read the current file, record its hash, and create a complete backup. Verify backup size and hash; recheck the source before writing. Preserve unrelated settings and never publish private configuration or credentials.
3. Validate a candidate against the applicable official schema and include any referenced relative role files. Strict-load the base with `codex app-server --strict-config --listen stdio://`; run `codex --profile research-memory mcp list` for the profile-load path when using that recipe. A server listing is not an MCP call or a memory-generation test. See the [checked CLI limitations](compatibility.md#codex-configuration-guidance-2026-10-11).
4. Compare the complete diff, parsed values, encoding, and unaffected settings. Inspect `codex features list` and relevant client diagnostics. Test the specific behavior before claiming runtime success; report memory quality, billing, sandbox isolation, and Desktop behavior separately.
5. If another writer changes the file, preserve the new state and reconcile the difference. Restore a whole backup only after checking that it will not discard later changes; otherwise revert only the reviewed keys. Stop selecting a trial profile to stop applying its overrides. Changing models back does not undo memories already generated; inspect those through the supported memory controls rather than deleting the whole store automatically.

These Markdown recipes are not installed profiles and are outside the four-file inventory of `scripts/validate-codex-configs.py`. If future work ships standalone TOML files, add them to the maintained schema, mirror, and loading checks. Keep personal experiments out of shared defaults until their intended scope and evidence support adoption.
