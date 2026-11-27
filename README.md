<!-- markdownlint-disable-file MD041 -->
[![MIT License](https://img.shields.io/badge/license-MIT-blue.svg)](LICENSE)
[![CI](https://img.shields.io/github/actions/workflow/status/mtwilliamson44-commits/maestro-os/ci.yml?branch=main&label=CI)](https://github.com/mtwilliamson44-commits/maestro-os/actions)

# Maestro

## The Problem

A solo founder running multiple products cannot hand-code everything. AI closes
that gap — but the bottleneck is not typing speed. It is operating discipline:
knowing what to build next, making sure AI execution stays on target, and
carrying the right context from one session to the next without losing thread.
The gap between "AI writes code" and "product ships correctly" is an
orchestration problem, not a coding problem.

---

## The System

**Maestro** is the operating shell that closes that gap.

It is not a framework, an IDE plugin, or an agent runtime. It is a structured
set of prompts, templates, and conventions — a rhythm you run every day — that
makes AI-directed work reliable and consistent across a portfolio of products.

The core loop:

```text
Rhythm → Workflow → Build Standard → Knowledge Loop
   ↑                                        │
   └────────────────────────────────────────┘
```

Every session starts with a brief and a Top 3. Work moves through a five-stage
loop. A build standard defines what "done" means. What is learned gets captured
and seeded into the next session.

See [`docs/architecture.md`](docs/architecture.md) for the full design.

---

## The Four Subsystems

### 1. Rhythm

The daily operating cadence: morning brief, scoped Top 3, running log,
end-of-day note, weekly review. Rhythm is the forcing function that keeps work
anchored to real goals instead of drifting into maintenance and reaction.

- [`docs/daily-rhythm.md`](docs/daily-rhythm.md) — session structure and how
  the loop fits together
- [`templates/DAILY_BRIEF.template.md`](templates/DAILY_BRIEF.template.md) —
  morning brief template
- [`templates/TODAY.template.md`](templates/TODAY.template.md) — daily
  snapshot template
- [`templates/WEEKLY.template.md`](templates/WEEKLY.template.md) — weekly
  review template

### 2. Workflow

A five-stage execution loop (called `gsd-lite`) for any discrete piece of work:

| Stage | File | Purpose |
| --- | --- | --- |
| `00-discuss` | [`workflow/00-discuss.md`](workflow/00-discuss.md) | Surface assumptions; close knowledge gaps |
| `01-plan` | [`workflow/01-plan.md`](workflow/01-plan.md) | Decompose the goal into ordered, testable tasks |
| `02-execute` | [`workflow/02-execute.md`](workflow/02-execute.md) | Implement task by task with frequent commits |
| `03-review` | [`workflow/03-review.md`](workflow/03-review.md) | Check the diff for correctness and simplification |
| `04-verify` | [`workflow/04-verify.md`](workflow/04-verify.md) | Confirm the original goal is achieved |

The [`workflow/run.sh`](workflow/run.sh) orchestrator lists stages and prints
any stage on demand — no dependencies required.

### 3. Build Standard

The definition of "done" at the code level: branch naming, commit format,
promotion gates (feature → dev → staging → main), hotfix flow, environment
variable hygiene, and semantic versioning.

- [`docs/git-branch-workflow.md`](docs/git-branch-workflow.md) — canonical
  branching strategy, commit conventions, and release process

### 4. Knowledge Loop

What is learned in each session is captured and made available to future ones.
Templates, examples, and patterns extracted from real work accumulate in
`knowledge/` and `templates/` so context compounds rather than evaporates.

- [`knowledge/INDEX.md`](knowledge/INDEX.md) — resource index with extracted
  key ideas and project applications
- [`templates/project-intake/`](templates/project-intake/) — structured
  planning templates for new projects

---

## Operating Methods

The four subsystems run the loop. These methods run the business around it —
each is a short doc, most with a fill-in template.

| Method | Doc | Template | What it does |
| --- | --- | --- | --- |
| Advisory board | [`docs/advisory-board.md`](docs/advisory-board.md) | [`BOARD_ROLES`](templates/BOARD_ROLES.template.md) | Scheduled role-based reviews (COO, CMO, CTO, CEO, Advisor, Hygiene, Chief of Staff) that read live project state and write reports |
| Brief ritual | [`docs/brief-ritual.md`](docs/brief-ritual.md) | — | Weekly calendar audit: every stale commitment decided, applied as one all-or-nothing batch, plus a This-week Top 10 |
| Leaving and returning | [`docs/leaving-and-returning.md`](docs/leaving-and-returning.md) | [`HANDOFF`](templates/HANDOFF.template.md) | Two-minute rituals: write a handoff when you leave, get one next action when you return |
| Build process | [`docs/build-process.md`](docs/build-process.md) | [`RULINGS_LEDGER`](templates/RULINGS_LEDGER.template.md) | Fresh implementer and independent reviewer per task, final whole-branch review, one fix wave, a ledger of rulings |
| Security and privacy at genesis | [`docs/security-privacy-at-genesis.md`](docs/security-privacy-at-genesis.md) | [`SECURITY-PRIVACY`](templates/SECURITY-PRIVACY.template.md), [`CONTROLS`](templates/CONTROLS.template.md) | A data inventory before the first line of code, a shared controls library, tiered gates |
| Negotiation | [`docs/negotiation.md`](docs/negotiation.md) | [`NEGOTIATION_PLAN`](templates/NEGOTIATION_PLAN.template.md) | A written plan before every deal, a debrief after, a confirmation note the same day |
| Decision rules | [`docs/decision-rules.md`](docs/decision-rules.md) | — | Priority order, a four-test filter, hard stops, what the AI may decide alone, challenge and finish modes |
| Working inside an employer | [`docs/working-inside-an-employer.md`](docs/working-inside-an-employer.md) | [`ROLE_PLAN`](templates/ROLE_PLAN.template.md), [`QUARTER_PLAN`](templates/QUARTER_PLAN.template.md), [`RESULTS_LOG`](templates/RESULTS_LOG.template.md), [`ONE_ON_ONE`](templates/ONE_ON_ONE.template.md) | Running Maestro in a job: the one-way rule, company accounts, and a role plan that grows from 90 days into quarterly and annual cycles |
| Activation lifecycle | [`docs/activation-lifecycle.md`](docs/activation-lifecycle.md) | [`ACTIVATION_BRIEF`](templates/ACTIVATION_BRIEF.template.md), [`RUN_SHEET`](templates/RUN_SHEET.template.md), [`EVENT_REPORT`](templates/EVENT_REPORT.template.md) | Events and campaigns in five stages: brief, plan, run, report, learn — KPIs set before, measured after |

---

## Quick Start

### Fork and Configure

1. Fork or clone this repository.
2. Open [`docs/architecture.md`](docs/architecture.md) to understand the four
   subsystems.
3. Copy [`templates/TODAY.template.md`](templates/TODAY.template.md) and
   [`templates/DAILY_BRIEF.template.md`](templates/DAILY_BRIEF.template.md)
   to your working root. Fill them in each morning.

### Run the Workflow

```bash
# List all five stages
./workflow/run.sh

# Print a stage's prompt (e.g. plan)
./workflow/run.sh plan
```

Feed a stage's prompt to your AI tool of choice. Work through the stages in
order for every discrete piece of work.

### Use the Templates

- Start a new project with
  [`templates/project-intake/`](templates/project-intake/).
- Log decisions and carry-forwards in
  [`templates/TODAY.template.md`](templates/TODAY.template.md).
- Run a weekly review with
  [`templates/WEEKLY.template.md`](templates/WEEKLY.template.md).
- Start every new project's
  [`SECURITY-PRIVACY.md`](templates/SECURITY-PRIVACY.template.md) at setup.
- Write a [negotiation plan](templates/NEGOTIATION_PLAN.template.md) before
  any deal, and a [handoff](templates/HANDOFF.template.md) before you leave
  the desk.

### See It in Practice

The [`examples/acme-saas/`](examples/acme-saas/) folder walks through a
complete fictional project: a filled-in project intake, a worked five-stage
plan, and a daily snapshot showing the rhythm in action.

---

## How the Real Stack Maps to This

Maestro's generic core is designed to work with any AI tool. In practice, the
author runs a richer internal toolchain layered on top of this frame.

See [`docs/how-i-really-run-it.md`](docs/how-i-really-run-it.md) for how the
generic Maestro concepts map to the actual tools in use — and what is gained by
going beyond the generic core.

---

## Author

Built by **[Mitchell Atiba](AUTHOR.md)** — solo founder, systems thinker, AI orchestrator. See [AUTHOR.md](AUTHOR.md).

## License

MIT — see [LICENSE](LICENSE).
