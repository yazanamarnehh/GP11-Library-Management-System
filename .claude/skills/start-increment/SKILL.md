---
name: start-increment
description: Open a new GP11 increment (design checkpoint) — create the branch, add the plan rows, write/confirm requirement IDs, and create or update the UML before any code. Use when the user wants to start, plan, or design the next version/increment/feature.
---

# Start an increment (design checkpoint `v0.x.0-design`)

Follow these steps in order. Do **not** write application code in this skill.

1. **Identify the increment.** Read `docs/incremental_development_plan.md` and the latest tag
   (`git describe --tags --abbrev=0`). Agree with the user on the version number `v0.x.0` and the
   named capability (e.g. "Borrow/return lifecycle"). Keep increments small and reviewable.
2. **Branch.** From the up-to-date integration branch, create `feature/v0.x.0-<capability-slug>`
   (or `docs/<task>` for design-only work). Never work on `main`/`dev`.
3. **Requirements.** In `docs/requirements.md`, add or confirm the functional (`FR-xx`) and
   non-functional (`NFR-xx`) requirement IDs this increment covers. Each must be testable.
4. **Plan rows.** In `docs/incremental_development_plan.md` add two rows to the 5-column table:
   `v0.x.0-design` (Design) and `v0.x.0` (Working) for the same capability, plus a subsection below
   the table with the main question, tools, and acceptance criteria.
5. **Design.** Create or update the editable UML sources in `uml/` that this capability needs
   (use case + descriptions, sequence diagram(s), class diagram, ERD, state/activity diagram as
   appropriate). Export renders to `uml/rendered/`. Update `docs/architecture.md` if containers or
   components change.
6. **Traceability.** Add rows to `docs/traceability_matrix.md` for the new requirement IDs with the
   design elements and version; module/test columns may be "planned" until implemented.
7. **Prompt record.** If the agent did substantive design work, create a record via `/prompt-record`
   and add a row to `docs/ai_development_log.md`.
8. **Hand-off.** Commit on the branch with clear messages, then tell the user to open a PR. After the
   PR is merged, the design checkpoint is tagged `v0.x.0-design` on the merged commit (by the user or
   in a later session on the integration branch).

Finish by summarising which requirement IDs and diagrams the increment covers, and what the user must
review before merging.
