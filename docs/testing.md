# Testing — GP11

All automated tests live in `tests/java` (configured as Maven's test source directory) and run with
`./mvnw verify`. Every test is classified and linked to the requirement(s) and module(s) it verifies.

## Test levels

| Level | Meaning in this project |
|---|---|
| Unit | One class in isolation (no Spring context, collaborators mocked) |
| Component | One Spring slice/module (e.g. a controller with MockMvc, a repository with a test DB) |
| Integration | Several modules together through the full Spring context and database |
| System / end-to-end | A complete use case through the HTTP API or UI |

## Test inventory

| Test | Level | Requirement(s) | Module(s) | Version | Result |
|---|---|---|---|---|---|
| `HealthControllerTest` | Unit | — (bootstrap) | `health.HealthController` | v0.0.0 | Pass |
| `LibraryApplicationTests.contextLoads` | Integration | — (bootstrap) | Whole Spring context | v0.0.0 | Pass |

## Results per increment

### v0.0.0

`./mvnw verify` — 2 tests, 0 failures (see the prompt record for the run).
