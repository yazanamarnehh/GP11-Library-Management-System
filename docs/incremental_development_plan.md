# Incremental Development Plan — Library Management System (GP11)

## Conventions

- `v0.x.0-design` — design checkpoint for increment x: requirements, UML and plan updated and merged.
- `v0.x.0` — working, tested increment x merged into `dev`.
- `v0.x.y` — bug fix only. `v1.0.0` — final integrated release (merged into `main`).
- Tags are created on the **merged commit** of the integration branch after the pull request is merged.
- Requirement IDs refer to [requirements.md](requirements.md); diagram paths refer to [`uml/`](../uml/).

Each working increment delivers a vertical slice: database migration → entities/repositories →
service (business rules) → web controller + Thymeleaf pages → tests.

## Plan

| Version | Type | Capability / Scope | Deliverable / Evidence | Requirements / Design Links |
|---|---|---|---|---|
| v0.0.0 | Setup | Repository bootstrap | Repo structure, Spring Boot skeleton, Claude rules, build passes | [prompt](../prompts/v0.0.0-repository-bootstrap.md) |
| v0.1.0-design | Design | System analysis + **Catalog** design | Description, requirements, plan; C4 L1/L2; use cases; domain class diagram; ERD; copy state diagram; catalog sequence diagrams | FR-01–06, NFR-01–10; `uml/c4-*.puml`, `uml/use-case.puml`, `uml/class-domain.puml`, `uml/erd.puml`, `uml/state-book-copy.puml`, `uml/seq-catalog-*.puml` |
| v0.1.0 | Working | **Catalog**: titles, copies, search | PostgreSQL + Flyway setup, catalog pages, unit/integration tests, demo | FR-01–06, NFR-02/04/05/07; `catalog` package; `tests/.../catalog` |
| v0.2.0-design | Design | **Members and security** | Member/account sequence diagrams, login activity, security in component view | FR-07–12, NFR-01; `uml/seq-member-*.puml`, `uml/component.puml` |
| v0.2.0 | Working | **Members and security** | Member management, role-based login, tests | FR-07–12; `member`, `security` packages |
| v0.3.0-design | Design | **Borrowing (checkout)** | Checkout sequence diagram, loan state diagram, eligibility activity diagram | FR-13–16, BR-01/02/05/07; `uml/seq-checkout.puml`, `uml/state-loan.puml` |
| v0.3.0 | Working | **Borrowing (checkout)** | Checkout desk page, member "My loans", rule tests | FR-13–16; `circulation` package |
| v0.4.0-design | Design | **Returns and overdue** | Return sequence diagram, scheduler design, updated loan state diagram | FR-17–20; `uml/seq-return.puml` |
| v0.4.0 | Working | **Returns and overdue** | Return desk page, overdue job + list, lost copy, tests | FR-17–20; `circulation` package |
| v0.5.0-design | Design | **Renewals** | Renewal sequence diagram, rule decision table | FR-21, BR-03; `uml/seq-renew.puml` |
| v0.5.0 | Working | **Renewals** | Renew from member and librarian pages, tests | FR-21 |
| v0.6.0-design | Design | **Reservations** | Reservation state diagram, queue/hold sequence diagrams, swimlane activity (reserve → return → hold → collect) | FR-22–26, BR-06/09; `uml/state-reservation.puml`, `uml/activity-reservation.puml` |
| v0.6.0 | Working | **Reservations** | Reserve/cancel, queue, holds, expiry job, tests | FR-22–26; `reservation` package |
| v0.7.0-design | Design | **Fines** | Fine calculation sequence, fine state diagram, ERD update | FR-27–30, BR-04/05/08; `uml/seq-fine-*.puml` |
| v0.7.0 | Working | **Fines** | Fine creation, payment/waiver, member balance, tests | FR-27–30; `fine` package |
| v0.8.0-design | Design | **Notifications and reports** | Notification sequence, report queries, deployment view | FR-31–34; `uml/seq-notification.puml`, `uml/deployment.puml` |
| v0.8.0 | Working | **Notifications and reports** | Notification log, dashboards, CSV export, policy settings, tests | FR-31–34; `notification`, `report` packages |
| v1.0.0 | Release | **Integrated final release** | End-to-end system tests, final UML, report PDF, Docker Compose run | All FR/NFR; `docs/report.md`, `se_report_group_11.pdf` |

## Row details

### v0.0.0 — Repository bootstrap
- **Main question:** Is the repository structured per the course rules, and does an empty Spring Boot application build, test and run?
- **Tools:** Git, Maven wrapper, Java 21, Spring Boot, Claude Code.
- **Acceptance criteria:** mandatory folders exist; `./mvnw verify` passes; `GET /api/health` returns `UP`; CLAUDE.md, skills and hooks committed.

### v0.1.0-design — System analysis and catalog design
- **Main question:** What must the whole system do, how is it structured, and exactly how will the catalog work?
- **Tools:** Markdown, PlantUML (C4-PlantUML), Claude Code.
- **Work split (one branch per member):** see [process/v0.1.0-design-tasks.md](process/v0.1.0-design-tasks.md).
- **Acceptance criteria:** every FR/NFR/BR has an ID; plan covers all versions to v1.0.0; C4 L1 and L2, use case diagram with descriptions for the important use cases, domain class diagram, ERD, copy state diagram and catalog sequence diagrams exist as editable sources with PNG renders; diagrams use the glossary names; traceability rows exist for FR-01–FR-34.

### v0.1.0 — Catalog
- **Main question:** Can a librarian maintain titles and copies, and can anyone search the catalog and see availability?
- **Tools:** Spring Boot (Web MVC, Data JPA, Validation), Thymeleaf, PostgreSQL, Flyway, JUnit 5, Testcontainers, Claude Code.
- **Acceptance criteria:** FR-01–06 demonstrable in the browser; ISBN and barcode uniqueness enforced; copy status rules follow `uml/state-book-copy.puml`; unit tests for catalog services, integration tests against PostgreSQL; `docker compose up` starts app + DB.

### v0.2.0-design / v0.2.0 — Members and security
- **Main question:** Who are the users, and how is each role restricted to its own functions?
- **Tools:** Spring Security, BCrypt, Thymeleaf security extras.
- **Acceptance criteria:** FR-07–12 work; each role sees only its pages; tests prove other roles get 403; passwords hashed (NFR-01).

### v0.3.0-design / v0.3.0 — Borrowing
- **Main question:** Can a librarian lend a copy only when every lending rule is satisfied?
- **Tools:** Spring transactions, JUnit parameterised tests for rules.
- **Acceptance criteria:** FR-13–16; each of BR-01/02/05/07 has a passing test with a clear refusal message; a copy cannot be loaned twice (NFR-03).

### v0.4.0-design / v0.4.0 — Returns and overdue
- **Main question:** Are returns recorded correctly and are overdue loans detected automatically?
- **Tools:** Spring `@Scheduled`, manual trigger endpoint for demo.
- **Acceptance criteria:** FR-17–20; scheduler marks overdue loans; overdue list correct; lost copy handled.

### v0.5.0-design / v0.5.0 — Renewals
- **Main question:** Can loans be extended within the renewal policy?
- **Tools:** Decision table in the design doc mapped to tests.
- **Acceptance criteria:** FR-21; every BR-03/05/07 refusal case tested.

### v0.6.0-design / v0.6.0 — Reservations
- **Main question:** Can members queue for unavailable titles and collect held copies fairly?
- **Tools:** State diagram-driven tests, scheduler for hold expiry.
- **Acceptance criteria:** FR-22–26; queue order FIFO; hold expiry passes copy on; return of a reserved title creates a hold (FR-17 extension).

### v0.7.0-design / v0.7.0 — Fines
- **Main question:** Are fines calculated, paid and enforced exactly according to policy?
- **Tools:** `BigDecimal` money handling, boundary-value tests.
- **Acceptance criteria:** FR-27–30; fine amounts match BR-04/08 incl. cap; BR-05 blocks borrowing and renewal.

### v0.8.0-design / v0.8.0 — Notifications and reports
- **Main question:** Are members kept informed and does management get useful figures?
- **Tools:** Scheduler, aggregate JPA queries, CSV export.
- **Acceptance criteria:** FR-31–34; notifications appear for each trigger; reports match seeded data; CSV downloads open in a spreadsheet.

### v1.0.0 — Final integrated release
- **Main question:** Do all main use cases work end-to-end and does the documentation match the system?
- **Tools:** System/end-to-end tests (MockMvc or browser-level), Pandoc for the report.
- **Acceptance criteria:** course §14 criteria — all core requirements implemented, final UML, complete AI log and traceability, reproducible run instructions, report PDF, tag `v1.0.0` on `main`.
