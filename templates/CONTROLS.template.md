# CONTROLS — Cross-Project Security and Privacy Library

One register of reusable controls, shared by every project. Each project
inherits this file at genesis; its entries seed section 4 of that project's
`SECURITY-PRIVACY.md`. See
[`docs/security-privacy-at-genesis.md`](../docs/security-privacy-at-genesis.md).

**Promotion rule:** a control is added when a finding is confirmed at a review
or security gate — not in a separate curation session.

**Entry format:** id · rule · why · how to apply.

---

## PRIV-01 — Explicit autofill on sensitive inputs

- **Rule:** every input that renders personal data or credentials sets an
  explicit `autocomplete` value (`off`, or a scoped token such as
  `new-password`).
- **Why:** browser autofill can expose personal data on shared devices and
  through autofill surfaces; a data-minimisation and confidentiality concern.
- **How to apply:** audit form inputs; add a lint rule or test that fails when a
  field bound to personal data or credentials has no explicit attribute.

## OBS-01 — No silent exception swallowing on external I/O

- **Rule:** handlers around external services (payments, email, brokers,
  third-party APIs) log a non-empty, detailed error message and surface a
  failure state. Never an empty handler, never an empty message.
- **Why:** a swallowed exception with an empty message can hide an outage of an
  external integration for weeks. Silent failure on external I/O is a
  correctness risk and, in regulated flows, a compliance one.
- **How to apply:** grep for bare or empty exception handlers around network
  calls; require the full error representation in the log line and a state flag
  or alert on failure.

## {{ID}} — {{title}}

- **Rule:** {{}}
- **Why:** {{the confirmed finding that promoted this}}
- **How to apply:** {{a checkable step}}
