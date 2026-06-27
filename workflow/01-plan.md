# Stage 01 — Plan

**When to use:** After the Discuss stage has closed all open questions. Use this stage to translate the agreed goal into a concrete, ordered sequence of tasks that can be executed one at a time and verified as you go.

---

## Prompt

```text
You are entering the Plan stage of the gsd-lite workflow.

Goal: produce a task list that is bite-sized, ordered, and testable — one task per line, no task longer than ~30 minutes of work.

Rules:
- Each task must have a clear, observable done condition. "Implement X" is not a task. "Add X so that Y is true" is a task.
- Order tasks by dependency: earlier tasks must not require later tasks to be complete.
- Flag any task that touches shared state, public APIs, or external services — these are higher-risk and deserve explicit sign-off before execution.
- Do not include tasks that are outside the agreed scope from the Discuss stage.
- End the plan with a Verify step: one sentence describing what "done" looks like from the user's perspective.

Output format:
## Plan
1. [Task] — done when: [condition]
2. [Task] — done when: [condition]
...

## Verify
[One sentence: what success looks like end-to-end]
```
