# How I Really Run It

Maestro's generic core works with any AI tool that accepts text prompts.
This document names the actual toolchain the author uses in practice — so you
know this system runs on real production work, not a thought experiment — and
explains how each Maestro concept maps to a specific tool.

This is a description of tools and patterns only. No private paths, config
files, or aliases are included here.

---

## The Generic Core vs. The Real Stack

Maestro's public frame is deliberately generic. The workflow stages are prompt
files; the orchestrator is plain bash; the templates are markdown. Any AI
assistant and any project structure can slot in.

In practice, the author runs three layers on top of that generic core:

| Maestro Layer | Generic Form | Real Tool |
| --- | --- | --- |
| Rhythm | TODAY/DAILY\_BRIEF templates + manual fill-in | GSD (Get Stuff Done) — a structured phase-and-session management system |
| Workflow | `workflow/run.sh` → 5-stage prompt files | GSD phases + superpowers skill library |
| Build Standard | `docs/git-branch-workflow.md` | gstack — a CLI toolchain for build, review, and deploy |
| Knowledge Loop | `knowledge/INDEX.md` + manual entries | GSD knowledge capture + gbrain (a semantic search layer over the knowledge base) |

---

## GSD — The Rhythm and Workflow Layer

GSD (Get Stuff Done) is an opinionated session management system that
implements the Maestro rhythm and workflow at a higher level of automation.

Where the generic Maestro rhythm asks you to fill in a TODAY template and a
DAILY\_BRIEF manually, GSD automates the scaffolding: it reads active project
state, generates a morning briefing, and surfaces what needs attention without
requiring manual aggregation across projects.

Where the generic Maestro workflow is five prompt files you invoke yourself,
GSD wraps each stage in a structured phase: discuss-phase, plan-phase,
execute-phase, review-phase, verify-phase. Each phase is an agent-driven
workflow that handles the stage's outputs (PLAN.md, REVIEW.md, VERIFICATION.md)
automatically, so the operator's job is approval and direction — not mechanics.

The core discipline is the same: you don't skip stages. Discuss surfaces
assumptions before planning begins. Planning is approved before execution
starts. Review runs before verify. Verify closes the loop on the original goal.
GSD enforces this sequence; the generic workflow communicates it through
documentation and convention.

---

## Superpowers — The Agent Skill Library

The five Maestro workflow stages describe *what* to do at each stage. The
superpowers library provides *how* — a set of named, reusable agent skills that
implement recurring patterns across stages.

Examples of the mapping:

| Maestro Stage | Superpowers Skill |
| --- | --- |
| `01-plan` | `writing-plans` — structured plan authorship with goal-backward verification |
| `02-execute` | `executing-plans` — task-by-task execution with atomic commits |
| `03-review` | `requesting-code-review` / `receiving-code-review` |
| `04-verify` | `verification-before-completion` |

Skills are invoked as commands in the Claude Code CLI. They keep agent behavior
consistent across sessions and projects — the equivalent of having a defined
playbook for each workflow stage rather than re-specifying the approach from
scratch each time.

The `superpowers:systematic-debugging` and `superpowers:subagent-driven-development`
skills extend the workflow into scenarios not covered by the basic five stages:
complex multi-file investigations and parallel agent work on independent
tasks.

---

## gstack — The Build Standard Layer

gstack is a CLI toolchain that implements the Maestro build standard as
automated gates rather than documentation to follow manually.

Where `docs/git-branch-workflow.md` describes branch conventions and CI
requirements, gstack enforces them: automated code review runs on every diff,
deploy targets are registered and validated, sanitization checks run before any
commit that touches public-facing content.

The key difference from the generic build standard is automation vs. convention.
The generic build standard documents what "done" means; gstack verifies it
mechanically. A change does not clear the build standard because the developer
believes it is correct — it clears because gstack's review, lint, typecheck,
and sanitization gates all pass.

For the solo-founder context, gstack's most practical contribution is removing
the temptation to skip review when moving fast. The gates are automated and
fast; skipping them requires more effort than running them.

---

## gbrain — The Knowledge Loop Layer

The generic knowledge loop is `knowledge/INDEX.md` — a markdown file you
update manually after each session with what was learned and how it applies.

In practice, the author uses gbrain: a semantic search layer indexed over the
knowledge base and the active codebase. Rather than scanning INDEX.md manually
to find relevant prior context, you query gbrain: "what did we decide about
pagination?" or "where is this pattern implemented?" and gbrain surfaces the
relevant knowledge without requiring you to remember where it was stored.

The pattern is the same as the generic loop — capture what you learn, seed it
into the next session — but gbrain replaces the manual lookup with a query
interface. The knowledge compounds in the same way; the retrieval is faster and
more reliable.

---

## Why the Generic Core Still Matters

The generic Maestro core — the five prompt files, the templates, the bash
orchestrator — is not a simplification of the real stack. It is the
architecture that the real stack implements.

Understanding the generic core tells you *why* GSD, superpowers, and gstack are
structured the way they are. The five workflow stages are not GSD's invention;
they are the discipline GSD automates. The build standard gates are not
gstack's invention; they are the quality criteria from `git-branch-workflow.md`
made mechanical.

If you are starting from the generic Maestro core, you can add tooling
incrementally as the friction points become clear. Start with the five-stage
workflow and the daily rhythm templates. Add a semantic knowledge layer when
manual lookup becomes the bottleneck. Add automated review gates when manual
discipline starts to slip under speed pressure. The architecture scales with
the tooling.

The thesis is the same at every level: the operator directs; the AI executes;
the system holds both accountable.
