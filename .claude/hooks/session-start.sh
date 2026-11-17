#!/usr/bin/env bash
# SessionStart hook: prints a short process reminder plus the current git state.
# Whatever this script prints is added to Claude's context at the start of every session.

cd "${CLAUDE_PROJECT_DIR:-.}" 2>/dev/null || exit 0

branch=$(git branch --show-current 2>/dev/null)
last_tag=$(git describe --tags --abbrev=0 2>/dev/null || echo "none yet")
dirty=$(git status --porcelain 2>/dev/null | wc -l | tr -d ' ')

cat <<EOF
[GP11 project reminder — CS13477 Library Management System]
Current branch: ${branch:-unknown} | Latest tag: ${last_tag} | Uncommitted files: ${dirty}

Follow CLAUDE.md and docs/process/project_rules.md. In short:
- No implementation without requirement IDs (docs/requirements.md) and design (uml/) for the increment.
- Work on feature/, docs/ or test/ branches; never commit on main/dev; never delete branches.
- Every agent task: prompt record in prompts/, row in docs/ai_development_log.md,
  update docs/traceability_matrix.md and docs/testing.md, update UML if the design changed.
- Tags (v0.x.0-design, v0.x.0) only on merged commits after a PR.
- Skills: /start-increment, /prompt-record, /increment-check.
EOF

if [ "$branch" = "main" ] || [ "$branch" = "dev" ]; then
  echo ""
  echo "WARNING: you are on '$branch'. Create a feature/docs/test branch before changing files."
fi
exit 0
