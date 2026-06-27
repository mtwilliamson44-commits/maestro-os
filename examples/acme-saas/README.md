# Acme SaaS — Worked Example

Acme SaaS is a deliberately mundane fictional invoicing tool invented to show Maestro working end-to-end. Nothing here is a real product, real client, or real data. The spotlight is the system, not the example.

---

## What This Folder Contains

| File | What it shows |
| --- | --- |
| `project-intake.md` | A filled-in intake covering PRD, TRD, App Flow, Design Brief, Backend Schema, and Implementation Plan for Acme |
| `TODAY.md` | A filled-in daily snapshot using the `templates/TODAY.template.md` structure (Top 3 / Log / Note) for a representative Acme work day |
| `PLAN.md` | A short gsd-lite plan for one Acme feature — PDF invoice export — following all five workflow stages |

---

## How These Files Map to Maestro

```text
templates/TODAY.template.md  →  TODAY.md        (daily rhythm)
workflow/00-discuss.md       ┐
workflow/01-plan.md          │
workflow/02-execute.md       ├→  PLAN.md         (five-stage workflow)
workflow/03-review.md        │
workflow/04-verify.md        ┘
docs/build-standard.md      →  project-intake.md (project structure)
```

The intake is a one-document summary of the six planning artifacts that any new project produces before execution begins. The TODAY snapshot shows how the daily rhythm template is used in practice. The PLAN shows a single feature moving through all five workflow stages.

---

## How to Use This Example

1. Read `project-intake.md` to see what a grounded project scope looks like before any code is written.
2. Read `PLAN.md` to see how one feature moves through Discuss → Plan → Execute → Review → Verify.
3. Read `TODAY.md` to see how the daily snapshot captures focus, decisions, and carry-forwards.
4. Copy the templates from `templates/` and adapt them for your own project.

---

## What Acme SaaS Is (Fictional)

Acme SaaS is a single-tenant invoicing tool for independent consultants. It lets users create invoices, attach line items, send PDF copies to clients by email, and track payment status. Nothing novel. The intentional mundanity is the point — Maestro should work on boring problems, not just interesting ones.
