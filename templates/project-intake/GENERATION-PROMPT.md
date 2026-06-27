# Generation Prompt — Project Intake → Doc Set

Paste this prompt into your AI assistant, replacing `{{INTAKE}}` with the
completed `QUICK-INTAKE.md` content. The assistant will produce all six
documents in a single response. Review and edit before committing.

---

## Prompt

```text
You are a senior software architect and technical writer. Using the project
intake below, generate a complete six-document planning set for this project.
Write each document in full — no stubs, no placeholders unless a decision is
genuinely unresolved. Where the intake leaves something open, make a reasonable
default choice and note it clearly so the team can override it.

---

{{INTAKE}}

---

Generate all six documents in the order listed. Separate each document with a
horizontal rule (---) and a clear heading.

### 1. PRD — Product Requirements Document

Cover: product name, one-line description, problem statement, target user
profile, non-goals for v1, success metrics, and pricing or access model if
applicable. Anchor every requirement to a user need stated in the intake.

### 2. TRD — Technical Requirements Document

Cover: chosen stack with rationale tied to the intake's tech preferences,
authentication approach, hosting and infrastructure, API design decisions, and
key technical constraints (performance targets, data isolation, third-party
dependencies).

The TRD must assume the `docs/git-branch-workflow.md` build standard:
- Code flows feature/* → dev → staging → main only.
- dev, staging, and main are protected; no direct commits.
- Squash merges for feature PRs into dev; --no-ff merge commits for branch
  promotions (dev → staging, staging → main).
- Human UAT is required on staging before any promotion to main.
- All commits follow Conventional Commits 1.0.0.
- Every merge to main carries a semantic version tag (vMAJOR.MINOR.PATCH).

State how CI checks (lint, typecheck, tests) gate each merge step.

### 3. App Flow

Produce an ASCII or indented-text tree showing the full user journey from
entry point to every major action. Include the state machine for any entity
that has a lifecycle (e.g., order status, document approval). Note any flow
that is out of scope for v1.

### 4. Design Brief

Cover: aesthetic direction, color palette with hex values, typography choices
(UI font vs. document/print font if applicable), component strategy (design
system or library), key screens to design first, and accessibility target
(default to WCAG 2.1 AA unless the intake specifies otherwise).

### 5. Backend Schema

Produce a schema in SQL DDL or pseudocode (whichever is clearer for the chosen
database). Include all primary entities, foreign keys, and any columns relevant
to status, timestamps, or soft-delete. Add a brief note on any non-obvious
modeling decision (e.g., storing money in cents, using enum types).

### 6. Implementation Plan

Break work into numbered phases. Each phase should be independently shippable
and testable. For each phase list: goal, deliverables, and approximate
duration.

The Implementation Plan must reflect the `docs/git-branch-workflow.md` build
standard:
- Each deliverable is a feature/* branch that merges to dev via a squash PR.
- Phase completion = dev promoted to staging, UAT performed, then promoted to
  main and tagged with the appropriate version bump.
- No phase is "done" until it has passed human UAT on staging and a version
  tag exists on main.
- Note which Conventional Commit types are expected in each phase (feat, fix,
  chore, etc.).

End with a "Not in scope for v1" list drawn from the intake's explicit
out-of-scope items plus any implied deferrals you introduced.
```
