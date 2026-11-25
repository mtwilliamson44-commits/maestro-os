# Negotiation and Deal Plans

A solo founder negotiates constantly: client scopes, partnerships, licences,
co-founder splits, pricing. The analysis is usually the easy part. Most deals
are lost on **sequencing** — work started before the paper was signed, terms
agreed verbally with someone who could not sign, a confirmation note drafted and
never sent, friendship standing in for terms.

This method fixes the order. Every negotiation gets a written plan before the
meeting, a debrief after it, and a confirmation note the same day.

---

## 1. The Rules

1. **Paper before building.** No work starts on a verbal agreement.
2. **Settle ownership before the first hour of work.** Whose company, whose
   revenue, whose name and IP — decided first, not "later".
3. **Free is a decision.** If you do something unpaid, write it down with an end
   date. Unwritten free work becomes the expected price.
4. **Friends get the same contract — because they are friends.** Clear terms
   protect the relationship.
5. **Lend your name and method; never give them away.** License, don't assign.
6. **Send the confirmation note the same day.** What was agreed, what is still
   open, next step. A note sent tomorrow is a note that never gets sent.
7. **Never sign on the day.** Have a pause line ready: *"Let me think it over —
   can you send me something on one page?"*
8. **Price the work, not the relationship.** Know your rate before the
   conversation starts, and never disclose what a subcontractor costs you.

---

## 2. The Plan

Before any meeting where terms are at stake, fill in
[`templates/NEGOTIATION_PLAN.template.md`](../templates/NEGOTIATION_PLAN.template.md).
Pre-fill everything you already know, then close the gaps one section at a
time.

The plan follows the six foundations of information-based bargaining described
by G. Richard Shell in *Bargaining for Advantage* (recommended reading). In
short:

| Foundation | The question it makes you answer |
| --- | --- |
| Your style | What are your natural tendencies at the table, and where do they hurt you? |
| Goals | What specific, ambitious outcome are you aiming for, and why is it justified? |
| Standards | What market rates, precedents or norms support your position — and which will they cite? |
| Relationships | What is the history and trust, and who influences or can bind the other side? |
| Their interests | What do they need that they are not saying, and what do they lose with no deal? |
| Leverage | Who loses more if this falls through, and what is your walk-away? |

Two additions on top of the foundations:

- **Ownership check** — company, revenue, name/IP, signed or verbal, equity now
  or "later", calculated on revenue or on profit.
- **Constraints that bind regardless of the deal** — tax, permits, funding
  conditions, regulatory rules. List them as questions for the right adviser.
  Never answer them from your own notes.

A number without a standard is just an opinion. Find real market references and
cite the source.

Close the plan by writing down your walk-away and your pause line.

---

## 3. The Debrief

After the meeting, fill in the debrief section of the same file: what was
agreed, what was left open, which concessions you made, what you would do
differently.

Then draft the **same-day confirmation note** and tick it only once it has
actually been sent. The debrief is where the sequencing habit is built; skipping
it is the most common way the plan stops working.

---

## 4. Where Plans Live

Plans contain figures and other people's positions. Store them by sensitivity:

| Plan involves… | Store in |
| --- | --- |
| Your own pay, employment, legal or personal finances | A private, local-only folder that is never git-tracked |
| Your business selling a service or product | The business repo's negotiation folder |

Name files `YYYY-MM-DD-<counterparty>.md` using the meeting date. **When in
doubt, use the private folder.** If you keep a tracker of live cases, a private
plan's row says only "private" — no path, no figures.

---

## 5. Client Engagements

For consulting or build work, the negotiation plan sits inside a short intake
flow:

1. **Before the meeting — a meeting brief.** Who the client is, what they think
   they need, how they found you and how urgent it is, known constraints, and
   what you want to walk out with. Add discovery questions and a watch-out list.
2. **After the meeting — a debrief intake.** Ask yourself, one at a time: What
   do they actually need, underneath what they said? What does success look
   like to them? Is this build, advisory, or mixed? How complex is it? What will
   it need technically? Your honest estimate in weeks? What budget signals came
   up? How hard is the deadline? Was the decision-maker in the room? Any red
   flags?
3. **Proposal and milestone plan** generated from the intake.
4. **Capacity review** — does this overlap with active work? What risks
   surfaced? Approve, revise scope, or decline, with a one-line reason.
5. **Calendar block** — only after approval.

---

## Fictional Example

> A partner proposes co-building a booking add-on for Acme SaaS: "we'll sort the
> split once it's earning." The plan's ownership check flags it straight away —
> unsettled IP, a split on profit rather than revenue, nothing signed. The
> opening becomes: a licence of the existing invoicing engine, a revenue share,
> and a one-page term sheet before any build starts. The meeting ends with the
> pause line, and a confirmation note goes out that evening.
