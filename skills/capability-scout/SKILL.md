---
name: capability-scout
description: Find existing capabilities before building from scratch: installed skills and tools, libraries, MCP servers, APIs, SDKs, services, and techniques. Use when the user asks "is there a tool or library for X" or "find existing solutions before we build". Also fires when the agent itself has a clear goal but no reliable implementation path and building from scratch looks premature. Sweeps environment-resident capabilities first, evaluates fit, license, security, and effort, and recommends with evidence and trade-offs.
---

# capability-scout

Discover what already exists before you build it. The best implementation path
is often not code you write — it is a skill, tool, library, service, or
technique that is already installed, available, or one integration away.

The failure this skill prevents: **premature construction** — the agent writing
a parser, scheduler, scraper, or auth flow from scratch while a maintained,
tested solution sits unused in the same environment.

## Crazy Thing: Unknown-Unknown Search

Capability discovery is not limited to libraries. Before any external search,
the agent runs a fixed category sweep that starts with places agents almost
never check — the current environment's installed skills, tools, and commands,
and the project's own forgotten capabilities. The best answer is often already
present but invisible.

- **Mechanism:** mandatory environment-first category sweep (Step 2) before
  external sources; "already present but forgotten" is a first-class category.
- **Expected advantage:** fewer build-from-scratch misses and fewer invented-tool
  hallucinations, because the sweep makes present-but-invisible capabilities
  visible first.
- **Status: hypothesized** — validated structurally and by behavioral walkthrough
  (see `tests/behavioral/capability-scout.md`); no comparative evaluation yet.

## When it fires

**Explicit triggers** — the user asks for discovery:

- "Is there a tool / library / service for X?"
- "Find existing solutions before we build."
- "What are my options for Y?" / "Research how to do Z."

**Self-trigger** — the agent fires it on its own when ALL of these hold:

1. The goal is clear enough to decompose into capability requirements.
2. No reliable implementation path is currently known.
3. Building from scratch looks premature (the "I'm about to write a parser from
   scratch" signal is the canonical tell).

**Negative triggers** — do NOT fire when:

- The user already chose the implementation ("implement it with Postgres" —
  implement, don't research).
- The task is "write the code" with a decided stack.
- The question is purely algorithmic with no integration need.
- A previous scout in this session already covered the same goal — reuse it.

## Procedure

### Step 1 — Decompose into capability requirements

Translate the goal into a short requirements list. Done when each requirement
is testable against a candidate ("supports OAuth2 client-credentials" not
"handles auth somehow").

- **Function:** what must the capability do (verb + object per sub-goal).
- **Inputs/outputs:** data formats, protocols, languages, runtimes.
- **Constraints:** latency, scale, offline needs, platforms, existing stack.
- **Budget:** money (pricing model tolerated?), time (integration effort cap).
- **Hard filters:** license policy, security posture, data-residency, vendor
  risk. A candidate that violates a hard filter is rejected, not ranked low.

### Step 2 — Sweep the capability categories

Run in order, environment first. Each category gets a real check, not a guess
from memory. Done when every category was either checked or explicitly skipped
with a reason ("no network access — external categories skipped").

1. **This agent's skills and tools** — installed skills, available tool
   namespaces, connected MCP servers, CLIs on the machine. Read their actual
   descriptions and docs; never assume a tool exists because its name sounds
   right.
2. **This project's forgotten capabilities** — existing scripts, workflows,
   commands, packages, docs, and configs in the current repo or workspace.
   Grep the repo; check the docs directory; ask what teammates already built.
3. **Language-ecosystem libraries** — package indexes for the project's
   languages; prefer official registries and source-visible packages.
4. **Frameworks, repos, examples** — templates, boilerplates, example projects
   that demonstrate the pattern, not just the function.
5. **External APIs, SDKs, SaaS** — hosted services and their client libraries.
6. **Standalone tools and CLIs** — system utilities, developer tools, shell
   programs that compose via pipes or files.
7. **Algorithms, techniques, architectural patterns** — sometimes the answer is
   not software but a method (a known algorithm, a queueing pattern, a
   proven architecture) applied to code the agent writes.

Search proportionately: spend effort on the categories most likely to yield, and
prefer authoritative documentation and inspectable source over blog summaries.

### Step 3 — Evaluate candidates

Score every serious candidate on the same rubric. Done when each field has an
answer or an explicit "unknown — would need X to verify".

| Field | What to record |
|---|---|
| Fit | Which requirements it meets; which it misses. Quote the doc, not your memory. |
| Compatibility | Language, runtime, version constraints, conflicts with the current stack. |
| Maintenance | Last release date, issue activity, bus factor, deprecation signals. |
| License | Exact license; check against the project's license policy. |
| Pricing | Free tier limits, paid tiers, per-use costs; is there a usage cap that bites? |
| Limits | Rate limits, quotas, data caps, platform restrictions. |
| Security | Auth model, secrets handling, known CVEs, data leaves your infra? |
| Integration effort | Rough hours or steps to wire in; dependencies it drags along. |
| Uncertainty | What you could not verify, and what would verify it. |

Combinations are first-class: two weak-alone candidates that fit together
(count as one option) beat one strong-alone candidate only if the combined
effort and failure surface stay smaller.

### Step 4 — Documented vs. tested

Label every capability claim with its evidence level:

- **DOCUMENTED** — the official docs or source say it works this way.
- **TESTED** — you ran it in this environment and observed the behavior.

A DOCUMENTED claim is not a TESTED claim. When a recommendation hinges on a
claim that decides the fit, say so: "meets R2 per docs; not yet tested here."

### Step 5 — Proof of concept (where safe and useful)

Run a small PoC when the cost is low and the uncertainty is high — a minimal
call, a version check, a 10-line integration smoke test. Prefer read-only
probes: version flags, dry runs, public endpoints. The PoC's job is to convert
one DOCUMENTED claim to TESTED, not to build the integration.

### Step 6 — Recommend with a report

Deliver the recommendation in this shape:

1. **Recommendation** — use X, combine X+Y, or build from scratch. One sentence.
2. **Top candidates** — the rubric table for the 2–4 serious options, evidence
   levels attached.
3. **Trade-offs** — what each option costs: money, effort, lock-in, risk.
4. **Integration plan** — the concrete first steps to adopt the recommendation.
5. **Honest uncertainty** — what could not be verified and what would change
   the recommendation.

If no candidate clears the hard filters or the fit bar, say so plainly and
recommend building — with the requirements decomposition as the build brief.
Never invent a tool, service, or integration to fill the gap.

### Step 7 — Stopping rule

STOP the search when any of these holds:

- A candidate meets all hard filters and all must-have requirements with
  documented evidence → recommend it.
- Two consecutive search rounds in new sources add no new serious candidates
  → recommend the best found or recommend building.
- The search effort is approaching the cost of just building it → stop,
  recommend building, and say so explicitly.

Discovery serves the decision; it is not the work itself.

## Safety boundaries

- Never invent available tools or pretend the agent has integrations it does
  not. If the environment's tool list is unknown, check it first — names are
  not capabilities.
- Never install software, connect accounts, purchase services, run untrusted
  code, or modify a project without the user's authorization. PoCs stay
  read-only and reversible.
- If a recurring discovery procedure deserves to become a reusable skill,
  RECOMMEND it to the user. Do not auto-create skills.

## Failure handling

- **No network / no package access:** sweep categories 1–2 only, and mark
  external categories as unverifiable, not absent.
- **Ambiguous goal:** decompose what is clear, list the blocking ambiguity,
  ask one focused question — do not sweep blindly.
- **Conflicting evidence:** prefer newer official docs over older third-party
  posts; label the conflict and the tie-breaker.
- **Everything fits / nothing fits:** recheck the hard filters — either the
  requirements are too loose (split the goal) or too tight (relax or build).

## Portability

No proprietary APIs or model-specific behavior assumed. "Installed skills and
tools" means whatever the hosting agent exposes — check what is actually
available in each deployment. Works for any agent with read access to its
environment and, optionally, the web.
