---
name: increment-check
description: Verify a GP11 increment against the course acceptance criteria before opening a PR or tagging (v0.x.0, v0.x.0-design, v1.0.0). Use when the user says an increment/feature is done, asks if it is ready to merge or tag, or before a release.
---

# Increment acceptance check

Check each item and report a table of PASS / FAIL / N/A with evidence (file path, test name, command
output). Do not mark something PASS without looking.

| # | Criterion | How to check |
|---|---|---|
| 1 | Goal and scope stated | Row + subsection exists in `docs/incremental_development_plan.md` |
| 2 | Requirements identified | IDs exist in `docs/requirements.md` |
| 3 | UML created/updated | Relevant sources in `uml/` changed or confirmed current; renders in `uml/rendered/` |
| 4 | Design ≡ implementation | Compare class/sequence diagrams with the actual classes, methods, endpoints |
| 5 | Agentic-AI workflow used | Prompt record in `prompts/` for this version |
| 6 | Student review | Reviewer filled in `docs/ai_development_log.md` (ask the user if TBD) |
| 7 | Demonstrable | App starts (`./mvnw spring-boot:run`) and the feature can be shown |
| 8 | Tests pass | `./mvnw verify` output; tests classified in `docs/testing.md` |
| 9 | Docs/log/traceability updated | `docs/ai_development_log.md`, `docs/traceability_matrix.md`, README versions list |
| 10 | Merged through a PR | Branch is not main/dev; PR exists or is ready to open |
| 11 | Correct tag on merged commit | Only after merge: tag `v0.x.0` / `v0.x.0-design` on the integration branch |

For **v1.0.0**, additionally check: all core requirements implemented; main use cases end-to-end;
diagrams reflect the final architecture; AI log and traceability matrix complete; reproducible
install/run instructions in README; `docs/report.md` and `se_report_group_11.pdf` finalised.

End with the list of FAIL items and the concrete fix for each. Never delete branches and never tag an
unmerged branch.
