# Plan — PDF Invoice Export

**Feature:** Generate a PDF copy of an invoice server-side, store it, and return a download URL to the client.

This plan follows the five stages of the Maestro gsd-lite workflow: Discuss → Plan → Execute → Review → Verify.

---

## Stage 00 — Discuss

**Goal (one sentence):** Enable users to download a formatted PDF of any saved invoice.

**Assumptions surfaced:**

- PDF is generated on demand (not pre-generated on save). Confirmed — avoids stale PDFs when line items change.
- Storage is Vercel Blob — already provisioned for the project. Confirmed.
- PDF is regenerated if re-requested after the invoice is edited. Confirmed for now; caching is a follow-up.
- The PDF route is authenticated — only the invoice owner can request it. Confirmed.

**Open questions resolved:**

- Font: Inter (system) for body, Lora for headers. Decision: use Lora for the invoice title and subtotals, Inter for line items — matches the design brief.
- Logo: placeholder SVG for the example; users upload their own in Settings (out of scope for this feature).
- Tax display: show subtotal, tax amount, and total as three separate rows at the bottom of the line-item table.

**Scope boundary:** This plan covers generation, storage, and download URL only. Email delivery is a separate feature.

---

## Stage 01 — Plan

### Tasks

1. Install `@react-pdf/renderer` — done when: package is in `package.json`, TypeScript types resolve, `next build` passes.
2. Create `InvoicePDF` React component (`src/components/invoice-pdf.tsx`) — done when: component renders a valid PDF with invoice number, client name, line items, subtotal, tax, and total using mock data.
3. Create Route Handler `POST /api/invoices/[id]/pdf` — done when: handler fetches the invoice + line items for the authenticated user, renders the PDF, stores it to Vercel Blob, updates `invoices.pdf_url`, and returns `{ url }`.
4. Add `GET /api/invoices/[id]/pdf` — done when: handler returns `{ url: invoices.pdf_url }` if already generated, or triggers generation if `pdf_url` is null.
5. Add "Download PDF" button to the invoice detail page — done when: button calls the GET route, receives the URL, and opens it in a new tab; button is disabled while the request is in flight.
6. Write unit test for `InvoicePDF` snapshot — done when: `pnpm test` passes and the snapshot file is committed.

**Higher-risk tasks (flag for sign-off before execution):**

- Task 3 touches `invoices` table (writes `pdf_url`). Confirm schema migration is included. ✓ Confirmed.

### Success Criterion

A user can open any saved invoice, click "Download PDF," and receive a correctly formatted PDF within 3 seconds — with their invoice number, client details, all line items, and the correct total.

---

## Stage 02 — Execute

**Execution log (abbreviated):**

- ✓ Task 1 complete — `@react-pdf/renderer` installed; build passes.
- ✓ Task 2 complete — `InvoicePDF` renders correctly with mock data; verified via `@react-pdf/renderer`'s local preview.
- ✓ Task 3 complete — POST route generates PDF, stores to Blob, writes URL to DB. Tested with `curl` + a seeded invoice.
- ✓ Task 4 complete — GET route returns existing URL or triggers generation. Idempotent on repeated calls.
- ✓ Task 5 complete — "Download PDF" button wired up; loading state shows spinner; PDF opens in new tab.
- ✓ Task 6 complete — snapshot test committed; `pnpm test` passes.

**Deviation noted:** Task 3 originally planned to stream the PDF directly. Changed to store-then-redirect because Vercel Functions have a 4.5 MB response body limit that a large invoice could hit. Storing to Blob and returning a URL avoids this entirely. No scope change — same user-visible outcome.

---

## Stage 03 — Review

### Review Findings

- [MINOR] `src/components/invoice-pdf.tsx:47` — `tax_rate` multiplied inline without rounding. If `tax_rate * subtotal` produces a fractional cent, the displayed total can drift by $0.01. Fix: round to nearest integer (cents) before display.
- [MINOR] `src/app/api/invoices/[id]/pdf/route.ts:31` — no explicit error logged when Blob upload fails. Silent failure returns a 500 with no context in logs. Fix: add `console.error` with the caught error before rethrowing.
- [SUGGESTION] The `InvoicePDF` component accepts raw invoice data as props. A thin adapter function that maps the Prisma model to PDF props would make the component easier to test in isolation.

### Suggested Follow-ups (out of scope, log for later)

- Cache the generated PDF and serve the stored URL without regenerating on every request (current behavior regenerates on every GET if `pdf_url` is null, but does not invalidate when the invoice is edited).
- User-uploaded logo in PDF (requires Settings feature to be built first).

### Review Verdict

REQUEST_CHANGES — fix the two MINOR findings before merge; SUGGESTION deferred.

---

## Stage 04 — Verify

### Verification

- **Goal:** A user can download a correctly formatted PDF of any saved invoice within 3 seconds.
- **Happy path:** PASS — Created a 5-line-item invoice, clicked "Download PDF," received PDF in 1.3 s. Invoice number, client name, line items, tax row, and total all correct.
- **Edge case (large invoice, 30 line items):** PASS — PDF generated in 2.7 s (within 3 s budget). Layout reflows correctly; no overflow or clipped rows.
- **Edge case (unauthenticated request):** PASS — Route returns 401; no PDF generated.
- **Edge case (invoice belonging to a different user):** PASS — Route returns 404 (not 403 — does not leak existence).

### Verify Verdict

PASS — Goal achieved. Both MINOR findings from Review are fixed and confirmed in the final diff. Feature is ready to merge.
