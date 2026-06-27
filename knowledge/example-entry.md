# Example Entry — How to Use This Loop

| Field | Value |
| --- | --- |
| **Title** | The Twelve-Factor App |
| **Source** | [12factor.net](https://12factor.net) (Adam Wiggins, Heroku) |
| **Date Added** | 2026-06-27 |
| **Type** | Reference |
| **Tags** | `architecture`, `devops`, `saas`, `twelve-factor` |

---

## Thesis

A methodology for building software-as-a-service apps that are portable, scalable, and maintainable — defined by twelve explicit constraints on how code, configuration, processes, and dependencies relate.

---

## Key Points

- **Codebase:** One codebase tracked in version control; many deploys. Never share code between apps via file-system copies — use a dependency manager.
- **Dependencies:** Explicitly declare and isolate all dependencies. Never rely on implicit system-wide packages.
- **Config:** Store config in the environment, not in code. Anything that varies between deploys (credentials, hostnames, ports) belongs in env vars.
- **Backing services:** Treat databases, queues, caches, and mailers as attached resources — swappable without code changes.
- **Build, release, run:** Strictly separate the build stage (compile + bundle) from release (build + config) from run (execute in the runtime environment).
- **Processes:** Execute the app as one or more stateless processes. Persistent data goes in a stateful backing service, never in local memory or disk.
- **Port binding:** Export services via port binding; the app is self-contained and does not rely on runtime injection of a webserver.
- **Concurrency:** Scale out via the process model. Different process types (web, worker) scale independently.
- **Disposability:** Maximize robustness with fast startup, graceful shutdown, and crash-safe design.
- **Dev/prod parity:** Keep development, staging, and production as similar as possible in time, personnel, and tooling.
- **Logs:** Treat logs as event streams — write to stdout and let the execution environment route, aggregate, and store them.
- **Admin processes:** Run one-off admin tasks (migrations, console tasks) as one-off processes in the same environment as the app.

---

## Insights

- The config-in-environment constraint is deceptively powerful: it forces a clean boundary between code (which is the same across all deploys) and runtime context (which differs). This one rule eliminates entire categories of secrets-in-code vulnerabilities.
- The stateless-process constraint makes horizontal scaling a default outcome rather than a retrofit. Apps that store session state locally are expensive to scale and fragile under restarts.
- Dev/prod parity is the discipline most teams skip — and the one that causes the most "works on my machine" failures. The methodology makes the cost visible.
- The methodology predates containers but maps almost perfectly onto container-native deployment. Understanding it clarifies *why* Docker and Kubernetes are designed the way they are.

---

## Application Ideas

- **→ Apply to your flagship product:** Audit your app against all twelve factors. Focus first on config (are any credentials hardcoded or in `.env` files committed to git?) and stateless processes (is any session state stored in local memory?).
- **→ Apply to your deployment pipeline:** Add a `dev/prod parity` check to your PR template — confirm that the local dev stack uses the same backing service versions as production.
- **→ Apply to your onboarding docs:** Use the twelve factors as a checklist when onboarding a new engineer — it surfaces hidden assumptions about the runtime environment early.
