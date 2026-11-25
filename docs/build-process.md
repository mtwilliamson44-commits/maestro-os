# Build Process: Subagent-Driven Development with Independent Reviews

The five-stage [workflow](../workflow/) describes *what* happens to a piece of
work. This document describes *how* a larger build — a multi-task phase — is run
when an AI agent can dispatch other agents.

The principle: **the agent that wrote the code never signs off on it.** Every
task gets a fresh implementer and an independent reviewer. The operator trusts
the result because the reviews were independent, not because the implementer
said it was done.

---

## 1. The Sequence

```text
approved design
  → approved written plan
    → for each task:
        fresh implementer → independent reviewer → fix round(s)
    → final whole-branch review (strongest model)
      → one fix wave → re-review
        → clean run-through by an agent that knows only the docs
          → merge and push on the operator's word
```

### Design, then plan — both approved

The design is approved before a plan is written. The plan is approved before
any code. The plan names each task, its files, its acceptance check and its
order. Two approvals sound slow; they are cheaper than a rebuild.

### Per task: a fresh implementer

Each task gets a new agent with a clean context: the plan, the task, the
relevant files, nothing else. A fresh context stops one task's assumptions
leaking into the next and keeps each agent's attention on one job.

### Per task: an independent reviewer

A second agent reviews the task's diff against the plan. It did not write the
code and is not told the implementer's reasoning — only what was asked and what
was delivered. Findings are classified as in [`03-review`](../workflow/03-review.md).
The implementer fixes; the reviewer re-checks. Repeat until it passes.

### Final review on the strongest model

When every task has passed, one review covers the whole branch — on the most
capable model available, because cross-task problems (inconsistent contracts,
duplicated logic, a security assumption one task made and another broke) only
show up at that level.

### One fix wave, then re-review

Collect every final-review finding and fix them in a single wave, then review
again. One wave keeps the fixes coherent and stops an endless loop of small
patches.

### Clean run-through

An agent that knows **only the docs** — the README, the install steps, the
usage guide — installs and runs the result from scratch. If it gets stuck, the
docs are wrong, whatever the code does.

### Merge on the owner's word

Agents prepare the branch. The operator decides when it merges and when it
pushes.

---

## 2. The Rulings Ledger

Every judgement call made during the build — by the implementer, the reviewer,
or the operator — goes into a ledger, one line each:

```text
Ruling: <what was decided> — <why> — <cost if wrong>
```

A fictional example from Acme SaaS:

```text
Ruling: generate invoice PDFs on request, not at save time — keeps the save path
fast and avoids storing stale files — low: one background job if load grows
```

The *cost if wrong* column is what makes it useful. It tells the operator which
rulings to check first and which are cheap to reverse later. The operator reads
the ledger at the end of the build instead of re-reading every diff.

Use [`templates/RULINGS_LEDGER.template.md`](../templates/RULINGS_LEDGER.template.md).

---

## 3. What Independent Review Actually Catches

Per-task reviews are the expensive part, and they earn their cost. The classes
of bug they reliably catch that a self-review misses:

- **Open redirects** — a return URL accepted without checking it stays on-site.
- **Race conditions in lockouts and counters** — two requests both passing a
  check before either records the attempt.
- **Rollbacks that do not roll back** — an error path that reports failure but
  leaves partial writes behind.
- **Sensitive data in logs** — a debug line that prints a whole record.
- **Comments that describe code that is not there** — a condition documented in
  prose and never implemented.

---

## 4. Cost and When to Use It

A multi-task phase run this way can take a few dozen agent dispatches. Use it
for builds where a missed bug is expensive: authentication, payments, data
handling, anything public. For a one-file change, the standard five-stage
workflow is enough.

Before reporting a build done, apply the completion check in
[decision rules](decision-rules.md#finish-mode): no stubs, no TODOs left in
delivered code, every reachable error path handled.
