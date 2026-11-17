---
name: prompt-record
description: Create the mandatory Markdown prompt record in prompts/ for a GP11 agent task and the matching AI development log row. Use before implementing any increment, feature, fix, or test suite with the coding agent, or when the user asks to record a prompt.
---

# Create a prompt record

The course requires one structured Markdown file in `prompts/` for every meaningful agent task.

1. Determine the version and a short slug, then create
   `prompts/<version>-<slug>.md` (e.g. `prompts/v0.2.0-borrow-return-implementation.md`) by copying
   `prompts/TEMPLATE.md`.
2. Fill in every section:
   - Version / increment and goal.
   - Requirement IDs (from `docs/requirements.md`) and UML/architecture references (paths in `uml/`,
     sections of `docs/architecture.md`).
   - The key instructions sent to the agent — the user's actual request, refined into precise
     instructions (keep the user's wording where possible).
   - Intended outputs (files/modules/tests) and acceptance criteria (testable).
   - Agent name and model (e.g. "Claude Code — <model>").
   - Results section: leave placeholders for branch, PR link, changed modules, test results,
     corrections; fill them in when the task is done.
3. Add a row to `docs/ai_development_log.md`:
   `| <version> | prompts/<file>.md | <changed modules> | <issues/corrections> | <reviewer: TBD> |`.
   The reviewer is a **student**, never the agent — leave "TBD (student)" for the user to fill in.
4. After implementation, return to the record and complete the Results section and log row with what
   actually changed, which tests were added (and their type), and any corrections the user requested.
