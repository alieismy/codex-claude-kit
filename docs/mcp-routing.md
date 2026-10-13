# MCP Routing

MCP servers should be enabled for specific evidence or workflow needs, not as a broad default.

Codex configuration and Claude project `mcp.example.json` are opt-in starter examples, not inventories of every route below. Add another server only for a verified use case, configure its credentials independently, and confirm its status in the target client. Claude settings and MCP use different carriers; see [installation](installation.md).

Use `$rd-research` in Codex or `/rd-research` for local Claude Code Skills and `/anthropic-skills:rd-research` for account-synced Skills as the Skill-level wrapper when a task needs source collection, literature review, standards or policy checks, open-source or AI-tool evaluation, repository evidence, system-configuration investigation, public-fact verification, cost assumptions, or technical-maturity evidence.

## Routing Table

| Need | Preferred route | Notes |
|---|---|---|
| Evidence package or source validation | `$rd-research` plus the narrowest source tool | Use before or alongside feasibility, solution, standards, writing, or fact-dependent review work. |
| Library, framework, or SDK documentation | Context7 | Enable when official docs or examples are needed. |
| Current web research | Codex built-in web search or Tavily | Use current sources for time-sensitive facts. |
| Open-source or repository research | Local source inspection or GitHub/DeepWiki | Use a repository as evidence for that repository, not as authority for general best practice. |
| System, VPN, VPS, proxy, or configuration research | Local state/logs plus current official documentation and targeted web search | Establish environment, topology, threat boundary, validation evidence, and rollback before recommending changes. |
| Article fact-checking | Primary records plus independent current sources | Decompose claims, distinguish event/publication dates, and test counterevidence and alternative explanations. |
| Complex multi-option reasoning | Native model reasoning first; Sequential Thinking on demand | Enable only when an explicit reasoning trace tool is useful. |
| Open-source project architecture | DeepWiki on demand | Use for public GitHub projects. |
| Independent search index | Brave Search on demand | Requires API key and account setup. |
| Browser inspection for official pages or document sources | Built-in browser tooling first | Enable Playwright MCP only when it materially improves source inspection. |
| Web page/network inspection for referenced systems | Chrome DevTools MCP on demand | Disabled by default. |
| Cross-repository reference analysis | Augment Context Engine on demand | Do not ship personal relay URLs. |

## Public Template Rules

- Do not use `@latest` in npm MCP commands.
- Do not enable API-key MCP servers until credentials are configured.
- Do not hardcode private relay URLs.
- Keep external services disabled by default unless the repository clearly documents their data flow.
- Record verified package versions in `docs/compatibility.md`.
- Skills define repeatable workflows; MCP, apps, and web tools provide current or private evidence. Do not encode one vendor MCP as the only route unless the Skill truly depends on it.
