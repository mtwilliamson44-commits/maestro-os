# Security, Privacy and Compliance — {{Project}}

**Status:** {{draft | reviewed}}  **Last reviewed:** {{YYYY-MM-DD}}

> Genesis artifact. The project is not set up until sections 1–3 are answered.
> Seed section 4 from `CONTROLS.md`. Update at every phase that touches data or
> auth. See [`docs/security-privacy-at-genesis.md`](../docs/security-privacy-at-genesis.md).

---

## 1. Data Inventory

What personal data does this touch?

| Field | Whose data | Sensitivity | Retention | Stored in |
| --- | --- | --- | --- | --- |
| {{e.g. email}} | {{customer}} | {{personal}} | {{e.g. 2 years}} | {{table}} |

If none: write "No personal data handled" and skip to section 5.

## 2. Regulatory Scope

- Applicable regimes: {{e.g. GDPR, CCPA, none}}
- Rationale: {{e.g. EU users, so GDPR applies}}

## 3. Regulated Activity

- Domain rules: {{e.g. card payments, health data, financial execution, none}}
- Rationale: {{one line}}

## 4. Threat Model

Seeded from `CONTROLS.md`.

| Control | Applies? | Status |
| --- | --- | --- |
| {{control id}} | {{yes / no}} | {{met / gap / n/a}} |

## 5. Catastrophic Surfaces

Any phase touching these is hard-blocked until this document covers it:

- storage or export of personal data
- authentication or authorization changes
- payment or card handling
- live financial execution

Which of these this project has, and where in the code they live:

- {{surface}} — {{location}}

## 6. Findings and Deferrals

- {{finding}} — {{fixed in phase / deferred, with reason}}
