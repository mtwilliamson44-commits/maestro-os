# Decision Rules

A solo founder makes hundreds of small allocation decisions a week, alone, with
no one to push back. Written decision rules do the pushing. They are
operational, not aspirational: each one should change what you do on a specific
day.

Copy these, then rewrite them for your own portfolio. The thresholds below are
examples — pick your own and write them down.

---

## 1. Priority Hierarchy

When two things compete for time, this is the order:

```text
1. REVENUE   — sales, client delivery, paying users
2. PRODUCT   — features that unblock revenue or retain users
3. SYSTEMS   — workflows that remove repeated decisions or wasted time
4. LEARNING  — only if it directly enables 1, 2 or 3
5. EVERYTHING ELSE — default: don't
```

Anything outside 1–3 needs a strong justification.

---

## 2. The Decision Filter

Before committing to a task, project or idea:

1. **Revenue test** — does it generate or enable revenue in the next 30 days?
   Yes → proceed. No → next test.
2. **Leverage test** — does it multiply output or remove a recurring time cost?
   Yes → proceed, time-boxed. No → next test.
3. **Urgency test** — is there a real consequence if it waits a week?
   Yes → proceed. No → **park it or delete it.**
4. **Opportunity cost** — what are you *not* doing if you do this? If that is
   higher priority, do that instead.

---

## 3. Client and Sales Decisions

**Pursue a lead when** they have a real problem in your domain, a budget (or a
clear return you can point to), and you can deliver within your current
expertise.

**Walk away when** scope grows without price growing, they want free advice
before paying (one free session at most), or the work is outside your domain.

**Pricing:** anchor on value delivered, not hours. Never underprice to get a
foot in the door — it sets the expectation for every later invoice. If unsure,
quote higher and negotiate down. See [negotiation](negotiation.md).

**"Let me think about it":** set a specific follow-up time before the
conversation ends. Follow up in 48 hours if there is no reply. After two
unanswered follow-ups, close the loop and move on.

---

## 4. Product Build Decisions

**Build a feature when** a real user asked for it, it removes a blocker to
getting or keeping a paying user, and a working version can ship within a week.

**Don't build it when** you thought of it with no user input, it would impress
engineers but not the people who use it, it needs an architecture change before
you have meaningful usage, or it is interesting rather than needed.

**Build vs buy:** if an API or existing tool does it, use that. Time spent on
commodity infrastructure is time not spent on what is unique to you.

**Stop building and go sell when** you haven't talked to a prospective user in
a week, the current version is usable and you are still polishing, or you are
shipping features nobody has asked about.

---

## 5. Tuning a Running System

For anything rule-driven that runs on its own — a pricing rule, an automation,
a scoring model:

**Change it when** a rule fails consistently in the conditions it was designed
for, or a tested change shows a clear improvement without a new downside.

**Don't change it when** you are bored, you had one bad week and want to fix it
emotionally, the change needs a core rebuild, or the current rules haven't run
long enough to judge.

Give side systems a hard weekly time cap. If one needs more, simplify it.

---

## 6. New Ideas — the 30-Day Parking Rule

When a new idea arrives, ask: does it **replace** something you are doing, or
**add** to the plate?

- Replaces, and is clearly better → evaluate it seriously.
- Adds → park it in a backlog file for 30 days. If you still care in 30 days,
  evaluate it. If you forgot about it, it wasn't important.

---

## 7. Hard Stops

Traps. Don't rationalise exceptions.

| Rule | Why |
| --- | --- |
| Don't start a new product before the current one has paying users | You will abandon the first before it earns |
| Don't take work outside your niche | Domain dilution — the niche is the edge |
| Don't build features before talking to users | You will build the wrong thing |
| Don't rewrite working code just to make it cleaner | Ship; refactor when it blocks growth |
| Don't take meetings without a clear outcome | Your time is the constraint |
| Don't accept unpaid "pilot" engagements | They rarely convert — charge from day one |
| Don't read about productivity instead of working | This document is enough system |

---

## 8. When You're Stuck

1. Open `TODAY.md`. What is Top 3 item #1?
2. What is the smallest action that moves it?
3. Do that. Not the second thing.

If you know what to do and aren't doing it, that is resistance, not a planning
problem. Set a 25-minute timer and start.

**When someone asks for your time:** are they a potential customer, referral
source, or collaborator on priority 1 or 2? If not, decline or defer. Protecting
your time is professional, not rude.

---

## 9. Decision Authority — Operator vs AI

When an AI agent executes autonomously, write down what it may decide alone.

**The AI may:** make implementation calls, choose between equivalent approaches,
and resolve ambiguity inside an approved scope — flagging every non-obvious call
for the end-of-session summary (see the [rulings ledger](build-process.md#2-the-rulings-ledger)).

**The AI must stop and ask before:**

- a user-visible product change that was not agreed in planning
- any destructive data operation
- a new external service or credential
- merging to a protected branch or pushing, unless explicitly told to

Above a size threshold (for example, more than one file or roughly 20 lines),
the AI states the plan and affected files and waits for a yes. Below it, it acts
and summarises after.

---

## 10. Two Working Modes

Agreeable assistants are a real failure mode: they validate the plan and ship
the easy 80%. Two named modes counter that. Invoke them by name.

### Challenge mode

For plans, ideas and strategies. The assistant:

- leads with what is wrong, unclear or risky — never with what is good
- names every unstated assumption and ranks them by how likely they are to be
  wrong
- states the honest downside if the three weakest assumptions fail
- checks for idea-hopping — is this a new version of a bet that already failed?
- holds its position under pushback unless given a new argument or evidence
- ends with the one question the operator most wants to avoid

Critique first; solutions only when asked.

### Finish mode

For delivery. The assistant commits to the whole thing: no workarounds, no
stubs, no "fix it later", no TODOs in delivered code. A genuine external blocker
is named explicitly, with the minimum needed to unblock it. Before reporting
done:

- [ ] Works end to end, including error states
- [ ] Nothing stubbed or left as a placeholder in production code
- [ ] No TODO / FIXME / HACK left behind
- [ ] Nothing in scope quietly deferred
- [ ] A second developer tomorrow would find no loose end
