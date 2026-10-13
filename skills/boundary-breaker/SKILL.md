---
name: boundary-breaker
description: "Audit the trust boundaries of a system: red-team an integration or workflow, check permission assumptions, or ask \"what happens if this input is malicious\". Maps identities, data flows, permissions, and execution environments, names the trust boundaries between them, then inverts each boundary's trust assumption (\"what if this trusted thing is hostile, compromised, or wrong?\") to build scoped adversarial scenarios. Reports findings as CONFIRMED (demonstrated) vs PLAUSIBLE (reasoned) vs UNTESTED (hypothesis) — never presented as anything they are not. All analysis stays authorized, controlled, and proportionate: destructive testing, unauthorized access, and production probing are explicitly prohibited; ambiguous authorization means stop and ask. Triggers: audit trust boundaries, red-team integration, threat-model workflow, permission assumptions, malicious input. Not for: exploiting systems, bypassing auth or paywalls, unauthorized pentests, security news with no system to analyze."
---

# boundary-breaker

Audit the trust boundaries of a system by *inverting* its trust assumptions.
Instead of asking "is this secure?", ask, for every boundary: "what if the
trusted side is hostile, compromised, or simply wrong?" Then trace what
actually crosses the boundary.

## The Crazy Thing: Trust-Boundary Inversion (card)

- **Mechanism:** for every mapped trust boundary, explicitly invert the trust
  assumption — "what if this trusted thing is hostile, compromised, or simply
  wrong?" — trace what concretely crosses the boundary under that inversion,
  and force every finding into CONFIRMED / PLAUSIBLE / UNTESTED tiers, never
  merged.
- **Expected advantage:** surfaces assumption failures checklist reviews miss
  (the real boundary is CDN → app, not internet → app; intended-vs-actual
  permission gaps), while tier discipline stops speculation being presented as
  findings.
- **Validation test:** walked walkthroughs in `tests/behavioral/boundary-breaker.md`
  (repo-root-relative) — a trusted component receiving untrusted data, and an
  operation exceeding its intended permissions — with tiering verified against
  the actual evidence.
- **Falsification:** if the inversion walkthrough produces nothing beyond a
  generic checklist, or tiers get misapplied, the mechanism is unjustified —
  say so rather than shipping the gimmick.
- **Status:** behaviorally tested (builder-walked self-test). Comparison
  against an unaided review is untested — that advantage claim is a hypothesis.

## When to use

- "Audit the trust boundaries of this system"
- "Red-team this integration / workflow / API"
- "Check our permission assumptions"
- "What happens if this input is malicious?"
- Threat-modeling a feature, integration, or deployment

## When NOT to use

- Requests to actually exploit, hack, or penetrate a system
- Unauthorized testing of any kind ("just check if it's open", "try to get in")
- "Bypass this paywall / login / auth check"
- Security-news questions with no concrete system to analyze
- If a request above arrives: refuse the exploitative part, explain why, and
  offer the authorized alternative (e.g. audit the system's design from the
  owner's side, or test against a staging environment with written permission)

## Safety rules (non-negotiable)

This skill is an audit tool, never a license to attack. All work is
**authorized, controlled, and proportionate** — the owner's written permission
and a defined test scope are prerequisites for any active testing.

**Prohibited actions** — never do these, even "to prove a point":

- Accessing any system, account, or dataset you are not authorized to access
- Destructive testing: deleting or corrupting data, denial of service,
  disabling defenses, resource exhaustion
- Data exfiltration — demonstrate impact with synthetic/test data, never real
  user data
- Production probing of any kind without the system owner's explicit approval
- Circumventing authentication, authorization, rate limits, or payment controls
  — including proving a bypass works by performing it

**Default analysis mode:** inspect and reason. Read code, configs, and docs;
build findings as PLAUSIBLE or UNTESTED. Move to active testing (CONFIRMED
tier) only with explicit authorization AND an explicit scope (which systems,
which techniques, what time window, what is out of bounds).

**Stop-and-ask rule:** if authorization to test is unclear or ambiguous, STOP.
Do not assume consent. State what testing you would do, what scope it needs,
and ask the owner for explicit permission before proceeding.

## The method

Five phases. Each ends with a concrete artifact — you are done with a phase
only when that artifact exists.

### Phase 1 — Map the terrain

Inventory before judging. Produce a map with five layers:

1. **Identities** — every actor: users, services, jobs, third parties,
   AI agents, CI/CD pipelines. Include machine identities (API keys, service
   accounts, webhooks) — these are the most mis-trusted.
2. **Data flows** — what data crosses between which components, in both
   directions. Label sensitivity (public / internal / sensitive / regulated)
   and whether the data is *validated* at the crossing point.
3. **Permissions** — what each identity is *allowed* to do, per system.
   Record the *intended* permission ("read-only") separately from the
   *actual* permission (what the credential/API technically permits).
4. **Execution environments** — where code and data run: browsers, edge/CDN,
   serverless, containers, CI runners, developer machines, the model/agent
   runtime. Note who controls each environment.
5. **Trust boundaries** — the lines where one side must trust the other to
   behave: network edge, auth boundary, process boundary, org boundary
   (vendor/partner), human boundary (approval steps), and AI boundary
   (model output consumed as fact).

Artifact: a numbered list of boundaries, each with its two sides and what is
trusted across it.

### Phase 2 — Invert each boundary

This is the Crazy Thing: **Trust-Boundary Inversion**. For every boundary
from Phase 1, run this block:

```
Boundary: <name> — <side A> trusts <side B> for <what>
Assumption: <side B> is honest, competent, uncompromised
INVERTED:   <side B> is hostile / compromised / simply wrong
Crosses the boundary: <concrete data, actions, or effects that move across>
Impact if inverted:   <concrete, specific harm — not "bad things happen">
Would we notice?      <what detection, logging, or alerting exists>
Inversion variant 2:  <repeat for the other two adjectives — each finds
                       different failures: hostile finds malice, compromised
                       finds supply-chain, wrong finds bugs and drift>
```

Three worked patterns to calibrate on:

- *Trusted component receiving untrusted data:* a webhook handler trusts the
  `X-Forwarded-For` (or a CDN-set `X-Client-Region`) header. Invert: the CDN
  is compromised → the header is attacker-controlled → any authorization or
  geo-gating built on that header is bypassed. The boundary is not
  "internet → app"; it is "CDN → app", and the app treats CDN output as fact.
- *Operation exceeding intended permissions:* an API key documented as
  "read-only" is technically scoped to `write` as well. Invert the
  permission assumption: the key is leaked or the holder is malicious →
  writes happen the owner believed impossible. The boundary is the
  documentation ↔ reality gap.
- *AI output trusted as fact:* an agent's tool result is parsed as structured
  data without validation. Invert: the tool (or the model summarizing it) is
  wrong or prompt-injected → untrusted content flows into a trusted
  decision. The boundary is "model output → control flow".

A per-boundary-type inversion checklist lives in
[references/inversion-checklist.md](references/inversion-checklist.md) —
consult it so common boundaries are not missed.

### Phase 3 — Tier every finding

Three labels, never merged, never presented as each other:

- **CONFIRMED** — demonstrated with evidence: a test you ran (authorized),
  a code path you traced end-to-end, a log or config you read that proves the
  behavior. Quote the evidence.
- **PLAUSIBLE** — a reasoned attack path you did not demonstrate. Must
  include the concrete test that *would* confirm it (technique + expected
  signal), and name the authorization/scope that test needs.
- **UNTESTED** — a hypothesis: an inverted assumption with no evidence yet.
  State plainly what is unknown.

Tier rules:

- A finding starts at UNTESTED and is *upgraded* only with new evidence.
- Reasoning is never evidence. "Obviously" is not a tier.
- If the evidence is a vendor doc or a config file, the finding is PLAUSIBLE
  at best — docs describe intent (see Phase 1: intended vs actual).
- **Chain rule:** an attack path is only as strong as its weakest link. If a
  finding needs links A (CONFIRMED) + B (PLAUSIBLE) + C (UNTESTED) to all hold,
  the finding is UNTESTED — or split it into sub-findings, one tiered row per
  link, so each claim carries exactly the evidence it has.
- Every finding names its tier in its title line. A report with an untiered
  finding is unfinished.

### Phase 4 — Write scoped scenarios

For each PLAUSIBLE or high-impact UNTESTED finding, write a scoped scenario:

```markdown
## Scenario: <short name>
- **Inverted assumption:** ...
- **What crosses the boundary:** ...
- **Impact if true:** ...
- **Confirmation test:** <safe, authorized technique; expected signal;
  what it would prove>
- **Blast radius of the test:** <who/what is affected; must be ~zero for
  anything beyond inspection>
- **Authorization needed:** <who must approve; current status>
- **Current tier:** PLAUSIBLE | UNTESTED
```

Keep scenarios small and falsifiable — one boundary, one inversion each.
A scenario that cannot be confirmed or refuted by any safe test is a story,
not a finding; demote it to UNTESTED or drop it.

### Phase 5 — Report: mitigations + verification

Deliver a report in this format:

1. **Boundary map** — the Phase 1 inventory (condensed).
2. **Findings table** — one row per finding:

   | Finding | Tier | Evidence / why not higher | Impact | Mitigation | Verification |
   |---|---|---|---|---|---|

3. **Mitigations ordered by leverage** (fix in this order):
   - Move the trust: can the boundary be eliminated (verify instead of trust)?
   - Verify at the boundary: signatures, schema validation, allow-lists,
     re-authentication of cross-boundary data.
   - Narrow the permission: least privilege on the actual credential, not the
     documented one; short lifetimes; separate identities per purpose.
   - Detect: logging and alerting for the inverted case, so a compromise is
     visible.
4. **Verification** — for each fix, the concrete check that proves it works
   (test, query, config assertion). A mitigation without a verification step
   is a wish.
5. **Residual UNTESTED hypotheses** — listed openly as what the audit did not
   cover or could not confirm.

## Steering notes

- Work boundary-by-boundary; do not chase the scariest scenario first. The
  boring boundary (the internal service call, the documented-as-read-only key)
  is where assumptions rot.
- When the user gives you a system description, trust the *code and configs*
  over the *narrative*. "It's internal-only" is a claim; check the network
  policy. "Read-only" is a claim; check the actual scope.
- If you cannot see a side of a boundary (closed-source vendor, black-box
  SaaS), say so and tier accordingly — opacity is itself a finding, usually
  UNTESTED with a note on what evidence would change the tier.
- Keep the report proportional: a small integration gets a page, not a book.
  Cap scenarios at the highest-impact ~5 unless asked for exhaustive.
- A clean audit is a valid result. If no inversion produces a meaningful
  impact, say so plainly and list the boundaries checked — do not invent
  findings to fill the report.
