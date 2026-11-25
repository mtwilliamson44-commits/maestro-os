# The Brief Ritual

Commitments get onto the calendar during the week, conversationally, as they
come up. Nothing takes them off. Within a month the calendar is full of things
whose end date passed without anyone closing, cancelling or moving them — and a
calendar you cannot trust is worse than none, because every reminder built on
it is wrong.

The brief is the weekly session that catches what capture missed. It is an
audit, not an intake. It must end with a concrete output, or it decays into a
ritual nobody trusts.

---

## 1. What It Produces

Every brief ends with exactly these:

- **A calendar with zero stale items** — every past-due commitment closed,
  rescheduled, cancelled or deliberately kept.
- **A record** of the session: counts of each decision type, and an audit
  ledger of anything deleted and why.
- **A This-week Top 10** — the operator's own list, pinned into `TODAY.md`.
- **One local commit** containing only the files the session changed.

---

## 2. The Sequence

### Preflight

Check whether the calendar, `TODAY.md` or the brief record are already dirty.
If they are, never fold those changes silently into the session commit. Offer
three choices: commit them now as a separate baseline, run the brief but skip
the session commit, or stop.

### Load the agenda

The agenda is generated, not remembered. It lists, in order:

1. **Obligations** — recurring things that must happen (renewals, filings,
   reviews).
2. **Each project track** — past-due items per project.
3. **Untracked** — items not attached to a project.
4. **Invalid dates** — fix each with a real date, or cancel it.
5. **Look-ahead** — the next 7 days, to confirm.

Every id used later in the session comes from the generated agenda, never
retyped from memory.

### Walk it, one section at a time

Show a compact numbered list per section and collect decisions for the whole
section in one reply: *"1 close, 2 move to next Friday, 3 cancel — not
happening, 4 keep."*

| The operator says | Decision |
| --- | --- |
| done | `close` |
| moved | `reschedule` to a new start/end |
| won't happen | `cancel`, with a reason |
| still running | ask for a new end date, then `reschedule` |
| duplicate or mistake | `delete`, with a reason naming why |

**Rotate, never delete.** Something that really existed is cancelled, not
deleted. Delete is for duplicates and entry mistakes only, and always carries a
reason.

Undecided items are left alone. They reappear next week. There is no separate
decision queue to maintain.

### Recurring items

When a closed or cancelled item has a next instance, offer to add it. If any
periods were skipped between the last instance and now, **name the skipped
periods first** — "these were skipped: were they done?" — so a missed
obligation is never silently stepped over.

### What's missing

Ask once: *"Anything in the next week that isn't on the calendar?"* Each answer
becomes a queued addition.

Identifiers follow a `<category>-<slug>-<period>` style and **never carry an
amount, price or figure**. Ids are what outbound reminders are allowed to name
(see [the notification rule](advisory-board.md#4-notifications-carry-subjects-never-substance)).

### This week's Top 10

The operator writes it. The assistant does not propose one unless asked. One to
ten items. It can be edited mid-week by hand.

### Confirm once

Nothing has been written yet. Show in one place: every change exactly as it will
be applied, the Top 10, and the counts. One question: **apply all / edit /
abandon.** Abandon writes nothing and records nothing.

### Apply as one batch

All changes go through the calendar's single writer as **one all-or-nothing
batch**. If any line is rejected, nothing is written: fix the offending line,
then re-confirm the *whole* set. Never resubmit a partial batch. If the
calendar is locked by another writer, wait and retry once.

Record and commit only after a batch has succeeded. If every decision was
"keep", skip the batch.

### Record and commit

Write the session record, pin the Top 10, and make one local commit staging
exactly the files that changed. Never `git add -A`. Never push.

### Close

> Brief done: 4 closed, 2 rescheduled, 1 cancelled, 3 added. Still stale: 0.
> Next due: Thursday.
> This week: 1… 2… 3…

Then stop.

---

## 3. Rules

- **One writer.** Every calendar change goes through the batch writer. No hand
  edits to the calendar file, not even to fix a typo.
- **Stay in lane.** The brief does not reconcile project planning state. That is
  the planning tool's job.
- **Nothing leaves the machine.** The brief never sends notifications. A board
  nudge may say "run the brief"; the session never waits for one and can run at
  any hour.
- **Expect a long first run.** The first brief opens on the whole backlog. Keep
  each item to one line so the session does not collapse under its own weight.

---

## How It Fits the Rhythm

The [daily rhythm](daily-rhythm.md) runs the day: brief, Top 3, log, note. The
weekly review looks back at what shipped. The brief ritual keeps the calendar
underneath both of them honest, and its Top 10 is the menu each morning's Top 3
is picked from.
