# User Prompt Templates

> Designed for the Codex Three-Layer Delivery document workflow. Replace `{placeholders}` with actual content, then paste into Cursor or Claude Code.
>
> Skills are matched through the `/rd-*` prefix. This template set intentionally excludes coding, code review, testing, deployment execution, and release operations.
>
> The commands below use Cursor or Claude Code local Skill names. For Claude Code account-synced Skills, replace each `/rd-*` invocation with `/anthropic-skills:rd-*` before pasting; do not install a second local copy just to preserve the shorter name.

---

## Table of Contents

1. [Requirements Analysis](#1-requirements-analysis-rd-requirement)
2. [Requirements Review](#2-requirements-review-rd-review)
3. [Research Evidence](#3-research-evidence-rd-research)
4. [Feasibility Analysis](#4-feasibility-analysis-rd-feasibility)
5. [Feasibility Review](#5-feasibility-review-rd-review)
6. [Technical Proposal / High-Level Design / Construction Plan](#6-technical-proposal--high-level-design--construction-plan-rd-solution)
7. [Proposal Review](#7-proposal-review-rd-review)
8. [Detailed Design](#8-detailed-design-rd-design)
9. [Design Review](#9-design-review-rd-review)
10. [Standards Work](#10-standards-work-rd-specification)
11. [Standards / Document Review](#11-standards--document-review-rd-review)
12. [Professional Technical Writing](#12-professional-technical-writing-rd-writing)
13. [Research or Article Review](#13-research-or-article-review-rd-review)
14. [Multi-Document Delivery Orchestration](#14-multi-document-delivery-orchestration-rd-delivery)
15. [Greenfield Open-Source Landscape and Solution Gate](#15-greenfield-open-source-landscape-and-solution-gate)
16. [High-Impact Bidirectional Argument and Critical Clarification](#16-high-impact-bidirectional-argument-and-critical-clarification)
17. [Optional Authority and Completion Contract](#17-optional-authority-and-completion-contract)

---

## 1. Requirements Analysis (`/rd-requirement`)

### Template A: PRD / SRS From Raw Requirements

```text
Use /rd-requirement

## Background
{Project/product/system background, 1-3 sentences}

## Raw User Requirements
{Preserve the user's original wording verbatim}

## Known Constraints
- Target users / stakeholders: {roles}
- Business process or policy constraints: {if any}
- Technical or system constraints: {if known, otherwise TBD}
- Compliance / standards constraints: {if any}
- Timeline / budget / resource constraints: {if any}

## Expected Output
Produce a PRD / SRS with priorities, assumptions, exclusions, traceability, and verifiable acceptance criteria.
```

### Template B: Supplement Existing Requirements

```text
Use /rd-requirement

Analyze the following existing requirements material and fill missing dimensions:

## Existing Material
{Paste text or reference file paths}

## Focus Areas
- {e.g., stakeholder roles are unclear}
- {e.g., non-functional requirements are missing}
- {e.g., acceptance criteria are not verifiable}
- {e.g., scope exclusions are not explicit}
```

---

## 2. Requirements Review (`/rd-review`)

```text
Use /rd-review, Requirements Review mode

## Review Target
{PRD / SRS document name, version, or file path}

## Document Content
{Paste the document or provide file path}

## Review Focus
- Completeness of P0/P1 requirements
- Verifiability of acceptance criteria
- Consistency of terms, roles, and scenarios
- Explicit assumptions, exclusions, and constraints

## Context
{Project phase, upstream decisions, known constraints}
```

---

## 3. Research Evidence (`/rd-research`)

Use this when external evidence materially affects a feasibility study, technical proposal, standards task, detailed design decision, or fact-dependent review. Skip it for small tasks where the provided source material is sufficient.

```text
Use /rd-research

## Research Goal
{Decision, document section, standard clause, technology choice, policy question, or review claim that needs evidence}

## Downstream Use
This evidence will support: {rd-feasibility / rd-solution / rd-specification / rd-design / rd-writing / rd-review}

## Required Source Types
- Target project documents: {files or excerpts}
- Standards / policies / regulations: {if relevant}
- Vendor / framework / protocol documentation: {if relevant}
- Academic or technical literature: {if relevant}
- Market, cost, or industry cases: {if relevant}

## Expected Output
Produce a source table with authority, date/version context, relevance, confidence, conflicts, gaps, and citation-ready notes. Do not write the final downstream document yet.
```

Choose one primary research mode: {Evidence Support / Technology and Open Source / Configuration and Infrastructure / Fact-check and Argument Evidence}. For technology and configuration work, include exact product form, version, platform, environment, reproducibility status, security/privacy boundary, and rollback or exit-path evidence.

---

## 4. Feasibility Analysis (`/rd-feasibility`)

### Template A: Full Feasibility Study

```text
Use /rd-feasibility

## Decision Question
{What needs to be judged feasible or infeasible}

## Background and Requirements Source
{Reference PRD, meeting notes, project proposal, policy requirement, or stakeholder request}

## Options to Evaluate
- Option A: {description}
- Option B: {description}
- Baseline / maintain current state: {if applicable}

## Required Dimensions
- Necessity / value
- Technical feasibility
- Economic feasibility
- Schedule feasibility
- Operational feasibility
- Security and compliance feasibility
- Key risks and mitigation

## Known Inputs and Constraints
{Budget, schedule, staffing, existing systems, standards, procurement, policy, or data constraints}

## Expected Conclusion
Give a clear verdict: feasible / conditionally feasible / not feasible, with confidence, conditions, risks, and verification actions.
```

### Template B: Quick Feasibility Judgment

```text
Use /rd-feasibility

Evaluate whether {project / feature / solution} is feasible under these constraints:
{constraints}

Compare at least two options when a real choice exists. Separate facts, assumptions, estimates, and unknowns.
```

---

## 5. Feasibility Review (`/rd-review`)

```text
Use /rd-review, Feasibility Review mode

## Review Target
{Feasibility study / feasibility analysis report name, version, or file path}

## Document Content
{Paste the report or provide file path}

## Review Focus
- Whether the decision question and conclusion are clear
- Whether technical, economic, schedule, operational, compliance, and risk dimensions are covered
- Whether numbers and claims have sources or estimation basis
- Whether conditions, blockers, and verification actions are explicit
```

---

## 6. Technical Proposal / High-Level Design / Construction Plan (`/rd-solution`)

### Template A: Technical Proposal / High-Level Design

```text
Use /rd-solution

## Document Type
Technical Proposal / High-Level Design

## Requirements and Feasibility Inputs
- PRD / requirements: {file path or summary}
- Feasibility analysis: {file path or key conclusion, if any}

## Target Audience
{Decision-makers / client reviewers / technical leadership / implementation team}

## Known Constraints
- Technology constraints: {if any}
- Existing systems and integration boundaries: {if any}
- Performance / capacity requirements: {if any}
- Security / compliance / standards: {if any}
- Budget / schedule / staffing: {if any}

## Required Output
Compare candidate solutions, recommend one, explain rejected alternatives, and include risks, assumptions, and open issues.
```

### Template B: Construction Plan With Deployment Architecture Design

```text
Use /rd-solution

## Document Type
Construction Plan (design-level, not deployment runbook)

## Requirements Source
{Reference PRD, feasibility report, or approved proposal}

## Required Sections
- System architecture
- Deployment architecture design: topology, environment planning, capacity, HA/DR
- Security design
- Milestones and responsibilities
- Key risks and mitigation
- Open issues

## Constraints
{Infrastructure, network, security, compliance, staffing, procurement, or review constraints}
```

---

## 7. Proposal Review (`/rd-review`)

```text
Use /rd-review, Proposal Review mode

## Review Target
{Technical proposal / high-level design / construction plan name, version, or file path}

## Document Content
{Paste the document or provide file path}

## Reference Inputs
- Requirements: {PRD path or summary}
- Feasibility report: {path or summary, if any}

## Review Focus
- Requirements coverage
- Candidate solution sufficiency and fairness
- Architecture rationality
- Security, reliability, scalability, cost, and risk
- Whether deployment architecture is design-level and not operational runbook content
```

---

## 8. Detailed Design (`/rd-design`)

```text
Use /rd-design

## Design Scope
{Modules, subsystems, interfaces, data domains, or business processes covered}

## Upstream Inputs
- PRD / requirements: {file path or summary}
- Technical proposal / high-level design: {file path or key decisions}
- Standards / compliance constraints: {if any}

## Required Design Content
- Module boundaries and responsibilities
- Interface contracts
- Data model and lifecycle
- Critical flows and state machines
- Error handling and timeout paths
- Security and audit design
- Concurrency and idempotency requirements
- Open decisions with owner and deadline

## Special Focus
{e.g., cross-system integration, data consistency, audit logs, cybersecurity, standard compliance}
```

---

## 9. Design Review (`/rd-review`)

```text
Use /rd-review, Design Review mode

## Review Target
{Detailed design document name, version, or file path}

## Document Content
{Paste the design or provide file path}

## Review Focus
- Interface completeness
- Data model correctness
- Flow, state, error, timeout, and concurrency coverage
- Security and audit design
- Traceability to requirements and upstream proposal
- Unresolved items with owner and deadline
```

---

## 10. Standards Work (`/rd-specification`)

### Template A: Standards Drafting / Revision

```text
Use /rd-specification

## Standards Task
{Draft / revise / compare / perform gap analysis}

## Standard Type and Status
{National / industry / enterprise / internal specification; draft / review draft / published baseline}

## Scope
{Chapters, clauses, domain, system boundary, or technical topic}

## Source Material
- Existing draft: {file path or pasted content}
- Normative references: {list if known}
- Upstream requirements or policies: {if any}

## Required Output
Provide clause-level suggestions, normative wording, terminology checks, unresolved issues, and evidence boundaries.
```

### Template B: Clause-Level Standards Revision

```text
Use /rd-specification

Analyze and revise the following standard/specification clauses objectively and rigorously.

## Clauses
{Paste clauses, tables, figures, or terms}

## Review Requirements
- Quote or identify the exact clause for every issue
- Do not invent standards or unsupported evidence
- Mark insufficient evidence as "requires human verification"
- Provide replacement normative wording when possible
```

---

## 11. Standards / Document Review (`/rd-review`)

```text
Use /rd-review, Standards Review mode

## Review Target
{Standard / specification / guideline name, version, or file path}

## Document Content
{Paste target clauses or provide file path}

## Review Focus
- Scope and authority
- Normative clarity
- Clause correctness and verifiability
- Terminology and reference consistency
- Conflicts with referenced documents
- Replacement wording for major findings
```

---

## 12. Professional Technical Writing (`/rd-writing`)

```text
Use /rd-writing, {Technical Article / Evidence Report / Decision Brief} mode

## Audience and Purpose
{real readers, publication or decision purpose, expected depth and length}

## Verified Inputs
{source files, evidence package, approved claims, date/version boundary}

## Central Question or Candidate Conclusion
{what the document must explain or help decide; treat a preferred conclusion as a proposition to test}

## Required Output
Produce audience-ready prose with traceable claims, the strongest material counterargument, explicit limitations, and a conclusion that stays within the evidence.
```

---

## 13. Research or Article Review (`/rd-review`)

```text
Use /rd-review, {Research Review / Article Review} mode

## Review Target
{research report, tool evaluation, technical article, white paper, public-affairs article, or fact-check report}

## Review Basis
{source materials, date/version boundary, intended decision or publication standard}

## Review Focus
- Claim-to-source accuracy and source independence
- Reproducibility, counterevidence, and alternative explanations
- Causal and quantitative reasoning
- Audience fit and publication risk after factual and logical integrity

Lead with location-specific, severity-graded findings and give an approval or publication verdict.
```

---

## 14. Multi-Document Delivery Orchestration (`/rd-delivery`)

Use this only when the user explicitly wants an end-to-end, multi-document, phased, or cross-session engagement. Route a single deliverable directly to its specialist Skill.

```text
Use /rd-delivery

## Engagement Goal and Authority
{decision or delivery goal, audience, scope, exclusions, success criteria, owner, approval authority, date/version boundary}

## Known Source-of-Truth Artifacts
{project guidance, baselines, PRD, evidence, feasibility, decisions, designs, standards, reviews, or existing task record}

## Required Deliverables
{only the artifacts needed; do not force every rd-* stage}

## Expected Output
Create a delivery charter, artifact/dependency map, decision-complete work packages with blocking edges, checkable phase gates, explicit artifact states, and a durable handoff that does not depend on chat history.
```

---

## 15. Greenfield Open-Source Landscape and Solution Gate

Use this only when a greenfield product or tool, or an unresolved architecture decision, would materially benefit from comparing external projects. Do not use it for small fixes or implementation under an already approved architecture.

For one solution deliverable, use `/rd-solution` and route external evidence to `/rd-research`. Use `/rd-delivery` only when the user explicitly requests research, provisional MVP requirements, solution selection, and an approval gate as a coordinated multi-artifact engagement.

```text
Use /rd-delivery

## Goal and Authority
I want to develop {product or tool}. The current controlling goal is an evidence-backed solution decision, not implementation.

## Research Boundary
- Perform read-only research and solution definition only.
- Do not modify target-project source, configuration, or implementation artifacts, emit implementation code, or begin implementation unless separately authorized.
- Durable handoff record: {approved path / not authorized; default: not authorized}. When `/rd-delivery` is used and a path is explicitly approved, write only the bounded delivery record needed to preserve artifact status, decisions, evidence gaps, and the approval gate; otherwise return the decision package in chat and state that no durable handoff was created.
- Temporary read-only clones under `.tmp/local/` are {allowed / not allowed}. If they are not allowed, state the resulting source-inspection limits.

## Needs and Constraints
{users, problems, core scenarios, fixed business constraints, security/privacy requirements, target platforms, budget/schedule limits, integration constraints, exclusions, and success criteria}

## Source Discipline
GitHub is a candidate source, not the sole authority.
- Record the inspection date and pin each material repository to a tag or commit.
- Check official documentation, source, releases, issue/PR maintenance, security notices, license, dependencies, and reproducibility evidence as applicable.
- Assess activity using release/commit recency, maintainer response, archive status, and unresolved critical issues; do not rank primarily by stars.
- Distinguish maintainer claims and static source inspection from reproduced runtime behavior.

## Candidate Analysis
For each high-value candidate, explain the problem addressed, architecture, major dependencies, extension and trust boundaries, current maintenance state, design worth reusing, design to avoid, applicability gaps, license/security constraints, and exit or replacement path.

## Required Decision Package
1. A traceable evidence table and candidate shortlist, including rejected candidates and reasons.
2. Recommended technology selection and strongest credible alternative.
3. System context, component architecture, data/control flows, trust boundaries, and key failure paths.
4. Provisional MVP scope tied to user needs, exclusions, assumptions, and verifiable acceptance conditions.
5. A dependency-aware implementation handoff sequence, major risks, validation gates, and unresolved decisions.

## Approval Gate
Stop at the approval gate after presenting the decision package. Implementation is outside the RD Skills' delivery boundary and must not begin without separate confirmation and an implementation-capable workflow.
```

---

## 16. High-Impact Bidirectional Argument and Critical Clarification

This is an optional preamble, not a standalone Skill. Prepend it to an applicable `/rd-requirement`, `/rd-feasibility`, `/rd-solution`, or `/rd-review` prompt only when a high-impact question involves a genuine disagreement over positions or options and an unresolved critical variable could materially change the conclusion. Do not use it for clear factual queries, small corrections, implementation under an approved solution, or other low-risk work.

```text
Before making the final judgment:

1. Preserve my original question and restate the objective as your "current interpretation." Separate the underlying need, my proposed solution, confirmed constraints, and unconfirmed assumptions. Do not invent an objective on my behalf.
2. Identify implicit assumptions and decision-critical evidence gaps, and explain how different values or findings could change the conclusion. First resolve facts discoverable from the supplied materials, the current project, or authoritative sources; do not ask me to retrieve information you can inspect yourself.
3. Give the strongest credible case for my current idea and the strongest credible, material counterargument, alternative explanation, or alternative option. Do not manufacture symmetry; if one side has materially weaker evidence, say so.
4. State whether the real disagreement concerns facts, definitions, objectives, values, risk tolerance, or decision authority, and identify the variables most likely to change the conclusion. If the current problem and evidence support it, identify one error or failure mode most likely to distort the judgment; otherwise omit it.
5. If one or more unresolved decisions that only I can make block the final judgment, ask the highest-impact blocking question first, or a small batch when the decisions are independent. Continue authorized work that does not depend on the answers, and defer the affected judgment until its blocking decisions are resolved. If no such decision blocks the judgment, proceed without a question for form's sake and provide a bounded judgment, rationale, confidence, remaining uncertainty, and next action.

Do not expose hidden chain of thought. Output only the reviewable current interpretation, assumptions, evidence, counterevidence, key variables, trade-offs, and conclusion summary.
```

---

## 17. Optional Authority and Completion Contract

Use this optional block with a document-delivery prompt when the permitted work or stopping point needs clarification. Fill only the fields that matter; omit it for routine tasks whose scope is already clear. It records task-specific choices under the applicable rules, not a new approval process or permission to expand scope.

```text
Authorized work: {read-only analysis / drafting or editing specified artifacts / necessary document verification}
May decide independently: {low-risk details that do not change material conclusions, scope, or authority}
Decisions reserved for me: {unresolved choices affecting scope, key constraints, artifact status, or external effects}
Completion criteria: {deliverable, applicable checks, and explicitly unverified items}
Stop boundary: {subsequent actions or stages that are not part of this task}
```

A verified draft or recommendation may complete the requested work while stakeholder approval remains pending. Approval, baselining, publication, and downstream execution require their own applicable authority and evidence; this block does not supply them by implication.

---

## Combined Usage Example

```text
# For an explicitly requested multi-document or cross-session engagement, use /rd-delivery to coordinate only the required steps below.

# Step 1: Requirements Analysis
Use /rd-requirement
Structure the user's original needs into a PRD with priorities, assumptions, exclusions, and acceptance criteria.

# Step 2: Requirements Review
Use /rd-review, Requirements Review mode
Review the PRD for completeness, verifiability, consistency, and boundary clarity.

# Optional: Research Evidence
Use /rd-research
Collect and validate external evidence when feasibility, solution, standards, design, or review conclusions depend on literature, standards, policy, vendor documentation, cost assumptions, maturity claims, or industry cases.

# Optional: Professional Writing
Use /rd-writing
Turn verified evidence into a technical article, evidence report, or decision brief when audience-ready narrative is the actual deliverable.

# Step 3: Feasibility Analysis
Use /rd-feasibility
Evaluate whether the project is feasible across technical, economic, schedule, operational, compliance, and risk dimensions.

# Step 4: Technical Proposal / High-Level Design
Use /rd-solution
Write a technical proposal based on the PRD and feasibility conclusion. Compare candidate solutions and recommend one.

# Step 5: Proposal Review
Use /rd-review, Proposal Review mode
Review requirements coverage, architecture rationale, risk, cost, and design-level deployment architecture.

# Step 6: Detailed Design
Use /rd-design
Produce detailed design for selected modules, including interfaces, data, flows, errors, security, and concurrency.

# Step 7: Design Review
Use /rd-review, Design Review mode
Review the detailed design for completeness, traceability, correctness, and unresolved decisions.

# Optional: Standards Work
Use /rd-specification
Draft or revise standard/specification clauses with clause-level evidence and normative wording.
```

---

## Prompt Tips

| Tip | Description |
|-----|-------------|
| Preserve raw source text | Keep the user's original requirement, clause, or document text intact before structuring it |
| Specify document type | PRD, feasibility study, technical proposal, high-level design, detailed design, standard, technical article, evidence report, decision brief, or review report |
| Provide upstream references | Link PRD -> feasibility -> proposal -> detailed design -> review for traceability |
| Use research selectively | Invoke `/rd-research` only when external evidence materially affects the downstream document or review |
| Demand evidence separation | Ask the agent to separate facts, assumptions, estimates, inferences, and unknowns |
| State review focus | Focused reviews produce higher signal than generic "please review" prompts |
| Use standards wording constraints | For standards, require clause references, replacement wording, and "requires human verification" where evidence is missing |
| Keep execution out of scope | Do not ask these skills to write code, run tests, deploy, or operate systems |
