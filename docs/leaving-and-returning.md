# Leaving and Returning

A solo founder works in fragmented time: client work, travel, days away from
the desk. The cost of time away is not the hours themselves. It is the first
hour back, spent rebuilding by feel the context you already had.

Two short rituals fix this. **Leaving** writes a handoff. **Returning** reads it
and names one next action. Each takes about two minutes. A leaving ritual that
takes fifteen will not survive a real departure.

---

## 1. Leaving the Desk

### Find what is actually in flight

Don't ask what you were working on — look. Refresh the portfolio state, list
projects with recent activity, and scan every repo for uncommitted work, since
that is the state most likely to be lost.

### Pause anything mid-phase

For each project with work in progress, run your planning tool's pause step so
the detailed handoff lands in that project's own planning files. The cross-
project handoff is only an index; detail belongs with the project. Skip
projects with nothing in flight.

### Catch what is only in your head

Ask one open question, not a form:

> "Anything in your head that isn't written down anywhere?"

Route whatever comes back to the right place — a capture inbox, a project's
notes, a backlog. If the answer is nothing, move on.

### Write the handoff

Overwrite a single handoff file (it is current state, not a log) from
[`templates/HANDOFF.template.md`](../templates/HANDOFF.template.md):
when you left, where you are going, what is in flight, what is uncommitted,
what is waiting on someone else, the **one** next action, and what can still be
driven from a phone.

Add one line to the `### Log` in `TODAY.md`.

### Close out in three lines

What was paused, what is uncommitted and could be lost, and the one thing worth
doing from a phone. Then stop. Do not start new work.

Report uncommitted work; never commit on the operator's behalf as part of
leaving.

---

## 2. Returning to the Desk

**The output is one next action, not a status report.** You already have a
morning brief for status. What you lack on return is someone telling you where
to put your hands.

### Read the handoff

Note its age. A three-day-old handoff is still useful; the state around it may
not be. If there is no handoff, say so in one clause and carry on.

### Refresh the real state

Regenerate the portfolio view from live project state. Where it disagrees with
the handoff, trust the live state and say that they disagree.

### Check what moved

Commits per repo since you left, and anything uncommitted.

### Recall decisions — don't re-derive them

Before proposing any new work, search past decisions and the relevant roadmap.
The most expensive failure on return is re-planning something that was already
planned, correct, and unread. If it is already planned, say so first.

### Resume what was paused

Run the planning tool's resume step only for the projects you are actually
returning to.

### Name one action

```text
While you were out: <one line — what moved, what didn't>
Where things stand: <two or three lines, only what changed>
Already decided:    <anything you're about to re-litigate that's settled>
Start here:         <one concrete action>
```

Then ask whether that is the right starting point, and take the redirect if it
is not. The recommendation is a proposal, not a verdict.

---

## 3. Rules

- **One action, not a menu.** Six suggestions is the same as none.
- **Never open new scope on return.** You are re-entering, not starting fresh.
  New ideas go to the capture inbox.
- **Timestamps in the operator's local time zone**, explicitly, if the machine
  runs on a different one.
