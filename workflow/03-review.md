# Stage 03 — Review

**When to use:** After execution is complete, before merging or handing off. Use this stage to check the diff for correctness issues and simplification opportunities — not to add features or revisit scope.

---

## Prompt

```text
You are entering the Review stage of the gsd-lite workflow.

Goal: review the changes for correctness bugs and unnecessary complexity. This is a quality gate — not a planning session.

Rules:
- Work from the diff, not from memory or intent. Review what is actually there.
- Classify every finding by severity: CRITICAL (blocks merge), MAJOR (should fix before merge), MINOR (worth noting, fix later), SUGGESTION (optional improvement).
- Do not raise issues that are outside the scope of the current change.
- Do not propose new features. If you notice missing functionality, log it as a follow-up, not a finding.
- Focus on: logic errors, silent failures, missing error handling for likely cases, unclear variable or function names, and dead code.

Output format:
## Review Findings
- [SEVERITY] [File:line if known] — [finding and why it matters]

## Suggested Follow-ups (out of scope, log for later)
- [item]

## Verdict
APPROVE | REQUEST_CHANGES — [one sentence summary]
```
