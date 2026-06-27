# Architecture: The Orchestration Model

## Thesis

Coding is largely solved. Large language models can produce correct, idiomatic code across most stacks and domains. What remains unsolved is the layer above: deciding what to build, in what order, with what constraints, and knowing when the result actually achieves the goal.

Maestro is built on a single thesis: **the operator directs; the AI executes.** The operator — a human engineer or founder — retains ownership of goals, priorities, and acceptance criteria. The AI handles implementation, review, and mechanical verification. The system is designed so that human judgment is applied where it has the highest leverage, and AI execution is applied where consistency and throughput matter most.

This is not about removing the human from the loop. It is about placing the human at the right point in the loop.

---

## The Four Subsystems

Maestro composes four subsystems into a single continuous loop:

```text
Rhythm → Workflow → Build Standard → Knowledge Loop
   ↑                                        │
   └────────────────────────────────────────┘
```

### 1. Rhythm

Rhythm is the daily operating cadence. It answers the question: *when does work happen, and in what sequence?* A session begins with scoping and planning, moves into autonomous execution, and closes with a written summary and review. Without rhythm, even good workflow tools produce inconsistent output because the inputs — the goals and context — arrive inconsistently.

See `workflow/daily-rhythm.md` for the session structure.

### 2. Workflow

Workflow is the five-stage execution loop that governs any discrete piece of work:

| Stage | Purpose |
| --- | --- |
| `00-discuss` | Surface assumptions; close knowledge gaps |
| `01-plan` | Decompose the goal into ordered, testable tasks |
| `02-execute` | Implement task by task with frequent commits |
| `03-review` | Check the diff for correctness and simplification |
| `04-verify` | Confirm the original goal is achieved |

Each stage is a prompt file. The `run.sh` orchestrator lists stages and prints any stage on demand — no framework required, no dependencies to install.

### 3. Build Standard

The build standard defines what "done" means at the code level: branch conventions, commit format, test requirements, lint and type-check gates. It is enforced by CI and by the review stage of the workflow. A change is not complete because the tasks are checked off — it is complete when it passes the build standard.

See `workflow/git-branch-workflow.md` for the branching model.

### 4. Knowledge Loop

The knowledge loop captures what is learned in each session and makes it available to future sessions. Templates, examples, and patterns extracted from real work are stored in the `knowledge/` and `templates/` directories. Each session can be seeded with relevant context so that the AI does not re-derive decisions that have already been made.

---

## Quality Gates

The workflow has two explicit quality gates before a change is considered done:

**Review gate (`03-review`):** Runs after execution, before merge. Checks for correctness bugs, silent failures, and unnecessary complexity. Classified findings (CRITICAL, MAJOR, MINOR) must be resolved before the gate passes. This gate is code-level.

**Verify gate (`04-verify`):** Runs after review passes. Checks that the original goal — stated in the Discuss stage — is actually achieved. Happy path and at least one edge case must pass. This gate is goal-level.

Both gates are required. A change that passes review but fails verify has technically correct code that does not deliver the expected outcome. A change that passes verify but skips review may deliver the outcome once, but with hidden fragility that breaks under load or future changes.

---

## Diagram

A visual map of the full system is at `diagrams/system-map.svg`.

---

## Design Principles

- **Dependency-free core.** The `workflow/run.sh` orchestrator is plain bash. No Node, no Python, no package manager required to use the workflow.
- **Prompt files as source of truth.** Stage prompts are versioned files, not embedded strings. They can be reviewed, improved, and diffed like code.
- **Operator authority.** The operator approves the plan before execution begins. The operator reviews the summary before the next session starts. AI autonomy is bounded by these two checkpoints.
- **Generic by default.** No workflow file references a specific project, client, or technology stack. Forks customize on top of the generic base.
