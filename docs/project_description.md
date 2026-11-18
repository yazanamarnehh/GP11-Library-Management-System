# Project Description — Library Management System (GP11)

## 1. Problem statement

A small academic or public library manages its collection, its members and its circulation
(lending) with spreadsheets and paper cards. This causes recurring problems:

- Members cannot see whether a book is available without coming to the desk.
- Librarians cannot reliably tell who has a copy, when it is due, or which loans are overdue.
- Renewals, reservations and fines are calculated by hand, inconsistently.
- There are no reliable figures on how the collection is used.

The **Library Management System (LMS)** is a web application that keeps the catalog, members and
every loan, reservation and fine in one database, enforces the library's lending rules
automatically, and gives members self-service access to search, renew and reserve.

## 2. Goals

1. A searchable online catalog showing real-time availability of every title.
2. Fast, rule-checked checkout and return at the desk.
3. Member self-service: view loans, renew, reserve, see fines and history.
4. Automatic due dates, overdue detection, fines and reservation queues.
5. Reports that help the library manage its collection and circulation.

## 3. Scope

**In scope**

- Catalog of titles (books and other resources) and their physical copies
- Member registration and management; role-based login (Member, Librarian, Administrator)
- Checkout, return, renewal, due dates and overdue detection
- Reservations (holds) with a first-come-first-served queue
- Overdue and lost-item fines; simulated fine payment and waivers
- Notifications (due soon, overdue, hold ready) — **simulated**, written to an in-app log
- Reports for librarians

**Out of scope**

- Real payment processing, real email/SMS delivery
- Acquisitions/purchasing, inter-library loans, digital e-book lending
- Barcode scanner hardware (barcodes are typed or pasted)
- Multiple library branches

## 4. Stakeholders and actors

| Actor | Type | Description |
|---|---|---|
| Member | Primary | Registered borrower (student, staff or public). Searches, borrows, renews, reserves, views fines. |
| Librarian | Primary | Library staff at the desk. Manages catalog, members, checkout/return, fines, reports. |
| Administrator | Primary | Manages librarian/admin accounts and system configuration. |
| Guest | Primary | Unauthenticated visitor; may only search the catalog. |
| Scheduler | System | Time-triggered job inside the application (overdue detection, hold expiry, due-soon notices). |
| Notification service | External (mocked) | Would send email; simulated by an in-app notification log. |
| Library management | Stakeholder | Uses reports; sets lending policy. |

## 5. Assumptions

- A1. Single library branch; all copies belong to it.
- A2. Synthetic demonstration data only — no real personal data.
- A3. Currency is the Jordanian Dinar (JOD); amounts are stored with 3 decimals.
- A4. Email and payment are simulated (see scope). A "payment" is a librarian recording that cash was received.
- A5. A member account is created by a librarian (no public self-registration).
- A6. The business rules in `requirements.md` (BR-xx) are fixed for the demo but stored as configuration so they can change without code changes.
- A7. Users access the system through a modern desktop web browser.
- A8. Time-based behaviour (overdue, hold expiry) can be triggered manually in the demo by the Scheduler endpoint or by adjusting dates in seed data.

## 6. Glossary (shared vocabulary — use these exact names in UML and code)

| Term | Meaning |
|---|---|
| **Title** | A catalog entry describing a work: ISBN, title, authors, publisher, year, category. One title has many copies. (Class name: `Title`.) |
| **Copy** | A physical item of a title with a unique barcode and shelf location. (Class: `BookCopy`.) |
| **Copy status** | `AVAILABLE`, `ON_LOAN`, `ON_HOLD`, `LOST`, `DAMAGED`, `WITHDRAWN`. |
| **Author** | Person credited on a title. A title has one or more authors. |
| **Category** | Subject classification of a title (e.g. Computer Science). |
| **Member** | A registered borrower with a unique member number and membership expiry date. |
| **User account** | Login credentials and role (`MEMBER`, `LIBRARIAN`, `ADMIN`). (Class: `UserAccount`.) |
| **Loan** | Lending of one copy to one member: checkout date, due date, return date, renewal count. Status `ACTIVE`, `OVERDUE`, `RETURNED`, `LOST`. |
| **Renewal** | Extending an active loan's due date. |
| **Reservation** (hold) | A member's request for a title with no available copy. Status `WAITING`, `READY`, `FULFILLED`, `CANCELLED`, `EXPIRED`. |
| **Fine** | Amount owed for an overdue or lost copy. Status `UNPAID`, `PAID`, `WAIVED`. |
| **Payment** | Simulated record that a fine (or part of it) was paid. |
| **Notification** | Simulated message to a member (due soon, overdue, hold ready). |
