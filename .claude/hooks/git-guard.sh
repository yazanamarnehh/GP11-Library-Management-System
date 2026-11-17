#!/usr/bin/env bash
# PreToolUse hook for Bash/PowerShell: enforces the course's git rules.
#   - Branches must never be deleted (local or remote).
#   - No direct commits on main/dev (use feature/docs/test branches + pull requests).
#   - Tags are created only on the integration branch (main/dev), i.e. on merged commits.
# Exit code 2 blocks the command and shows the message on stderr to Claude.
# Dependency-free on purpose (no jq), so it works in Git Bash on Windows and on macOS/Linux.

payload=$(cat)

# Pull the "command" string out of the tool input JSON (good enough for a guard).
cmd=$(printf '%s' "$payload" | tr '\n' ' ' | sed -n 's/.*"command"[[:space:]]*:[[:space:]]*"\(\([^"\\]\|\\.\)*\)".*/\1/p')
[ -z "$cmd" ] && exit 0

block() {
  echo "BLOCKED by GP11 git-guard: $1" >&2
  echo "See CLAUDE.md and docs/process/project_rules.md (section 6, GitHub and team rules)." >&2
  exit 2
}

# 1) Branch deletion — never allowed.
if printf '%s' "$cmd" | grep -Eq 'git[[:space:]]+branch[[:space:]]+([^;&|]*[[:space:]])?(-d|-D|--delete)([[:space:]]|$)'; then
  block "deleting branches is forbidden; branches are kept as graded evidence."
fi
if printf '%s' "$cmd" | grep -Eq 'git[[:space:]]+push[[:space:]][^;&|]*(--delete|[[:space:]]-d[[:space:]]|[[:space:]]:[A-Za-z0-9_./-]+)'; then
  block "deleting remote branches is forbidden; branches are kept as graded evidence."
fi

branch=$(git -C "${CLAUDE_PROJECT_DIR:-.}" branch --show-current 2>/dev/null)

# 2) Direct commits on main/dev — not allowed (unless the same command switches branch first).
#    Exception: the very first commit of a new repository (no HEAD yet).
if { [ "$branch" = "main" ] || [ "$branch" = "dev" ]; } &&
   git -C "${CLAUDE_PROJECT_DIR:-.}" rev-parse --verify -q HEAD >/dev/null 2>&1; then
  if printf '%s' "$cmd" | grep -Eq 'git[[:space:]]+commit' &&
     ! printf '%s' "$cmd" | grep -Eq 'git[[:space:]]+(checkout[[:space:]]+-b|switch[[:space:]]+(-c|--create))'; then
    block "you are on '$branch'. Create a feature/<name>, docs/<task> or test/<task> branch and open a pull request."
  fi
fi

# 3) Creating a tag outside the integration branch.
if printf '%s' "$cmd" | grep -Eq 'git[[:space:]]+tag[[:space:]]+(-a[[:space:]]+|-m[[:space:]]+)?v[0-9]'; then
  if [ "$branch" != "main" ] && [ "$branch" != "dev" ]; then
    block "version tags go on the merged commit of main/dev after the PR is merged, not on '$branch'."
  fi
fi

exit 0
