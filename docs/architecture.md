# Architecture — Library Management System (GP11)

> Each section links to the editable source in `uml/` and the export in `uml/rendered/`.

## 1. System context (C4 Level 1)

_TBD — `uml/c4-context.puml`_

## 2. Containers (C4 Level 2)

_TBD — `uml/c4-container.puml`_

## 3. Components

_TBD — layered Spring Boot design (controller → service → repository → database) to be confirmed._

## 4. Deployment

_TBD — if meaningful._

## 5. Technology choices

| Concern | Choice | Reason |
|---|---|---|
| Language / runtime | Java 21 | LTS, course-familiar |
| Framework | Spring Boot 4.1 | Web + persistence + testing support |
| Build | Maven (wrapper) | Reproducible builds for every team member |
| Database | PostgreSQL | Realistic relational DB with constraints for data integrity (NFR-03/04) |
| Schema migrations | Flyway | Versioned, reproducible schema (NFR-04) |
| Persistence | Spring Data JPA (Hibernate) | Standard ORM; repositories per aggregate |
| UI | Thymeleaf (server-rendered HTML) | One deployable, Java-only, simplest to explain; UI is not the grading focus |
| Security | Spring Security, BCrypt | Role-based authorisation (NFR-01) |
| Tests | JUnit 5, Mockito, Spring Boot Test, Testcontainers (PostgreSQL) | Unit + integration tests against the real DB engine (NFR-07) |
| Local run | Docker Compose (app + PostgreSQL) | One-command start (NFR-05) |

## 6. Design decisions log

| Date | Decision | Reason | Affected diagrams |
|---|---|---|---|
| 2026-11-17 | Spring Boot + Maven skeleton; tests in `tests/java` | Match mandatory repo layout | — |
| 2026-11-19 | Thymeleaf server-rendered UI instead of a separate SPA | Single container, simpler architecture and demo | C4 L2, component |
| 2026-11-19 | PostgreSQL in all environments (no embedded H2); Testcontainers for tests; Docker Compose for local run | Same DB engine everywhere avoids dialect surprises; realistic deployment view | C4 L2, deployment |
| 2026-11-19 | Business rules BR-01–BR-10 stored as configuration (`library.policy.*`) | Change policy without code changes (A6, FR-34) | class-domain |
| 2026-11-19 | Package-by-feature: `catalog`, `member`, `security`, `circulation`, `reservation`, `fine`, `notification`, `report` | Each increment maps to one package; easy traceability | component |
