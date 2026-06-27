# Project Intake — Acme SaaS

> **Status:** Fictional example. All names, figures, and requirements are invented.

---

## PRD — Product Requirements Document

**Product name:** Acme SaaS

**One-line description:** A simple invoicing tool for independent consultants who need to create, send, and track invoices without a full accounting suite.

**Problem statement:** Freelance consultants spend 30–60 minutes per invoice copying data between spreadsheets, PDFs, and email. Acme eliminates that by keeping clients, line items, and payment status in one place and generating a send-ready PDF in one click.

**Target user:** Solo or small-team consultants billing 5–30 clients per month. Not accountants. Not enterprises.

**Non-goals:** payroll, expense tracking, tax filing, multi-currency support in v1.

**Success metric:** A new user can create and send their first invoice within 10 minutes of signing up.

**Pricing:** Free tier (5 invoices/month), Pro ($12/month, unlimited).

---

## TRD — Technical Requirements Document

**Stack:** Next.js 14 (App Router), TypeScript, Postgres, Prisma ORM, Resend (transactional email), Stripe (billing).

**Auth:** Email magic-link via Auth.js.

**Hosting:** Vercel (app), Neon (database), Vercel Blob (PDF storage).

**PDF generation:** `@react-pdf/renderer` — rendered server-side on a Vercel Function, stored to Blob, URL returned to client.

**API shape:** REST via Next.js Route Handlers. No GraphQL. No tRPC in v1 — added complexity not warranted by team size.

**Key constraints:**

- PDFs must be generated in under 3 seconds (p95).
- Invoice data must not be readable by other tenants (row-level isolation enforced at the query layer, not just the UI).
- All emails go through Resend; no direct SMTP.

---

## App Flow

```text
Sign up (magic-link)
  └── Dashboard
        ├── Clients list → Add / Edit client
        ├── Invoices list
        │     ├── Create invoice
        │     │     ├── Select client
        │     │     ├── Add line items (description, qty, unit price)
        │     │     ├── Set due date
        │     │     └── Save draft
        │     ├── View invoice → Preview PDF
        │     ├── Send invoice (generates PDF, emails client, marks "Sent")
        │     └── Mark paid
        └── Settings → Profile, billing plan
```

**State machine for an invoice:**

`DRAFT` → `SENT` → `PAID` (or `OVERDUE` if due date passes while `SENT`)

No deletion of sent invoices — archive only.

---

## Design Brief

**Aesthetic:** Clean, minimal, professional. No decorative illustration. Data is the hero.

**Color palette:** Off-white background (#F9F9F8), near-black text (#1A1A1A), single accent (#2563EB — a calm blue for primary actions).

**Typography:** Inter for UI; a serif (Lora) for invoice PDFs to signal formality.

**Components:** Standard shadcn/ui base. No custom component library in v1 — move fast, use defaults.

**Key screens:**

1. Invoice list — table with status badges (Draft / Sent / Paid / Overdue), sortable by date and amount.
2. Invoice editor — two-column layout: form on left, live preview on right.
3. PDF output — clean A4 layout, consultant logo at top-right, line-item table, total, payment instructions.

**Accessibility target:** WCAG 2.1 AA for all interactive elements.

---

## Backend Schema

```sql
-- Users (managed by Auth.js)
users (id, email, name, plan, created_at)

-- Clients
clients (id, user_id, name, email, address, created_at)

-- Invoices
invoices (
  id, user_id, client_id,
  number,        -- auto-incremented per user, e.g. INV-0042
  status,        -- DRAFT | SENT | PAID | OVERDUE
  issued_date,
  due_date,
  subtotal,      -- cents
  tax_rate,      -- decimal, e.g. 0.08
  total,         -- cents
  pdf_url,       -- nullable until generated
  sent_at,       -- nullable
  paid_at,       -- nullable
  created_at, updated_at
)

-- Line items
line_items (
  id, invoice_id,
  description, quantity, unit_price,  -- unit_price in cents
  amount                               -- quantity * unit_price
)
```

All monetary values stored in cents (integer) to avoid floating-point rounding. Tax applied at invoice level, not per line item.

---

## Implementation Plan

**Phase 1 — Core (weeks 1–3):**

- Auth (magic-link sign-up/login)
- Client CRUD
- Invoice CRUD (draft state only)
- Line item management within invoice editor

**Phase 2 — Send & Track (weeks 4–5):**

- PDF generation (server-side, stored to Blob)
- Email send via Resend
- Invoice status transitions (DRAFT → SENT → PAID)
- Overdue detection (scheduled job, daily)

**Phase 3 — Billing & Polish (weeks 6–7):**

- Stripe integration (free vs. Pro gating)
- Invoice numbering (auto-increment per user)
- Dashboard metrics (total outstanding, paid this month)
- Accessibility audit and fixes

**Not in scope for v1:** recurring invoices, client portal, payment collection (Stripe invoicing), mobile app.
