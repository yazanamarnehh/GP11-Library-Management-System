# GP11 — Library Management System

## Group information

| | |
|---|---|
| Group | **11** |
| Case study | Library Management System |
| Course | Software Engineering (CS13477) — PSUT, Fall 2026 |
| Instructor | Dr. Samer El Kababji |

| Student name | Student ID |
|---|---|
| Yazan | 20230665 |
| bashar  | 20230318 |
| ibrahim | 20230761 |
| abdalrahman | 20210833 |

## Project overview

- **Purpose:** manage a library's books/resources, members, borrowing, returns, reservations,
  renewals, due dates and fines.
- **Expected final outcome:** a functional web application for catalog search and circulation
  workflows, with librarian administration and member functions.
- **Technology:** Java 21, Spring Boot 4.1, Maven; implementation through Claude Code (Agentic AI);
  diagrams in PlantUML/Mermaid/draw.io.

### Run it

Requires JDK 21+.

```bash
./mvnw verify            # build and run all tests (Windows: mvnw.cmd verify)
./mvnw spring-boot:run   # start the app, then open http://localhost:8080/api/health
```

## Architecture and diagrams

| Diagram | Description |
|---|---|
| [C4 System Context](uml/c4-context.puml) | High-level actors (Guest, Member, Librarian, Admin) and simulated Email Service |
| [C4 Container](uml/c4-container.puml) | Spring Boot/Thymeleaf web application (with internal scheduler) and PostgreSQL |
| [Component View](uml/component.puml) | Feature packages with Controller → Service → Repository layers, key dependencies and cross-cutting security |
| [Use case diagram](uml/use-case.puml) (3 pages) | All actors and use cases UC-01–UC-32 with include/extend; descriptions in [docs/use_cases.md](docs/use_cases.md) |
| [Sequence: catalog search](uml/seq-catalog-search.puml) | Guest searches the catalog; controller → service → repository → PostgreSQL (FR-05) |
| [Sequence: add copy](uml/seq-catalog-add-copy.puml) | Librarian adds a copy, including the duplicate-barcode error (FR-03) |
| [Domain class diagram](uml/class-domain.puml) | Principal domain classes, enums, associations and multiplicities |
| [ERD](uml/erd.puml) | PostgreSQL tables, keys, unique constraints and audit columns |
| [BookCopy state diagram](uml/state-book-copy.puml) | Lifecycle of a copy (`AVAILABLE` … `WITHDRAWN`) with FR-labelled transitions |

## Repository structure

| Folder | Contents |
|---|---|
| `docs/` | Requirements, incremental plan, architecture, AI log, traceability, testing, report |
| `uml/` | Editable diagram sources; exports in `uml/rendered/` |
| `src/` | Spring Boot application source (generated/maintained via Agentic AI) |
| `tests/` | Automated tests (unit, component, integration, system) |
| `prompts/` | Markdown records of every agent task |
| `data/` | Small synthetic sample data |
| `config/` | Configuration samples |
| `.claude/`, `CLAUDE.md` | Shared Claude Code rules, skills and hooks for the team |

## Incremental development

| Version | Capability introduced |
|---|---|
| v0.0.0 | Repository bootstrap (structure, Spring Boot skeleton, Claude rules) — not tagged |

Full plan: [docs/incremental_development_plan.md](docs/incremental_development_plan.md)

## Contributions

| Member | Main responsibility | Commits |
|---|---|---|
| _TBD_ | | |
