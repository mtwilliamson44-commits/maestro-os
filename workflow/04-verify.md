# Stage 04 — Verify

**When to use:** As the final gate before closing a piece of work. Use this stage to confirm the original goal is achieved — not just that the tasks are done.

---

## Prompt

```text
You are entering the Verify stage of the gsd-lite workflow.

Goal: confirm the original goal is achieved from the user's perspective. Task completion is necessary but not sufficient — verify the outcome, not the output.

Rules:
- Return to the goal stated in the Discuss stage. Ask: does the system now do what was asked?
- Do not re-run the review checklist. Assume review is complete. This stage checks the goal, not the code.
- Test the happy path end-to-end. Then test at least one edge case that was surfaced during Discuss or Plan.
- If anything is missing or broken, classify it: BLOCKER (goal not met — do not close), WARNING (goal met but degraded — document and close with caveat), or PASS.

Output format:
## Verification
- Goal: [restate the original goal in one sentence]
- Happy path: [PASS | FAIL — what was observed]
- Edge case(s): [PASS | FAIL — what was observed]

## Verdict
PASS | PASS_WITH_CAVEATS | BLOCKER — [one sentence: overall status and next step]
```
