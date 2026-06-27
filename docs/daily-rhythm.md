# Daily Rhythm

Maestro is built around a repeating daily loop. Three lightweight templates capture the full cadence; one weekly template closes the loop. This document explains when to fill each one and how they connect to the broader workflow.

---

## The Loop

### 1. Morning Brief

At the start of each day, fill in `templates/DAILY_BRIEF.template.md` and save it as `DAILY_BRIEF.md` in your working root.

The brief answers three questions:

- **Projects** — for each active project, what shipped yesterday, what the current state is, and what needs attention today.
- **Reminders** — anything time-sensitive that must not be forgotten.
- **Focus** — the single most important thing to accomplish today.

Keep each project entry to one paragraph. The brief is a forcing function, not a journal. If you cannot summarize a project in one paragraph, that is signal worth acting on.

### 2. Set Your Top 3

Open `templates/TODAY.template.md` and save it as `TODAY.md`. Fill in the Top 3 slots before you start executing.

The Top 3 are outcomes, not tasks. An outcome is something you can verify as done at the end of the day. "Write the onboarding flow" is an outcome. "Work on onboarding" is not.

Anchor every session back to these three. If something comes up that is not one of them, decide consciously whether it displaces a Top 3 item or goes into the backlog.

### 3. Log Throughout the Day

The `### Log` section of `TODAY.md` is a running record. Append entries as things happen:

```text
- [HH:MM] <free prose>
```

Log anything worth remembering: decisions made, contacts met, observations, unexpected blockers, context switches. The format is deliberately loose — a timestamp and a sentence is enough.

Do not batch-log at the end of the day from memory. Log in the moment; memory is lossy.

### 4. End-of-Day Note

Before closing out, fill the `### Note` section of `TODAY.md`. Write one paragraph: what actually happened relative to the Top 3, what carries forward, and anything the next session should know.

The note is the bridge between today and tomorrow. A good note makes tomorrow's brief faster to write.

### 5. Weekly Review

Once a week — typically on Friday or Sunday — fill in `templates/WEEKLY.template.md` and save it as `WEEKLY.md` (or date-stamp it for archival: `WEEKLY-YYYY-MM-DD.md`).

The weekly review covers:

- **Shipped** — actual outcomes delivered this week, one bullet per item.
- **Decisions** — calls made and the rationale behind them. This is the institutional memory layer.
- **Next Week — Top 3** — the three outcomes that matter most in the coming week.

The weekly review feeds directly into the next Monday's morning brief. Reading last week's review before writing Monday's brief takes two minutes and prevents drift.

---

## How It Composes with the Workflow

The daily rhythm operates alongside the task-execution workflow in `workflow/`. The relationship is:

- The **daily brief and Top 3** determine *what* gets worked on.
- The **workflow loop** determines *how* individual tasks are planned, executed, reviewed, and shipped.

When you sit down to execute, you should already know your Top 3 from the morning. Pick the first item, run it through the workflow, ship it, log it, move to the next.

The log and note sections of `TODAY.md` capture the narrative that the workflow's commit history does not: why a decision was made, what was learned, what changed mid-day.

---

## Template Reference

| Template | Saved As | Cadence |
| --- | --- | --- |
| `templates/DAILY_BRIEF.template.md` | `DAILY_BRIEF.md` | Every morning |
| `templates/TODAY.template.md` | `TODAY.md` | Every morning |
| `templates/WEEKLY.template.md` | `WEEKLY.md` (or date-stamped) | Once per week |

Copy the template, fill in the placeholders, delete the placeholder tokens. Do not edit the templates themselves — they are the blank forms.
