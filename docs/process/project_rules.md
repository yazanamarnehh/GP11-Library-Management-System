# Project Rules (summary of the official course instructions)

Source: *Software Engineering Project Instructions — Fall 2026*, CS13477, PSUT, by Dr. Samer El Kababji.
This file summarises the rules that apply to Group 11. If anything here conflicts with the official
PDF, the PDF wins.

## 1. Purpose

Demonstrate a complete software-engineering process: documented requirements; architecture and UML
developed before or alongside implementation; reviewable increments; every increment versioned and
tagged in GitHub; implementation via Agentic AI; AI-generated code understood, validated, tested and
traced to the design; final system integrated, documented and demonstrated. UI polish is secondary,
but the interface must be functional enough to demonstrate the main use cases.

## 2. Incremental development

Each functional increment normally includes:

1. Specification / requirements for the increment
2. Architecture and design relevant to the increment
3. Agentic-AI implementation
4. Testing and validation
5. GitHub merge (PR) and version tag
6. Documentation and diagram updates when the design changes

The number and scope of increments are case-specific. Break the system into fine-grained, meaningful
increments covering the *whole* system — not three broad lifecycle phases.

### Incremental development plan (`docs/incremental_development_plan.md`)

Five-column table, short cells with links:

| Version | Type | Capability / Scope | Deliverable / Evidence | Requirements / Design Links |
|---|---|---|---|---|
| v0.x.0-design | Design | Named capability | Updated diagrams, specifications | Requirement IDs, diagram paths |
| v0.x.0 | Working | Same capability | Functional code, AI-run tests, demo | Implementing modules, test paths |

Below the table, for every row: the main question, tools, and acceptance criteria.

### Versioning

`vMAJOR.MINOR.PATCH` — MINOR = new compatible capability, PATCH = bug fix, MAJOR = breaking redesign /
complete release. `-design` suffix = design checkpoint. Other suffixes (`-docs`, `-test`) only if
explained in the plan. Final release: `v1.0.0`.

### Git rule

A tag identifies a **reviewed and merged** state: feature branch → PR → review/merge into `dev` or
`main` → tag the merged commit. **Branches are never deleted**, including after merge.

## 3. Agentic AI policy

- All executable code is produced/modified through an Agentic AI coding workflow.
- Every student must be able to explain: requirements; architecture and UML; which modules implement
  which architecture parts; main classes, functions, interfaces, APIs, DB structures and data flow;
  the prompts given to the agent; AI-generated tests and their type (unit, component, integration,
  system/e2e) and results; incorrect AI output and how it was corrected; design changes; and
  traceability requirement → design → implementation → test.
- "The AI generated it" is not an acceptable explanation in the oral exam.

### AI development log (`docs/ai_development_log.md`)

| Version | Agent Task / Prompt Ref. | Changed Modules | Issues / Corrections | Student Review |
|---|---|---|---|---|

Record the coding agent used, prompt file, PR, substantive corrections, and the reviewing team member.

### Prompt records (`prompts/`, mandatory)

One Markdown file per meaningful agent task, e.g. `prompts/v0.2.0-registration-implementation.md`,
recording: version, goal, requirements and UML/architecture references, key instructions sent to the
agent, intended outputs, acceptance criteria, agent name, links to results. A `.txt` export may be
kept as supporting evidence but does not replace the Markdown record.

### Traceability (`docs/traceability_matrix.md`)

| Requirement ID | Use Case / Design Element | Increment / Version | Implementation Module(s) | Test(s) | Status |
|---|---|---|---|---|---|

If AI implementation changes architecture, class responsibilities, interfaces or workflow, update the
UML/design artifacts before the increment is complete.

## 4. Workflow (repeat per increment)

1. Understand the case and define assumptions. 2. Scope, stakeholders, FRs, NFRs. 3. Incremental plan.
4. System context and architecture. 5. Interaction/structure/behaviour models. 6. Select next
increment. 7. Design it and tag the design checkpoint. 8. Direct Agentic AI to implement. 9. Review the
code against the architecture/UML. 10. Test and validate. 11. Merge via PR and tag. 12. Update AI log
and traceability. 13. Repeat. 14. Integrate as v1.0.0. 15. Finalise report, repo, demo, oral.

## 5. Required models

- **Architecture:** C4 Level 1 System Context; C4 Level 2 Container; component view; deployment view
  where meaningful.
- **Interaction:** Use Case Diagram; Use Case Descriptions for important use cases; Sequence Diagrams
  detailed enough to map to real modules.
- **Structure:** Class Diagram — principal domain classes, attributes, key operations, associations
  with multiplicities, generalisation and aggregation/composition where used. Do not diagram
  framework internals.
- **Behaviour/data (choose what fits):** Activity (with swimlanes), State, DFD, ERD. For this case an
  ERD and state diagrams (book copy / loan / reservation lifecycle) are natural choices.
- Keep editable sources in `uml/` (`*.puml`, `*.mmd`, `*.drawio`); rendered exports in `uml/rendered/`.

## 6. GitHub and team rules

- One repository per team; every member contributes meaningfully.
- Branches: `feature/<increment-or-feature>`, `docs/<task>`, `test/<task>`.
- Integrate via pull requests; the integrator also uses branches and PRs.
- Tags after the PR is merged. **Never delete branches.** Keep full commit history.
- A history showing one person's commits or a single bulk upload fails the process requirement.

## 7. Deliverables

- GitHub repo with full incremental history, branches, PRs, tags, diagrams, code, tests, docs, release.
- Incremental development plan; requirements and design package with traceability.
- Functional web application.
- Tests and validation evidence, classified and mapped to requirements/modules.
- AI-development evidence (log + prompts).
- Final report `se_report_group_11.pdf` with README as first page (Markdown → Pandoc recommended).

## 8. README contents (concise)

Group information (number, title, names and IDs, course and instructor); project overview (purpose,
expected outcome, technology); principal diagrams with one-line descriptions; repository structure;
principal tagged versions and what each introduced; contributions (responsibility and commit counts).

## 9. Assessment (project = 30% of course)

| Criterion | Weight |
|---|---|
| Group commitment to deadlines | 15% |
| Final PDF report quality and formatting | 15% |
| Individual commit assessment | 20% |
| Discussions and individual oral examinations | 50% |

Oral exam 1: 22 Nov – 3 Dec 2026. Oral exam 2 (final, v1.0.0 demo from the PDF report): 3 – 14 Jan 2027.

## 10. Increment acceptance criteria

An increment is complete only when: goal and scope are stated; requirements are identified; UML is
created/updated; design and implementation are consistent; the Agentic-AI workflow was used; students
reviewed and understand the code; the feature is demonstrable; tests pass; docs, AI log and
traceability are updated; work is merged through a PR; and the merged commit carries the correct tag.

## 11. Final v1.0.0 acceptance criteria

All core requirements implemented; main use cases work end-to-end; diagrams match the final
architecture; code traceable to design; tests and validation evidence available; AI log complete;
traceability matrix complete; reproducible install/run instructions; report and README final; repo
tagged `v1.0.0`.
