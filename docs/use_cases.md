# Use Cases — Library Management System (GP11)

Version: **v0.1.0-design** (Task C). Diagram: [`uml/use-case.puml`](../uml/use-case.puml)
(rendered in three pages: [1 — catalog and accounts](../uml/rendered/use-case.png),
[2 — circulation and reservations](../uml/rendered/use-case_001.png),
[3 — fines, notifications and reports](../uml/rendered/use-case_002.png)).

Requirement IDs (FR, NFR, BR) refer to [requirements.md](requirements.md). Names of actors,
classes and statuses follow the glossary in
[project_description.md](project_description.md#6-glossary-shared-vocabulary--use-these-exact-names-in-uml-and-code).

## 1. Actors

| Actor | Kind | Use cases |
|---|---|---|
| Guest | Primary, not logged in | UC-01, UC-02 |
| Member | Primary; specialises Guest (inherits UC-01, UC-02) | UC-07, UC-10, UC-13, UC-19, UC-20, UC-23, UC-28, UC-30 |
| Librarian | Primary | UC-01–UC-08, UC-11, UC-14, UC-15, UC-17, UC-18, UC-19, UC-27, UC-31 |
| Administrator | Primary | UC-07, UC-09, UC-10, UC-32 |
| Scheduler | System actor (timed job inside the application) | UC-16, UC-22, UC-29 |

## 2. Use case list

| ID | Use case | Primary actor | Requirements | Increment |
|---|---|---|---|---|
| UC-01 | Search catalog | Guest, Member, Librarian | FR-05, NFR-02 | v0.1.0 |
| UC-02 | View title details | Guest, Member, Librarian | FR-06 | v0.1.0 |
| UC-03 | Manage titles | Librarian | FR-01, FR-02 | v0.1.0 |
| UC-04 | Manage copies | Librarian | FR-03, FR-04 | v0.1.0 |
| UC-05 | Register member | Librarian | FR-07 | v0.2.0 |
| UC-06 | Manage member | Librarian | FR-08 | v0.2.0 |
| UC-07 | Log in / log out | Member, Librarian, Administrator | FR-09, NFR-01 | v0.2.0 |
| UC-08 | Search members | Librarian | FR-10 | v0.2.0 |
| UC-09 | Manage staff accounts | Administrator | FR-11 | v0.2.0 |
| UC-10 | Change password | Member, Librarian, Administrator | FR-12 | v0.2.0 |
| UC-11 | Check out copy | Librarian | FR-13, FR-14 | v0.3.0 |
| UC-12 | Verify member eligibility (included) | — | BR-02, BR-05, BR-07 | v0.3.0 |
| UC-13 | View my loans | Member | FR-15 | v0.3.0 |
| UC-14 | View member loans | Librarian | FR-16 | v0.3.0 |
| UC-15 | Return copy | Librarian | FR-17 | v0.4.0 |
| UC-16 | Detect overdue loans | Scheduler | FR-18 | v0.4.0 |
| UC-17 | View overdue loans | Librarian | FR-19 | v0.4.0 |
| UC-18 | Mark copy lost | Librarian | FR-20 | v0.4.0 |
| UC-19 | Renew loan | Member, Librarian | FR-21, BR-03 | v0.5.0 |
| UC-20 | Reserve title | Member | FR-22, BR-09 | v0.6.0 |
| UC-21 | Allocate hold (extends UC-15) | System | FR-23 | v0.6.0 |
| UC-22 | Expire holds | Scheduler | FR-24, BR-06 | v0.6.0 |
| UC-23 | Manage my reservations | Member | FR-25 | v0.6.0 |
| UC-24 | Check out held copy (extends UC-11) | Librarian | FR-26 | v0.6.0 |
| UC-25 | Calculate overdue fine (extends UC-15) | System | FR-27, BR-04 | v0.7.0 |
| UC-26 | Charge lost copy (included by UC-18) | System | FR-28, BR-08 | v0.7.0 |
| UC-27 | Record payment / waive fine | Librarian | FR-29 | v0.7.0 |
| UC-28 | View my fines | Member | FR-30 | v0.7.0 |
| UC-29 | Send notifications | Scheduler, System | FR-31, BR-10 | v0.8.0 |
| UC-30 | View borrowing history | Member | FR-32 | v0.8.0 |
| UC-31 | View reports | Librarian | FR-33 | v0.8.0 |
| UC-32 | Configure lending policy | Administrator | FR-34 | v0.8.0 |

### Why these relationships

- **Member → Guest (generalisation):** a member can do everything a guest can (search and view
  titles) plus more.
- **«include» UC-12 Verify member eligibility:** checkout, renewal and reservation *always* check
  the same member rules (suspended/expired — BR-07, fines over 5.000 JOD — BR-05, loan limit — BR-02),
  so the check is written once and reused.
- **«include» UC-26 Charge lost copy:** marking a copy lost *always* creates the replacement-price fine.
- **«include» UC-29 Send notifications:** allocating a hold *always* notifies the member.
- **«extend» UC-21 Allocate hold → UC-15 Return copy:** only *when* a `WAITING` reservation exists.
- **«extend» UC-25 Calculate overdue fine → UC-15 Return copy:** only *when* the loan is `OVERDUE`.
- **«extend» UC-24 Check out held copy → UC-11 Check out copy:** only *when* the copy is `ON_HOLD`.

---

## 3. Detailed use case descriptions (important use cases)

### UC-01 Search catalog

| Field | Value |
|---|---|
| Actors | Guest (primary); Member, Librarian |
| Related requirements | FR-05, NFR-02, NFR-08 |
| Increment | v0.1.0 |
| Sequence diagram | [`uml/seq-catalog-search.puml`](../uml/seq-catalog-search.puml) |
| Preconditions | The catalog page is reachable (no login required). |
| Postconditions | The user sees the matching active titles with their number of `AVAILABLE` copies. Nothing is changed in the database. |

**Main success scenario**

1. The user opens the catalog search page.
2. The user chooses a search type (keyword in title/author, ISBN, or category) and enters a search term.
3. The system validates the input.
4. The system finds all **active** titles that match.
5. For each title, the system counts its copies with status `AVAILABLE`.
6. The system shows the results: title, authors, year, category and number of available copies.
7. The user may select a result to view its details (UC-02).

**Alternative / exception flows**

- 3a. The search term is empty → the system shows "Please enter a search term" and stays on step 2.
- 3b. The ISBN has an invalid format → the system shows "Invalid ISBN" and stays on step 2.
- 4a. No title matches → the system shows "No titles found" and suggests changing the search.
- 6a. A title has no available copies → it is still shown, with "0 available" (a member may reserve it — UC-20).

---

### UC-03 Manage titles

| Field | Value |
|---|---|
| Actors | Librarian |
| Related requirements | FR-01, FR-02, NFR-01 |
| Increment | v0.1.0 |
| Preconditions | The librarian is logged in with role `LIBRARIAN` (from v0.2.0; in v0.1.0 the librarian pages are not yet protected). |
| Postconditions | The title is saved (added, edited or deactivated) and appears accordingly in search. |

**Main success scenario (add a title)**

1. The librarian opens "Add title".
2. The librarian enters ISBN, title, one or more authors, publisher, publication year, category,
   description and replacement price.
3. The system checks that all required fields are filled, that the ISBN is a valid ISBN-10 or ISBN-13,
   and that no other title has this ISBN.
4. The system saves the title as active.
5. The system shows the new title's details page with a success message.

**Alternative / exception flows**

- 3a. A required field is missing or invalid (e.g. negative price) → the system highlights the field and the librarian corrects it.
- 3b. The ISBN is invalid → "Invalid ISBN".
- 3c. The ISBN already exists → "A title with this ISBN already exists" with a link to that title.
- E1. **Edit title:** the librarian opens an existing title, changes details and saves; the same checks as step 3 apply.
- E2. **Deactivate title:** the librarian chooses "Deactivate". If any copy of the title is `ON_LOAN`
  or `ON_HOLD`, the system refuses: "Title has copies on loan or on hold" (FR-02). Otherwise the
  title is marked inactive and no longer appears in search.

---

### UC-04 Manage copies

| Field | Value |
|---|---|
| Actors | Librarian |
| Related requirements | FR-03, FR-04 |
| Increment | v0.1.0 |
| Sequence diagram | [`uml/seq-catalog-add-copy.puml`](../uml/seq-catalog-add-copy.puml) |
| State diagram | `uml/state-book-copy.puml` (Task D) |
| Preconditions | The librarian is logged in; the title exists and is active. |
| Postconditions | The new copy exists with status `AVAILABLE`, or the copy's status is changed. |

**Main success scenario (add a copy)**

1. The librarian opens a title's details page and chooses "Add copy".
2. The librarian enters the copy's barcode and shelf location.
3. The system checks that the barcode is not used by any other copy.
4. The system saves the copy with status `AVAILABLE`, linked to the title.
5. The system shows the title's details with the new copy in the list and a success message.
6. To add more copies, the librarian repeats steps 1–5.

**Alternative / exception flows**

- 2a. Barcode or shelf location is empty → "Barcode and shelf location are required".
- 3a. The barcode already exists → the system does **not** save and shows "Barcode already in use"; the librarian enters another barcode.
- 1a. The title is not found or inactive → "Title not found".
- E1. **Change copy status:** the librarian selects a copy and sets it to `DAMAGED`, `LOST`, `WITHDRAWN`
  or back to `AVAILABLE`. If the copy is `ON_LOAN` or `ON_HOLD`, the system refuses:
  "Copy is on loan or on hold" (FR-04).

---

### UC-11 Check out copy

| Field | Value |
|---|---|
| Actors | Librarian |
| Related requirements | FR-13, FR-14, BR-01, BR-02, BR-05, BR-07, NFR-03, NFR-09 |
| Includes | UC-12 Verify member eligibility |
| Extended by | UC-24 Check out held copy [copy is `ON_HOLD`] |
| Increment | v0.3.0 |
| Preconditions | The librarian is logged in; the member is at the desk with the copy. |
| Postconditions | A new `ACTIVE` loan exists with due date = today + 14 days; the copy is `ON_LOAN`; the librarian and time are recorded. |

**Main success scenario**

1. The librarian enters the member number.
2. The librarian scans or types the copy's barcode.
3. The system verifies the member's eligibility (**include UC-12**):
   member is not suspended and membership not expired (BR-07); unpaid fines ≤ 5.000 JOD (BR-05);
   fewer than 5 active or overdue loans (BR-02).
4. The system checks that the copy is `AVAILABLE`.
5. The system creates the loan with checkout date = today and due date = today + 14 days (BR-01, FR-14),
   recording who performed it and when (NFR-09).
6. The system sets the copy to `ON_LOAN`.
7. The system shows a confirmation with the title and due date.

**Alternative / exception flows**

- 1a. Member number not found → "Member not found".
- 2a. Barcode not found → "Copy not found".
- 3a. Any eligibility rule fails → the checkout is refused and the reason is shown (e.g. "Member has 5 active loans") (FR-13).
- 4a. Copy is `ON_HOLD` → continue with **UC-24 Check out held copy**: allowed only for the member whose reservation is `READY`; that reservation becomes `FULFILLED` (FR-26).
- 4b. Copy is `ON_LOAN`, `LOST`, `DAMAGED` or `WITHDRAWN` → "Copy is not available for loan".
- 5a. Two librarians check out the same copy at the same moment → only one succeeds; the database
  allows at most one active loan per copy (NFR-03).

---

### UC-15 Return copy

| Field | Value |
|---|---|
| Actors | Librarian |
| Related requirements | FR-17, NFR-03, NFR-09 |
| Extended by | UC-21 Allocate hold [a `WAITING` reservation exists]; UC-25 Calculate overdue fine [loan is `OVERDUE`] |
| Increment | v0.4.0 (extensions in v0.6.0 and v0.7.0) |
| Preconditions | The librarian is logged in; the copy has an `ACTIVE` or `OVERDUE` loan. |
| Postconditions | The loan is `RETURNED` with a return date; the copy is `AVAILABLE` or `ON_HOLD`; a fine exists if the loan was late. |

**Main success scenario**

1. The librarian scans or types the barcode of the returned copy.
2. The system finds the copy's open loan.
3. The system closes the loan: status `RETURNED`, return date = today, recording who and when.
4. The system sets the copy to `AVAILABLE`.
5. The system shows a confirmation with the member's name and the title.

**Alternative / exception flows**

- 2a. No open loan for this copy → "This copy is not on loan".
- 3a. The loan was `OVERDUE` → **extend UC-25**: the system creates a fine of 0.250 JOD per day late,
  capped at the replacement price (BR-04, FR-27), and shows it.
- 4a. The title has a `WAITING` reservation → **extend UC-21**: instead of `AVAILABLE`, the copy
  becomes `ON_HOLD` for the first reservation in the queue, that reservation becomes `READY`, and the
  member is notified (FR-23). The confirmation tells the librarian to put the copy on the hold shelf.

---

### UC-19 Renew loan

| Field | Value |
|---|---|
| Actors | Member (own loans), Librarian (any loan) |
| Related requirements | FR-21, BR-03, BR-05, BR-07 |
| Includes | UC-12 Verify member eligibility |
| Increment | v0.5.0 |
| Preconditions | The user is logged in; the loan is `ACTIVE` or `OVERDUE`. |
| Postconditions | The loan's due date = renewal date + 14 days, renewal count increased by 1, status `ACTIVE`. |

**Main success scenario**

1. The member opens "My loans" (or the librarian opens the member's loans).
2. The user chooses "Renew" on a loan.
3. The system verifies eligibility (**include UC-12**): not suspended/expired (BR-07), fines ≤ 5.000 JOD (BR-05).
4. The system checks that the loan has been renewed fewer than 2 times (BR-03).
5. The system checks that no **other** member has a `WAITING` reservation for this title (BR-03).
6. The system sets the new due date to today + 14 days and increases the renewal count.
7. The system shows the new due date.

**Alternative / exception flows**

- 1a. A member tries to renew a loan that is not theirs → refused (access denied, NFR-01).
- 3a. Eligibility fails → refused with the reason.
- 4a. Already renewed 2 times → "Maximum renewals reached".
- 5a. Another member is waiting → "This title is reserved by another member".

---

### UC-20 Reserve title

| Field | Value |
|---|---|
| Actors | Member |
| Related requirements | FR-22, FR-25, BR-07, BR-09 |
| Includes | UC-12 Verify member eligibility |
| Increment | v0.6.0 |
| Preconditions | The member is logged in and is viewing a title (UC-02). |
| Postconditions | A `WAITING` reservation is added at the end of the title's queue. |

**Main success scenario**

1. The member views a title with 0 available copies and chooses "Reserve".
2. The system verifies eligibility (**include UC-12**): not suspended/expired (BR-07).
3. The system checks the reservation rules (BR-09): the title has no `AVAILABLE` copy; the member
   does not currently have this title on loan; the member has fewer than 3 active reservations.
4. The system creates the reservation with status `WAITING` and the current date/time (queue order).
5. The system shows the member's queue position.

**Alternative / exception flows**

- 2a. Member not eligible → refused with the reason.
- 3a. A copy is available → "A copy is available — borrow it at the desk".
- 3b. The member already has this title on loan → "You already have this title".
- 3c. The member has 3 active reservations → "Reservation limit reached".
- 3d. The member already has a reservation for this title → "You have already reserved this title".

---

### UC-27 Record payment / waive fine

| Field | Value |
|---|---|
| Actors | Librarian |
| Related requirements | FR-29, FR-30, BR-05, NFR-09 |
| Increment | v0.7.0 |
| Preconditions | The librarian is logged in; the member has at least one `UNPAID` fine. |
| Postconditions | A `Payment` is recorded and the fine's outstanding amount is reduced (status `PAID` when zero), or the fine is `WAIVED` with a reason. |

**Main success scenario (payment)**

1. The librarian searches for the member (UC-08) and opens their fines.
2. The system shows each unpaid fine with its amount, amount paid so far and outstanding amount.
3. The librarian selects a fine and enters the amount received in cash (simulated payment, A4).
4. The system checks that the amount is greater than 0 and not more than the outstanding amount.
5. The system records the payment with amount, date and the librarian who recorded it (NFR-09).
6. If the outstanding amount is now 0, the system sets the fine to `PAID`.
7. The system shows the updated balance.

**Alternative / exception flows**

- 4a. Amount ≤ 0 or more than outstanding → "Invalid amount".
- 6a. Partial payment → the fine stays `UNPAID` with a smaller outstanding amount.
- E1. **Waive fine:** the librarian chooses "Waive" and must enter a reason; the system sets the fine
  to `WAIVED` and records who waived it and why. An empty reason is refused.
- Note: once the member's unpaid total is ≤ 5.000 JOD, they can borrow and renew again (BR-05).

---

## 4. Requirement coverage (FR-01 – FR-34)

Every functional requirement is covered by at least one use case.

| FR | Use case(s) | FR | Use case(s) |
|---|---|---|---|
| FR-01 | UC-03 | FR-18 | UC-16 |
| FR-02 | UC-03 | FR-19 | UC-17 |
| FR-03 | UC-04 | FR-20 | UC-18 |
| FR-04 | UC-04 | FR-21 | UC-19 |
| FR-05 | UC-01 | FR-22 | UC-20 |
| FR-06 | UC-02 | FR-23 | UC-21 |
| FR-07 | UC-05 | FR-24 | UC-22 |
| FR-08 | UC-06 | FR-25 | UC-23 |
| FR-09 | UC-07 | FR-26 | UC-24 |
| FR-10 | UC-08 | FR-27 | UC-25 |
| FR-11 | UC-09 | FR-28 | UC-26 |
| FR-12 | UC-10 | FR-29 | UC-27 |
| FR-13 | UC-11, UC-12 | FR-30 | UC-28 |
| FR-14 | UC-11 | FR-31 | UC-29 |
| FR-15 | UC-13 | FR-32 | UC-30 |
| FR-16 | UC-14 | FR-33 | UC-31 |
| FR-17 | UC-15 | FR-34 | UC-32 |
