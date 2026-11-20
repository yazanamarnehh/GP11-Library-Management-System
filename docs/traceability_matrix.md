# Traceability Matrix — GP11

Requirement → design → implementation → test. Status: **Planned** (in plan only) → **Designed**
(UML merged) → **Implemented** (code merged) → **Verified** (tests pass). Update the row in the same
branch that changes its status.

| Requirement ID | Use Case / Design Element | Increment / Version | Implementation Module(s) | Test(s) | Status |
|---|---|---|---|---|---|
| — | Health endpoint (technical, bootstrap) | v0.0.0 | `src/main/java/edu/psut/se/gp11/library/health/HealthController.java` | `tests/java/edu/psut/se/gp11/library/health/HealthControllerTest.java` | Verified |
| FR-01 | UC Manage titles; `Title`, `Author`, `Category` | v0.1.0 | planned: `catalog` | planned | Planned |
| FR-02 | UC Manage titles; `Title` | v0.1.0 | planned: `catalog` | planned | Planned |
| FR-03 | UC Manage copies; `BookCopy` | v0.1.0 | planned: `catalog` | planned | Planned |
| FR-04 | UC Manage copies; `state-book-copy` | v0.1.0 | planned: `catalog` | planned | Planned |
| FR-05 | UC Search catalog; `seq-catalog-search` | v0.1.0 | planned: `catalog` | planned | Planned |
| FR-06 | UC View title details | v0.1.0 | planned: `catalog` | planned | Planned |
| FR-07 | UC Register member; `Member`, `UserAccount` | v0.2.0 | planned: `member` | planned | Planned |
| FR-08 | UC Manage member | v0.2.0 | planned: `member` | planned | Planned |
| FR-09 | UC Log in; `UserAccount`, `Role` | v0.2.0 | planned: `security` | planned | Planned |
| FR-10 | UC Search members | v0.2.0 | planned: `member` | planned | Planned |
| FR-11 | UC Manage staff accounts | v0.2.0 | planned: `security` | planned | Planned |
| FR-12 | UC Change password | v0.2.0 | planned: `security` | planned | Planned |
| FR-13 | UC Check out copy; `Loan` | v0.3.0 | planned: `circulation` | planned | Planned |
| FR-14 | UC Check out copy; `Loan.dueDate` | v0.3.0 | planned: `circulation` | planned | Planned |
| FR-15 | UC View my loans | v0.3.0 | planned: `circulation` | planned | Planned |
| FR-16 | UC View member loans | v0.3.0 | planned: `circulation` | planned | Planned |
| FR-17 | UC Return copy | v0.4.0 | planned: `circulation` | planned | Planned |
| FR-18 | UC Detect overdue loans (Scheduler) | v0.4.0 | planned: `circulation` | planned | Planned |
| FR-19 | UC View overdue loans | v0.4.0 | planned: `circulation` | planned | Planned |
| FR-20 | UC Mark copy lost | v0.4.0 | planned: `circulation` | planned | Planned |
| FR-21 | UC Renew loan | v0.5.0 | planned: `circulation` | planned | Planned |
| FR-22 | UC Reserve title; `Reservation` | v0.6.0 | planned: `reservation` | planned | Planned |
| FR-23 | UC Allocate hold (System) | v0.6.0 | planned: `reservation` | planned | Planned |
| FR-24 | UC Expire holds (Scheduler) | v0.6.0 | planned: `reservation` | planned | Planned |
| FR-25 | UC Manage my reservations | v0.6.0 | planned: `reservation` | planned | Planned |
| FR-26 | UC Check out held copy | v0.6.0 | planned: `reservation`, `circulation` | planned | Planned |
| FR-27 | UC Calculate overdue fine; `Fine` | v0.7.0 | planned: `fine` | planned | Planned |
| FR-28 | UC Charge lost copy | v0.7.0 | planned: `fine` | planned | Planned |
| FR-29 | UC Record payment / waive fine; `Payment` | v0.7.0 | planned: `fine` | planned | Planned |
| FR-30 | UC View my fines | v0.7.0 | planned: `fine` | planned | Planned |
| FR-31 | UC Send notifications; `Notification` | v0.8.0 | planned: `notification` | planned | Planned |
| FR-32 | UC View borrowing history | v0.8.0 | planned: `report` | planned | Planned |
| FR-33 | UC View reports | v0.8.0 | planned: `report` | planned | Planned |
| FR-34 | UC Configure lending policy | v0.8.0 | planned: `report` / config | planned | Planned |
