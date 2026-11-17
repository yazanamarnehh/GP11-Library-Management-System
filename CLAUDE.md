# CLAUDE.md — GP11 Library Management System

This repository is the **Group 11** project for **Software Engineering (CS13477), PSUT, Fall 2026**.
Case study: **Library Management System** — books/resources, members, borrowing, returns,
reservations, renewals, due dates, fines. Final outcome: a functional **web application** with
catalog search, circulation workflows, librarian administration, and member functions.

The course grades the *engineering process*, not just a working app. Every Claude session in this
repo MUST follow the rules below. The full rule set is in [docs/process/project_rules.md](docs/process/project_rules.md).

## The chain every change must preserve

Problem → Requirements → Increment Plan → Architecture/UML → Agentic-AI Implementation →
Student Review → Testing/Validation → Versioned Release → Design/Code Traceability

Students must be able to explain every line you produce in an oral exam. Prefer clear, conventional
code over clever code, and explain design decisions when you make them.

## Hard rules (never break)

1. **No code without design.** Before implementing a capability, confirm its requirement IDs exist in
   `docs/requirements.md` and its design (UML in `uml/`) exists or is updated in the same increment.
   If not, stop and tell the user what is missing.
2. **Never delete branches** — local or remote, even after merge (`git branch -d/-D`,
   `git push --delete`, `git push origin :branch` are forbidden). Branches are graded evidence.
3. **Never commit directly on `main` or `dev`.** Work on `feature/<name>`, `docs/<task>`, or
   `test/<task>` branches and integrate through pull requests.
4. **Tag only merged commits** on the integration branch, after the PR is merged. Never tag a
   personal/unfinished branch. A tag alone is not evidence of a finished increment.
5. **Every meaningful agent task gets a prompt record** in `prompts/` (Markdown, see
   `prompts/TEMPLATE.md`), e.g. `prompts/v0.2.0-borrow-return-implementation.md`.
6. **Keep the logs current** in the same branch as the code:
   - `docs/ai_development_log.md` — one row per significant agent task.
   - `docs/traceability_matrix.md` — Requirement → Design element → Version → Module(s) → Test(s) → Status.
   - `docs/testing.md` — tests classified as unit / component / integration / API / DB / system-e2e.
7. **If implementation changes the design** (classes, interfaces, workflow, architecture), update the
   UML source in `uml/` before the increment is considered complete.
8. Never commit secrets or large datasets. Use synthetic demo data only.

## Versioning

- `v0.x.0-design` — design checkpoint for increment x (requirements + UML + plan updated).
- `v0.x.0` — working, tested increment x.
- `v0.x.y` — bug fix only. `v1.0.0` — final integrated release.
- Every version must appear as a row in `docs/incremental_development_plan.md` (5-column table).

## Repository layout (mandatory — do not rename)

| Path | Purpose |
|---|---|
| `README.md` | Group info, overview, diagrams list, structure, versions, contributions (first page of report) |
| `docs/` | project_description, requirements, incremental_development_plan, architecture, ai_development_log, traceability_matrix, testing, report |
| `uml/` | Editable diagram sources (`.puml` / `.mmd` / `.drawio`); PNG/SVG exports in `uml/rendered/` |
| `src/main/java` | Application source (Spring Boot), package `edu.psut.se.gp11.library` |
| `tests/java` | All automated tests (Maven `testSourceDirectory` points here) |
| `prompts/` | Mandatory Markdown agent-task records |
| `data/` | Small synthetic sample/seed data only |
| `config/` | Configuration samples (no secrets) |

## Tech stack

Java 21, Spring Boot 4.1, Maven (use the wrapper: `./mvnw` or `mvnw.cmd`).

- Build + test: `./mvnw verify`
- Run: `./mvnw spring-boot:run` → http://localhost:8080/api/health

## Project skills

- `/start-increment` — open a new increment: branch, plan row, requirements, UML, design checkpoint.
- `/prompt-record` — create the `prompts/` record before implementing an agent task.
- `/increment-check` — verify the increment acceptance criteria before PR/tag.

## Key dates

- Oral exam 1: 22 Nov – 3 Dec 2026 (requirements, architecture/UML, plan, version history, contributions).
- Oral exam 2: 3 – 14 Jan 2027 (final v1.0.0 demo, presented from `se_report_group_11.pdf`).
