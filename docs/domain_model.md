# Domain Model — Library Management System (GP11)

Design checkpoint **v0.1.0-design**, Task D. Diagrams (editable sources in `uml/`, PNG in `uml/rendered/`):

| Diagram | Source | Purpose |
|---|---|---|
| Domain class diagram | [class-domain.puml](../uml/class-domain.puml) · [PNG](../uml/rendered/class-domain.png) | Principal domain classes, enums, associations, multiplicities |
| ERD | [erd.puml](../uml/erd.puml) · [PNG](../uml/rendered/erd.png) | PostgreSQL tables, keys, unique constraints, audit columns |
| BookCopy state diagram | [state-book-copy.puml](../uml/state-book-copy.puml) · [PNG](../uml/rendered/state-book-copy.png) | Lifecycle of a copy (`CopyStatus`) |

Class and status names follow the glossary in [project_description.md](project_description.md#6-glossary-shared-vocabulary--use-these-exact-names-in-uml-and-code).
Classes are grouped by the feature packages decided in [architecture.md](architecture.md):
`catalog`, `member`, `security`, `circulation`, `reservation`, `fine`, `notification`, plus `config` for `LendingPolicy`.

## 1. Classes

| Class | Package | Responsibility | Main requirements |
|---|---|---|---|
| `Title` | catalog | Catalog entry (ISBN, publisher, year, replacement price). Knows how many copies are available and whether it may be deactivated. | FR-01, FR-02, FR-05, FR-06 |
| `Author` | catalog | Person credited on a title. | FR-01, FR-05 |
| `Category` | catalog | Subject classification used for search. | FR-01, FR-05 |
| `BookCopy` | catalog | Physical item with unique barcode, shelf location and `CopyStatus`. | FR-03, FR-04, FR-13, FR-17 |
| `UserAccount` | security | Login (email, BCrypt hash), `Role`, enabled flag. | FR-09, FR-11, FR-12, NFR-01 |
| `Member` | member | Registered borrower: member number, expiry, suspension. Decides borrowing eligibility (BR-07). | FR-07, FR-08, FR-10 |
| `Loan` | circulation | Lending of one copy to one member; due date, renewals, status; overdue and renew logic. | FR-13–FR-21, BR-01–BR-03 |
| `Reservation` | reservation | A member's place in the FIFO queue for a title; becomes `READY` with a held copy for a limited time. | FR-22–FR-26, BR-06, BR-09 |
| `Fine` | fine | Amount owed for an overdue or lost copy; `outstanding()` = amount − payments (0 if waived). | FR-27–FR-30, BR-04, BR-05, BR-08 |
| `Payment` | fine | Simulated payment record for a fine (may be partial). | FR-29, FR-30 |
| `Notification` | notification | Simulated message to a member. | FR-31 |
| `LendingPolicy` | config | Value object holding BR-01–BR-06 and BR-10 values; passed into `Loan.renew`, `Reservation.markReady`, fine calculation. | FR-14, FR-21, FR-34 |

Enums: `CopyStatus`, `Role`, `LoanStatus`, `ReservationStatus`, `FineStatus` (all values exactly as in the glossary), plus two
additions that the glossary does not define: `FineType` (`OVERDUE`, `LOST`) and `NotificationType` (`DUE_SOON`, `OVERDUE`, `HOLD_READY`).

## 2. Multiplicity justification

| Association | Multiplicity | Justification |
|---|---|---|
| `Title` — `BookCopy` | 1 — 0..* (composition) | A title may have no copies yet (FR-01 before FR-03); a copy cannot exist without its title and is created through it (FR-03). |
| `Title` — `Author` | * — 1..* | Glossary: a title has one or more authors; an author may write many titles (FR-01). Realised by table `title_author`. |
| `Title` — `Category` | * — 1 | FR-01 requires exactly one category; many titles share it (FR-05 search by category). |
| `Member` — `UserAccount` | 1 — 1 | FR-07 creates a `MEMBER` account with every member. Staff accounts (`LIBRARIAN`, `ADMIN`) have no `Member`, so in the database the link is on `member.user_account_id`. |
| `Member` — `Loan` | 1 — 0..* | A member has any number of loans over time; only 5 may be active (BR-02, checked in the service layer). |
| `BookCopy` — `Loan` | 1 — 0..* | A copy is lent many times over its life, but at most one loan is active at a time (NFR-03, partial unique index). |
| `Member` — `Reservation` | 1 — 0..* | Reservation history is kept; at most 3 active (BR-09, service layer). |
| `Title` — `Reservation` | 1 — 0..* | Reservations are made per title, and form the FIFO queue (FR-22). |
| `Reservation` — `BookCopy` | 0..1 — 0..1 | A copy is attached only while the reservation is `READY` (FR-23, FR-26); a copy is held by at most one reservation. |
| `Loan` — `Fine` | 1 — 0..1 | One fine per loan: overdue on return (FR-27, BR-04) or lost (FR-28, BR-08), never both (BR-08 "instead of"). Table constraint `fine.loan_id UNIQUE`. |
| `Member` — `Fine` | 1 — 0..* | BR-05 needs the member's unpaid total; FR-30 lists the member's fines. |
| `Fine` — `Payment` | 1 — 0..* (composition) | Partial payments are allowed (FR-29); a payment has no meaning without its fine. |
| `Member` — `Notification` | 1 — 0..* | Members see their notifications on the dashboard (FR-31). |
| `Loan`/`Fine`/`Payment` — `UserAccount` | * — 1 or 0..1 | Audit trail: who checked out, returned, renewed, created, waived, recorded (NFR-09). Optional where the action may not have happened yet. |

## 3. Key design decisions

1. **Email lives only in `UserAccount`.** A member's email is the login email (FR-07, FR-09); storing it twice would allow
   inconsistent values. Member search by email (FR-10) joins `member → user_account`. The unique-email constraint is on `user_account.email`.
2. **Copy status is stored on `BookCopy`; loan and reservation have their own status.** `ON_LOAN` and `ON_HOLD` must always agree with
   the active `Loan` / `READY` `Reservation`. These changes happen in one transaction in the service layer (NFR-03, NFR-06).
3. **Active loan = `ACTIVE` or `OVERDUE`.** The database enforces "one active loan per copy" with a partial unique index (see ERD note).
4. **Partial payments keep a fine `UNPAID`.** `FineStatus` has only `UNPAID`, `PAID`, `WAIVED`. `Fine.outstanding()` is computed from
   the payments; the status becomes `PAID` when it reaches zero. BR-05 sums `outstanding()` of `UNPAID` fines.
5. **Renewal audit is kept on the loan** (`last_renewed_by`, `last_renewed_at`, `renewal_count`) instead of a separate `Renewal` class,
   to keep the class list of this increment small. If a full renewal history is needed later (reports), a `Renewal` table can be added in a later design increment.
6. **`LendingPolicy` is a value object, stored as a one-row table `lending_policy`.** Defaults come from the `library.policy.*`
   configuration (see architecture decisions); the administrator can update them (FR-34). *Review point for the team: this slightly extends the
   "stored as configuration" decision in `architecture.md`.*
7. **One active reservation per member and title** (partial unique index on `reservation`). This is not stated in BR-09 explicitly; it avoids a member holding two queue places for the same title.
8. **Money uses `numeric(8,3)` / `BigDecimal`** because BR-04 is 0.250 JOD per day (three decimals, JOD has 1000 fils).
9. **Fields named `read` / `status` / `type`** are stored as `is_read`, `status`, `fine_type`, `notification_type` to avoid SQL reserved words.

## 4. Class diagram ↔ ERD consistency

| Class | Table | Notes |
|---|---|---|
| `Title` | `title` | `Category` association → `category_id` FK |
| `Author` | `author` | many-to-many through `title_author` (adds `author_order`) |
| `Category` | `category` | |
| `BookCopy` | `book_copy` | `title_id` FK |
| `UserAccount` | `user_account` | `role` stored as string of `Role` |
| `Member` | `member` | `user_account_id` FK, unique |
| `Loan` | `loan` | FKs `copy_id`, `member_id`; audit FKs |
| `Reservation` | `reservation` | FKs `title_id`, `member_id`, nullable `held_copy_id` |
| `Fine` | `fine` | `loan_id` unique, `member_id` |
| `Payment` | `payment` | `fine_id` |
| `Notification` | `notification` | `member_id` |
| `LendingPolicy` | `lending_policy` | single row, `id = 1` |

Enums are stored as `varchar` columns (`status`, `role`, `fine_type`, `notification_type`) with values identical to the enum constants.

## 5. BookCopy state transitions

| From | To | Trigger | Requirement | Guard / effect |
|---|---|---|---|---|
| — | `AVAILABLE` | Add copy | FR-03 | Unique barcode |
| `AVAILABLE` | `ON_LOAN` | Checkout | FR-13, FR-14 | Member eligible (BR-02, BR-05, BR-07); creates `Loan` |
| `ON_LOAN` | `AVAILABLE` | Return, no reservation waiting | FR-17 | Loan → `RETURNED`; overdue fine if late (FR-27) |
| `ON_LOAN` | `ON_HOLD` | Return, reservation waiting | FR-17, FR-23 | First `WAITING` reservation → `READY`, member notified |
| `ON_LOAN` | `LOST` | Mark lost | FR-20 | Loan → `LOST`; fine = replacement price (FR-28) |
| `ON_HOLD` | `ON_LOAN` | Checkout to the `READY` reservation's member | FR-26 | Reservation → `FULFILLED` |
| `ON_HOLD` | `ON_HOLD` | Hold expires, next `WAITING` reservation | FR-24 | Old reservation → `EXPIRED` (BR-06) |
| `ON_HOLD` | `AVAILABLE` | Hold expires or is cancelled, queue empty | FR-24, FR-25 | |
| `AVAILABLE` | `DAMAGED` / `LOST` / `WITHDRAWN` | Librarian sets status | FR-04 | Only when not on loan or on hold |
| `DAMAGED` / `LOST` / `WITHDRAWN` | `AVAILABLE` | Librarian restores | FR-04 | |

FR-04 also allows changing between `DAMAGED`, `LOST` and `WITHDRAWN` directly; this is stated in a note on the diagram to keep it readable.
FR-04 changes are refused in `ON_LOAN` and `ON_HOLD`, which matches the diagram (no librarian transition leaves those states except through circulation actions).
