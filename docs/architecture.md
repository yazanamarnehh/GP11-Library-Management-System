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
| Database | _TBD_ | |
| UI | _TBD_ | |

## 6. Design decisions log

| Date | Decision | Reason | Affected diagrams |
|---|---|---|---|
| 2026-11-17 | Spring Boot + Maven skeleton; tests in `tests/java` | Match mandatory repo layout | — |
