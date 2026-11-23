# AI Development Log — GP11

One row per significant agent task. Actual instructions live in `prompts/`. The **Student Review**
column names the team member who reviewed the agent's output and what they found.

| Version | Agent Task / Prompt Ref. | Changed Modules | Issues / Corrections | Student Review |
|---|---|---|---|---|
| v0.0.0 | [prompts/v0.0.0-repository-bootstrap.md](../prompts/v0.0.0-repository-bootstrap.md) | Whole repo skeleton: `CLAUDE.md`, `.claude/`, `docs/`, `pom.xml`, `src/`, `tests/` | — | TBD (student) |
| v0.1.0-design | [prompts/v0.1.0-design-requirements-and-plan.md](../prompts/v0.1.0-design-requirements-and-plan.md) | `docs/project_description.md`, `docs/requirements.md`, `docs/incremental_development_plan.md`, `docs/architecture.md`, `docs/traceability_matrix.md`, `docs/process/v0.1.0-design-tasks.md` | — | TBD (student, PR reviewer) |
| v0.1.0-design | [prompts/v0.1.0-design-domain-model.md](../prompts/v0.1.0-design-domain-model.md) | `uml/class-domain.puml`, `uml/erd.puml`, `uml/state-book-copy.puml`, `docs/domain_model.md` | — | TBD (student, PR reviewer) |
| v0.1.0-design | [prompts/v0.1.0-design-use-cases.md](../prompts/v0.1.0-design-use-cases.md) | `uml/use-case.puml`, `uml/seq-catalog-search.puml`, `uml/seq-catalog-add-copy.puml`, `uml/rendered/`, `docs/use_cases.md` | Use case diagram redrawn as 3 pages (first version unreadable) | TBD (PR reviewer) |
| v0.1.0-design | [prompts/v0.1.0-design-architecture-c4.md](../prompts/v0.1.0-design-architecture-c4.md) | `uml/c4-context.puml`, `uml/c4-container.puml`, `uml/component.puml`, `uml/rendered/`, `docs/architecture.md` §1–4 | Review fixes: FR-23 moved to `reservation`; `LendingPolicy`/FR-34 moved to new `config` package; package dependencies added; browser removed as a C4 container; broken §5–6 links fixed | Ibrahim Hammoudeh (PR #4 review comments) |

Coding agent(s) used: Claude Code (Claude Opus 5.5, Claude Sonnet 5.5); Gemini (Task B).
