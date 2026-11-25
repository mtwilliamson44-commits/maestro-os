# Security and Privacy at Genesis

Security tooling that only runs after the code exists finds problems when they
are most expensive to fix. Privacy and compliance questions asked late tend to
be answered with whatever the code already does. And findings confirmed in a
review often die in that review: the next project makes the same mistake.

This method moves the questions to the start and makes findings compound. It
has three parts: a genesis artifact, a controls library, and tiered gates.

---

## 1. The Genesis Artifact

Every new project creates `SECURITY-PRIVACY.md` from
[`templates/SECURITY-PRIVACY.template.md`](../templates/SECURITY-PRIVACY.template.md)
as part of setup. **A project is not set up until the first three sections are
answered:**

1. **Data inventory** — what personal data does this touch? Field, whose data
   it is, sensitivity, retention, where it is stored. If there is none, say "No
   personal data handled" explicitly.
2. **Regulatory scope** — whose users, which jurisdictions, which privacy
   regimes apply, and why.
3. **Regulated activity** — payments, health data, financial execution,
   anything with domain-specific rules.

Then:

- **Section 4, threat model** — seeded from the controls library: which
  controls apply, and whether each is met, a gap, or not applicable.
- **Section 5, catastrophic surfaces** — which of the hard-block surfaces (below) this
  project has, and where in the code they live.

The document is updated at every phase that touches data or authentication.
Spikes and throwaway sketches are exempt.

---

## 2. The Controls Library

`CONTROLS.md` is one register shared across all projects. Every new project
inherits it whole; its entries seed section 4 of each project's
`SECURITY-PRIVACY.md`.

Each entry has a fixed shape: **id · rule · why · how to apply.** The "how to
apply" part should be checkable — a grep, a lint rule, a test.

**Promotion rule:** a control is added when a finding is *confirmed at a review
or security gate*. There is no separate curation session. The gate is the
curation. This keeps the library made of real mistakes rather than a generic
checklist nobody reads.

Start from [`templates/CONTROLS.template.md`](../templates/CONTROLS.template.md),
which carries two generic starter controls.

---

## 3. Tiered Gates

Not every phase needs the same scrutiny.

| Phase touches | Gate |
| --- | --- |
| No personal data, no auth | None beyond normal review |
| Personal data or auth, normal risk | **Flag** — the phase must update `SECURITY-PRIVACY.md` |
| A catastrophic surface | **Hard block** — the phase cannot start execution until `SECURITY-PRIVACY.md` covers it |

Catastrophic surfaces:

- storage or export of personal data
- authentication and authorization changes
- payment or card handling
- live financial execution (anything that moves real money automatically)

---

## 4. Where It Sits in the Workflow

The full execution sequence for a piece of work is:

```text
Discuss → Plan → Execute → Review → Secure → Verify
```

*Secure* is the security pass between review and verification: check the diff
against the project's threat model, confirm the applicable controls are met, and
promote any newly confirmed finding to `CONTROLS.md`. For projects with no
catastrophic surfaces it is short. It is never skipped.

Folding the privacy work into the normal phase flow — discuss, plan, review,
execute — works better than a standalone compliance task. An external review at
the secure step is worth it on catastrophic surfaces; it routinely widens the
data inventory and catches concurrency problems the internal review missed.

---

## 5. Public Repos

If a repo is public, add a sanitization gate: a local denylist of private terms
(kept out of version control, since the list itself names what is private) and a
script that fails the commit if any tracked file contains one. Treat it as a
safety net, not the definition of private — a human still reads the diff.
This repository runs one: see [`scripts/sanitization-check.sh`](../scripts/sanitization-check.sh).
