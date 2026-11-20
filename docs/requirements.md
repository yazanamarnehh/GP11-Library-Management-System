# Requirements — Library Management System (GP11)

Requirement IDs are referenced by the incremental plan, UML, prompt records, code, tests and the
traceability matrix. **Never renumber an existing ID**; mark it "Deprecated" instead and add a new one.
Terms follow the glossary in [project_description.md](project_description.md#6-glossary-shared-vocabulary--use-these-exact-names-in-uml-and-code).

Priority (MoSCoW): **M** = Must, **S** = Should, **C** = Could.

## 1. Functional requirements

### 1.1 Catalog — increment v0.1.0

| ID | Requirement | Actor | Priority |
|---|---|---|---|
| FR-01 | The librarian shall add a title with ISBN, title, one or more authors, publisher, publication year, category, description and replacement price. ISBN must be unique and valid (ISBN-10 or ISBN-13). | Librarian | M |
| FR-02 | The librarian shall edit a title's details and deactivate a title. A title with a copy on loan or on hold cannot be deactivated. | Librarian | M |
| FR-03 | The librarian shall add one or more copies to a title, each with a unique barcode and a shelf location. A new copy has status `AVAILABLE`. | Librarian | M |
| FR-04 | The librarian shall change a copy's status to `DAMAGED`, `LOST` or `WITHDRAWN`, or back to `AVAILABLE`, when the copy is not on loan or on hold. | Librarian | M |
| FR-05 | Any user, including a guest, shall search active titles by keyword (title or author), ISBN or category, and see each result's number of available copies. | Guest, Member, Librarian | M |
| FR-06 | Any user shall view a title's details, including its copies with status and shelf location. | Guest, Member, Librarian | M |

### 1.2 Members and accounts — v0.2.0

| ID | Requirement | Actor | Priority |
|---|---|---|---|
| FR-07 | The librarian shall register a member (name, email, phone, membership expiry date). The system assigns a unique member number and creates a `MEMBER` user account. | Librarian | M |
| FR-08 | The librarian shall edit a member's details, renew the membership expiry date, and suspend or reactivate a member. | Librarian | M |
| FR-09 | Users shall log in and out with email and password; every page and action is authorised by role (`MEMBER`, `LIBRARIAN`, `ADMIN`). | All | M |
| FR-10 | The librarian shall search members by name, email or member number. | Librarian | M |
| FR-11 | The administrator shall create, disable and re-enable librarian and administrator accounts. | Administrator | S |
| FR-12 | A logged-in user shall change their own password. | All | S |

### 1.3 Borrowing — v0.3.0

| ID | Requirement | Actor | Priority |
|---|---|---|---|
| FR-13 | The librarian shall check out an `AVAILABLE` copy (by barcode) to a member (by member number). The system shall reject the checkout if any eligibility rule fails (BR-02, BR-05, BR-07) and show the reason. | Librarian | M |
| FR-14 | On checkout the system shall set the due date to checkout date + loan period (BR-01) and set the copy to `ON_LOAN`. | System | M |
| FR-15 | A member shall view their active loans with due dates and days remaining. | Member | M |
| FR-16 | The librarian shall view a member's active loans. | Librarian | M |

### 1.4 Returns and overdue — v0.4.0

| ID | Requirement | Actor | Priority |
|---|---|---|---|
| FR-17 | The librarian shall return a copy by barcode. The loan is closed with the return date, and the copy becomes `AVAILABLE` (or `ON_HOLD` if a reservation is waiting — from v0.6.0). | Librarian | M |
| FR-18 | Once a day the system shall mark active loans past their due date as `OVERDUE`. | Scheduler | M |
| FR-19 | The librarian shall view a list of overdue loans with member, title and days overdue. | Librarian | M |
| FR-20 | The librarian shall mark a loaned copy as lost; the loan becomes `LOST` and the copy `LOST`. | Librarian | S |

### 1.5 Renewals — v0.5.0

| ID | Requirement | Actor | Priority |
|---|---|---|---|
| FR-21 | A member (for own loans) or a librarian shall renew an active or overdue loan, setting a new due date per BR-03, if renewal rules allow (BR-03, BR-05, BR-07). The reason is shown when refused. | Member, Librarian | M |

### 1.6 Reservations — v0.6.0

| ID | Requirement | Actor | Priority |
|---|---|---|---|
| FR-22 | A member shall reserve a title that has no `AVAILABLE` copy (BR-09). Reservations of a title form a first-come-first-served queue. | Member | M |
| FR-23 | When a copy of a reserved title is returned, the system shall set it `ON_HOLD` for the first `WAITING` reservation, mark that reservation `READY` and notify the member. | System | M |
| FR-24 | A `READY` reservation not collected within the hold period (BR-06) shall expire, and the copy passes to the next reservation or becomes `AVAILABLE`. | Scheduler | M |
| FR-25 | A member shall view and cancel their reservations, and see their queue position. | Member | M |
| FR-26 | A copy that is `ON_HOLD` may only be checked out to the member whose reservation is `READY`; that reservation becomes `FULFILLED`. | Librarian | M |

### 1.7 Fines — v0.7.0

| ID | Requirement | Actor | Priority |
|---|---|---|---|
| FR-27 | When an overdue loan is returned, the system shall create a fine per BR-04. | System | M |
| FR-28 | When a loan is marked lost, the system shall create a fine equal to the title's replacement price (BR-08). | System | M |
| FR-29 | The librarian shall record a (simulated) payment of a fine, fully or partly, or waive it with a reason. | Librarian | M |
| FR-30 | A member shall view their fines, payments and outstanding balance. | Member | M |

### 1.8 Notifications and reports — v0.8.0

| ID | Requirement | Actor | Priority |
|---|---|---|---|
| FR-31 | The system shall create simulated notifications for: loan due soon (BR-10), loan overdue, and reservation ready. Members see them on their dashboard. | Scheduler, System | S |
| FR-32 | A member shall view their borrowing history. | Member | S |
| FR-33 | The librarian shall view reports: active and overdue loans, most-borrowed titles in a date range, fines collected and outstanding; and export them as CSV. | Librarian | S |
| FR-34 | The administrator shall view and update the lending-policy values (BR-01 – BR-06, BR-10). | Administrator | C |

## 2. Non-functional requirements

| ID | Requirement | Category | Measure / acceptance |
|---|---|---|---|
| NFR-01 | Passwords are stored only as BCrypt hashes; every request is authorised by role on the server. | Security | Code review + tests that each protected URL rejects other roles |
| NFR-02 | Catalog search responds quickly. | Performance | ≤ 2 s for a search over 10,000 copies on a developer laptop |
| NFR-03 | A copy can never be in more than one active loan; checkout, return and renewal are transactional. | Data integrity | DB unique constraint + concurrency test |
| NFR-04 | All data is persisted in PostgreSQL; schema changes are versioned migrations. | Persistence | Flyway migrations in the repo; app starts on an empty DB |
| NFR-05 | The system starts with one command (application + PostgreSQL). | Portability | `docker compose up` documented in README |
| NFR-06 | Layered architecture (web → service → repository); business rules live only in the service layer. | Maintainability | Architecture review against `docs/architecture.md` |
| NFR-07 | Every increment has automated tests that run with `./mvnw verify`, including integration tests against a real PostgreSQL (Testcontainers). | Testability | CI/local run green; service-layer line coverage ≥ 70 % |
| NFR-08 | Main tasks (search, checkout, return, renew, reserve) are reachable in at most 3 clicks from the user's home page, with clear error messages. | Usability | Walkthrough during demo |
| NFR-09 | Checkout, return, renewal, fine and payment records store who performed them and when. | Auditability | Fields present in ERD and visible to librarians |
| NFR-10 | Only synthetic data is used; no secrets in the repository. | Privacy | Repository review |

## 3. Business rules

| ID | Rule |
|---|---|
| BR-01 | Loan period is **14 days**. |
| BR-02 | A member may have at most **5** active (incl. overdue) loans. |
| BR-03 | A loan may be renewed at most **2** times. Each renewal sets the due date to renewal date + 14 days. Renewal is refused if the title has a `WAITING` reservation by another member. |
| BR-04 | Overdue fine is **0.250 JOD per day** late, capped at the title's replacement price. |
| BR-05 | A member whose unpaid fines total more than **5.000 JOD** cannot borrow or renew. |
| BR-06 | A `READY` reservation is held for **3 days**, then expires. |
| BR-07 | A suspended member, or one whose membership has expired, cannot borrow, renew or reserve. |
| BR-08 | A lost copy is charged at the title's replacement price (instead of an overdue fine). |
| BR-09 | A member cannot reserve a title that has an `AVAILABLE` copy, or one they currently have on loan; at most **3** active reservations per member. |
| BR-10 | A due-soon notification is created **2 days** before the due date. |
