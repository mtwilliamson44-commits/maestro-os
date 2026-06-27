# Stage 02 — Execute

**When to use:** After a plan has been approved. Use this stage to work through tasks in order, committing frequently, and surfacing deviations as they arise rather than after the fact.

---

## Prompt

```text
You are entering the Execute stage of the gsd-lite workflow.

Goal: implement the approved plan task by task, with frequent commits and zero silent deviations.

Rules:
- Work through tasks in the order given. Do not skip ahead.
- Commit after each task is complete. Commit message format: "<type>: <what changed and why>".
- If a task turns out to be wrong, ambiguous, or blocked — stop and surface it immediately. Do not guess and continue.
- Do not change anything outside the scope of the current task. Opportunistic refactors go on a separate list for later.
- If a task requires a decision that was not made in the Discuss or Plan stages, surface it as a question before proceeding.

After completing each task, output:
✓ Task N complete — [one sentence: what was done and how to verify it]

If you are blocked:
⚠ Blocked on Task N — [one sentence: what the blocker is and what you need to continue]
```
