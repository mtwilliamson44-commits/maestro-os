# Advisory Board

A solo founder has no co-founder to say "that project has been stalled for three
weeks" or "you are spreading yourself too thin." The advisory board fills that
gap: a small set of scheduled, role-based reviews that read the live state of
every project and write a short report. No meetings, no dashboards to maintain —
each role runs on its own cadence and leaves a file.

The board advises. It never decides and never edits project state. The operator
reads the reports and acts.

---

## 1. The Roles

Each role is a prompt with a fixed output format, a fixed set of inputs, and a
schedule. Keep the set small; a role earns its place by changing decisions.

| Role | Cadence | Reads | Writes | The question it answers |
| --- | --- | --- | --- | --- |
| COO | Weekly | Live project state, last 7 days of commits, the calendar | `board/coo/REPORT.md` | What shipped, what stalled, what is blocked? |
| CMO | Weekly | The daily log, client engagements, project status | `board/cmo/REPORT.md` | Who is waiting on me, and which relationships are going cold? |
| CTO | Weekly, only when a phase has completed | The phase summary, the project vision, the open-gaps file | `board/cto/GAP_LOG.md` | What did this phase actually close, and what new gaps did it surface? |
| CEO | Monthly | The COO report, each project's vision and gaps, the calendar | `board/ceo/REPORT.md` | Are we moving toward the vision, and what should stop? |
| Advisor | Monthly, or on demand | The CEO report, or any document the operator points it at | `board/advisor/CRITIQUE.md` | What is the weakest assumption in this plan? |
| Hygiene | Daily | Planning files and the repo itself | `board/hygiene/REPORT.md` | Do the planning files still agree with the code? |
| Chief of Staff | Daily, always last | Every report above, plus the daily log | Appends to `DAILY_BRIEF.md` | What is open today, and where did it come from? |

Fill-in prompts for each role are in
[`templates/BOARD_ROLES.template.md`](../templates/BOARD_ROLES.template.md).

### What each report contains

- **COO:** a portfolio health table (milestone, phase, status, last activity),
  shipped this week, stalled or dormant projects with what they wait on, a
  decision queue, and next week's top three moves.
- **CMO:** a relationship pipeline (person, context, last touch, open
  follow-up), overdue follow-ups, and one paragraph of market context per
  venture.
- **CTO:** an updated gaps file (delivered items moved from open to closed, new
  gaps added) and one log line per analysis.
- **CEO:** portfolio vs vision, momentum, revenue posture, top three strategic
  bets for the next 30 days, decisions only the operator can make, and **one
  thing to stop doing**.
- **Advisor:** a critique through five lenses — the weakest assumption, real
  problem vs symptom, the failure mode in 90 days, an idea-hopping check, and
  the question the operator does not want to answer. It never leads with what
  is good.
- **Hygiene:** divergences between what the roadmap and state files claim and
  what the repo shows, tiered by severity.
- **Chief of Staff:** a reminders list where every item names its source
  (COO, CMO, CTO, or the daily log).

---

## 2. Read Live State, Never a Mirror

Every role reads project status through **one shared function** that resolves
each project's live state file (the file your planning tool keeps current).
Hand-maintained status mirrors are a fallback only, for ventures with no
planning tool.

The failure this prevents is quiet and common: three scripts each reading a
different status file, each one weeks stale, all of them producing confident
reports about a portfolio that no longer exists. If two roles can disagree
about a project's status, the board is broken.

Rules:

- One status function, sourced by every role. Never `cat` a status file
  directly.
- A report carries a `Generated:` timestamp. A brief whose timestamp is not
  today is regenerated, never shown.
- Run health is logged per run, ending in a summary of which roles ran, which
  skipped, and which failed.

---

## 3. Write Atomically, Fail Visibly

Each role writes its output to a temporary file and moves it into place only
when the run succeeded and the output is non-empty. A failed run leaves the
previous report intact and logs the failure.

The deterministic roles are different on purpose. The Hygiene role does not call
a model at all: it is a plain script that diffs planning claims against repo
evidence. It is cheap, so it runs on every schedule tick with no day guard, and
it is **report-only** — it never edits a planning file to make two claims agree,
because "fixing" a divergence automatically can just as easily manufacture the
false record.

Its exit codes are distinct: "ran and found nothing" and "did not finish" must
never share a code. A caller that conflates them turns a broken checker into a
false all-clear.

---

## 4. Notifications Carry Subjects, Never Substance

The board may nudge the operator through an outbound channel — a chat message,
a push notification, an email to self. Call it the knock. The knock leaves the
machine, so it follows one rule:

> **The knock says what wants attention and invites the operator into a local
> session. It never carries figures, terms, names of counterparties, or any
> free-text field.**

This rule exists because a real version of this system broke it. A reminder rule
named calendar events by their titles, and the titles were where the sensitive
detail lived — contract terms and payment amounts. The rule fired
daily for over a month before anyone noticed. Two separate defects combined: a
condition described in a comment but never written in the code made it fire
every day, and echoing a free-text title made it leak. Fixing either alone
would not have been enough.

The structural fix, which should be built in from the start:

1. **One shared formatter** for every line that names a record. It returns a
   validated, structured identifier (an id or category matching a strict
   pattern — lowercase, no spaces, no currency symbols) or a constant such as
   `unidentified-event`. It never returns a title, note, or description.
2. **Callers pass records, not pre-formatted strings.** A string that already
   contains a title has already escaped the formatter.
3. **Fail closed.** If the formatter cannot load, the rules that depend on it
   are withheld and a loud internal warning is raised. A missing safety layer
   must mean less output, never unfiltered output.
4. **No figures in identifiers.** A pattern check cannot tell whether the
   digits in `renewal-1200` are a period or a sum, so the convention is
   enforced where ids are created: ids describe a category and a period,
   never an amount.
5. **Silence must be reachable.** Write a test proving the knock can be empty.
   A rule that always fires is both noise and an exposure.
6. **Tests use synthetic values.** Never put the real sensitive strings into a
   test file to prove they are not emitted — that copies them into a new file.
   Synthetic constants test the same property.
7. **Prove the test catches the bug.** Revert the fix and watch the regression
   test fail before trusting it.

The broader lesson: **when a comment describes a condition, check that the code
implements it.** Reviewers read the comment and believed it.

---

## 5. Running It

The simplest working setup is a scheduler (cron, a launch agent, a CI schedule)
that runs one wrapper script each morning. The wrapper checks the day, runs the
roles that are due in a fixed order, runs the Chief of Staff last, and logs a
health summary.

```text
daily tick
  ├─ Hygiene            (always)
  ├─ COO                (weekly)
  ├─ CMO                (weekly)
  ├─ CTO                (weekly, only if a phase-complete trigger exists)
  ├─ CEO → Advisor      (monthly; the Advisor critiques the CEO report)
  └─ Chief of Staff     (always, last — synthesises into DAILY_BRIEF.md)
```

On-demand roles use a trigger file: drop an `ADVISOR_TRIGGER.md` naming a
document, and the next run critiques it and removes the trigger.

Start with two roles — COO and Chief of Staff — and add others only when a
missing question keeps costing you. A board nobody reads is overhead.
