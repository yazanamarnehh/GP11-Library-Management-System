# Incremental Development Plan — Library Management System (GP11)

Tag convention: `v0.x.0-design` = design checkpoint, `v0.x.0` = working and tested increment,
`v0.x.y` = bug fix, `v1.0.0` = final integrated release. Tags are created on the merged commit of the
integration branch after the pull request is merged.

| Version | Type | Capability / Scope | Deliverable / Evidence | Requirements / Design Links |
|---|---|---|---|---|
| v0.0.0 | Setup | Repository bootstrap: structure, Spring Boot skeleton, Claude rules | Repo skeleton, health endpoint, build passes | [prompt](../prompts/v0.0.0-repository-bootstrap.md) |
| _v0.1.0-design_ | _Design_ | _TBD_ | | |
| _v0.1.0_ | _Working_ | _TBD_ | | |

> Add two rows (design + working) per case-specific increment. Cover the whole system, in small,
> reviewable steps. Suggested direction from the course: catalog/member management → borrow/return
> lifecycle → reservations/fines/reports — refine these into finer increments.

## Row details

### v0.0.0 — Repository bootstrap

- **Main question:** Is the repository structured per the course rules, and does an empty Spring Boot
  application build, test and run?
- **Tools:** Git, Maven wrapper, Java 21, Spring Boot, Claude Code.
- **Acceptance criteria:** mandatory folders exist; `./mvnw verify` passes; `GET /api/health` returns
  `UP`; CLAUDE.md, skills and hooks are committed.

### v0.1.0-design — _TBD_

- **Main question:** _TBD_
- **Tools:** _TBD_
- **Acceptance criteria:** _TBD_
