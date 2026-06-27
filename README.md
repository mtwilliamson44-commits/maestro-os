<!-- markdownlint-disable-file MD041 -->
<!-- TODO: replace OWNER with the GitHub owner at publish -->
[![MIT License](https://img.shields.io/badge/license-MIT-blue.svg)](LICENSE)
[![CI](https://img.shields.io/github/actions/workflow/status/OWNER/maestro/ci.yml?branch=main&label=CI)](https://github.com/OWNER/maestro/actions)

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

A five-stage execution loop for any discrete piece of work:

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
