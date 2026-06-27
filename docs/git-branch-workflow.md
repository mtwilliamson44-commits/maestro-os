# Git Branch Workflow

This document defines the canonical branching strategy, commit conventions, and
release process for any project that forks Maestro. It is the single source of
truth for how code moves from a developer's local machine to production.

---

## 1. Branch Hierarchy

| Branch | Purpose | Who merges into it | Protected |
| --- | --- | --- | --- |
| `feature/*`, `fix/*`, `chore/*` | Active development | PR → `dev` | No |
| `dev` | Integration target; always green | Merged features/fixes | Yes |
| `staging` | Pre-production UAT | Promoted from `dev` | Yes |
| `main` | Production source of truth | Promoted from `staging` | Yes |

Code flows in one direction only:
feature branches → `dev` → `staging` → `main`.
No direct commits to `dev`, `staging`, or `main`
(except hotfixes — see Section 5).

---

## 2. Branch Naming

| Prefix | Use when |
| --- | --- |
| `feature/` | New user-facing functionality |
| `fix/` | Bug fix that does not need immediate production release |
| `chore/` | Tooling, deps, CI, docs, refactor — no behavior change |
| `hotfix/` | Critical production fix that cannot wait for the normal cycle |

**Format:** `<prefix>/<short-slug>` using lowercase kebab-case.

Examples:

- `feature/user-invite-flow`
- `fix/token-expiry-edge-case`
- `chore/upgrade-eslint-v9`
- `hotfix/stripe-webhook-signature`

Branch names must not contain spaces, uppercase letters, or special characters
other than `/` and `-`.

---

## 3. Full Feature Lifecycle

### 3.1 Start a Feature

```bash
# Always branch from the latest dev
git checkout dev
git pull origin dev
git checkout -b feature/my-feature
```

### 3.2 Develop Locally

- Commit frequently using Conventional Commits (see Section 6).
- Keep the branch short-lived — aim to merge within one to three days.
- Rebase onto `dev` before opening a PR to keep history linear.

```bash
git fetch origin
git rebase origin/dev
```

### 3.3 Open a Pull Request to `dev`

- PR title must follow the Conventional Commits format.
- Fill in the PR template: what changed, how to test, screenshots if UI.
- At least one peer review approval is required before merging.
- All CI checks (lint, type-check, unit tests) must pass.
- Merge strategy: **squash merge** — one commit per feature on `dev`.

### 3.4 Integration Testing on `dev`

- `dev` is deployed automatically to the integration environment after every
  merge.
- Automated integration tests run against the integration environment.
- Any failure blocks the next promotion to `staging`.

### 3.5 Promote to `staging`

When `dev` is stable and a release candidate is ready:

```bash
git checkout staging
git pull origin staging
git merge --no-ff dev -m "chore: promote dev to staging for release X.Y.Z"
git push origin staging
```

- `staging` is deployed automatically to the staging environment.
- Staging must use production-equivalent configuration (see Section 7).

### 3.6 Human UAT Gate

Before promoting to `main`, a designated reviewer performs manual
user-acceptance testing on the staging environment.

**Adapt this checklist to your product.** At minimum, cover:

- Core user journeys work end-to-end.
- Any features included in this release are exercised.
- No regressions in critical paths compared to the previous release.
- Error states and edge cases behave as designed.
- Any third-party integrations in scope function correctly.

If UAT fails, create a `fix/` branch from `dev`, resolve the issue, and
restart the promotion cycle from Section 3.4. Do not patch `staging` directly.

### 3.7 Promote to `main` and Tag

When UAT passes:

```bash
git checkout main
git pull origin main
git merge --no-ff staging -m "chore: promote staging to main v1.2.0"
git tag -a v1.2.0 -m "Release v1.2.0"
git push origin main --tags
```

- Every merge to `main` must carry a version tag (see Section 9).
- Trigger a production deployment immediately after tagging.
- Announce the release in your team's chosen channel.

---

## 4. Post-Release Cleanup

After a successful production release:

```bash
# Delete merged feature branches
git branch -d feature/my-feature
git push origin --delete feature/my-feature
```

Feature branches that are more than two weeks old and not actively worked on
should be deleted even if unmerged — stale branches signal abandoned work.

---

## 5. Hotfix Flow

Use hotfixes only for critical production defects that cannot wait for the
normal `dev → staging → main` cycle.

```bash
# Branch from main, not dev
git checkout main
git pull origin main
git checkout -b hotfix/critical-issue

# Fix, commit, push
git add .
git commit -m "fix: resolve critical issue in production"
git push origin hotfix/critical-issue
```

Open a PR directly against `main`. After review and CI pass:

```bash
git checkout main
git merge --no-ff hotfix/critical-issue -m "fix: critical issue (hotfix)"
git tag -a v1.2.1 -m "Hotfix v1.2.1"
git push origin main --tags
```

**Immediately back-merge the hotfix into `dev` and `staging`** so branches do
not diverge:

```bash
git checkout dev
git merge main
git push origin dev

git checkout staging
git merge main
git push origin staging
```

Delete the hotfix branch after merging.

---

## 6. Conventional Commits

All commit messages must follow the
[Conventional Commits 1.0.0](https://www.conventionalcommits.org/)
specification.

**Format:**

```text
<type>(<optional scope>): <short description>

[optional body]

[optional footer(s)]
```

The short description must be lowercase and must not end with a period.
Keep it under 72 characters.

### Commit Type Table

| Type | When to Use |
| --- | --- |
| `feat` | New feature visible to users |
| `fix` | Bug fix visible to users |
| `docs` | Documentation changes only |
| `style` | Formatting, whitespace — no logic change |
| `refactor` | Code restructure with no behavior change |
| `perf` | Performance improvement |
| `test` | Adding or updating tests |
| `build` | Build system or external dependency changes |
| `ci` | CI/CD pipeline changes |
| `chore` | Anything else (tooling, scripts, config) |
| `revert` | Reverts a previous commit |

### Breaking Changes

Append `!` after the type/scope for breaking changes, and include a
`BREAKING CHANGE:` footer:

```text
feat(api)!: change pagination shape to cursor-based

BREAKING CHANGE: callers must migrate from page/limit to cursor/after.
```

---

## 7. Per-Environment Variables and `.env.example`

### Environment Tiers

| Tier | Branch | Config Source |
| --- | --- | --- |
| Local | any feature branch | `.env.local` (git-ignored) |
| Integration | `dev` | CI secrets / environment platform |
| Staging | `staging` | Environment platform (prod-equivalent values) |
| Production | `main` | Environment platform (live values) |

### Rules

1. **Never commit real secrets.** `.env`, `.env.local`, and any file matching
   `*.secret` must be in `.gitignore`.
2. **`.env.example` is always committed.** It documents every variable the
   application reads, with placeholder values and a one-line comment per key.
3. **Staging must use production-equivalent config.** Use a separate API key
   for a staging project/tenant — not the production key — but the same
   services. This is what makes staging a valid UAT gate.
4. **No environment-specific code branches.** Do not write
   `if (ENV === 'staging')`. All environments should run identical code;
   only config values differ.

### `.env.example` Format

```dotenv
# Application
APP_URL=https://your-domain.com
PORT=3000

# Database
DATABASE_URL=postgresql://user:password@host:5432/dbname

# Authentication
AUTH_SECRET=change-me-generate-with-openssl-rand-base64-32
AUTH_URL=https://your-domain.com

# Third-party integrations
PAYMENT_PROVIDER_KEY=your-key-here
EMAIL_PROVIDER_API_KEY=your-key-here
```

---

## 8. Branch Protection Rules

Configure these rules in your git hosting platform (GitHub, GitLab, Bitbucket)
before the first merge.

### `main`

- Require pull request before merging.
- Require at least 1 approving review.
- Dismiss stale pull request approvals when new commits are pushed.
- Require status checks to pass: `lint`, `typecheck`, `test`.
- Require branches to be up to date before merging.
- Do not allow force-pushes.
- Do not allow deletion.
- Restrict who can push directly (emergency hotfix only, by admin).

### `staging`

- Require pull request before merging.
- Require at least 1 approving review.
- Require status checks to pass: `lint`, `typecheck`, `test`.
- Do not allow force-pushes.
- Do not allow deletion.

### `dev`

- Require pull request before merging.
- Require status checks to pass: `lint`, `typecheck`, `test`.
- Do not allow force-pushes.

---

## 9. Semantic Versioning

This project follows [Semantic Versioning 2.0.0](https://semver.org/).

**Format:** `vMAJOR.MINOR.PATCH`

| Segment | Increment when |
| --- | --- |
| `MAJOR` | Breaking change incompatible with previous releases |
| `MINOR` | New backward-compatible functionality |
| `PATCH` | Backward-compatible bug fix |

### Pre-release Identifiers

| Tag | Meaning |
| --- | --- |
| `v1.2.0-alpha.1` | Early, unstable — not for end users |
| `v1.2.0-beta.1` | Feature-complete, may have known issues |
| `v1.2.0-rc.1` | Release candidate, undergoing final UAT |

### Versioning Discipline

- Version is determined at the time of promotion to `main`, not when a feature
  is written.
- A release that contains any `BREAKING CHANGE` footer must bump `MAJOR`.
- A release that contains any `feat` commit must bump at least `MINOR`.
- A release that contains only `fix`, `perf`, `docs`, or `chore` bumps `PATCH`.
- Version `0.x.y` is the pre-stable phase — breaking changes may occur in
  minor bumps until `v1.0.0` is declared.

---

## 10. Quick Reference Card

### Day-to-day commands

```bash
# Start new work
git checkout dev && git pull && git checkout -b feature/my-work

# Keep branch current
git fetch origin && git rebase origin/dev

# Commit
git commit -m "feat(scope): short description"

# Open PR → target: dev
```

### Promotion commands

```bash
# dev to staging
git checkout staging
git merge --no-ff dev -m "chore: promote dev to staging vX.Y.Z"
git push

# staging to main + tag
git checkout main
git merge --no-ff staging -m "chore: promote staging to main vX.Y.Z"
git tag -a vX.Y.Z -m "Release vX.Y.Z"
git push origin main --tags
```

### Hotfix in 30 seconds

```bash
git checkout main && git pull && git checkout -b hotfix/issue
# fix, commit, PR → main, merge, then:
git checkout dev && git merge main && git push
git checkout staging && git merge main && git push
```

### Branch name quick-pick

| Scenario | Branch name |
| --- | --- |
| New feature | `feature/what-it-does` |
| Bug fix (non-urgent) | `fix/what-was-broken` |
| Tooling/chore | `chore/what-changed` |
| Critical prod fix | `hotfix/what-broke-in-prod` |

### Commit type cheat sheet

```text
feat   fix   docs   style   refactor   perf   test   build   ci   chore   revert
```

Add `!` and `BREAKING CHANGE:` footer for any breaking change.
