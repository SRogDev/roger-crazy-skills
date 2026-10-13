---
name: cost-guard
description: "Cost-guard: audit and cut unjustified cost in AI-agent workflows and other cost-generating processes by tracing cost amplification mechanisms (retry storms, polling loops, fan-out, context reloading, delegation chains) instead of itemizing line by line. Use when asked why is this so expensive, reduce the cost of this workflow, audit my API spend, this agent loop is burning tokens, or find cost waste. Estimates impact with explicit assumptions, labels measured vs estimated values, never invents prices, and proposes mitigations with stated trade-offs that never silently degrade quality, safety, or success rate. Does not fire on budgeting/finance questions with no cost-generating process, make it faster with no cost concern, or vendor pricing comparisons with no usage data."
---

# cost-guard

Find the real cost drivers in a cost-generating process and recommend
proportionate mitigations — with honest numbers and stated trade-offs.

## Crazy Thing: Cost Amplification Traps

Do **not** itemize costs line by line. Small costs become big bills through
**amplification mechanisms** — multiplicative structures that turn one cheap
operation into thousands. Trace the mechanism, estimate its total impact,
rank drivers by impact (Pareto: the top 1–2 drivers get the attention), and
estimate with explicit assumptions. Always distinguish **measured** values
(from logs, billing, benchmarks) from **estimated** ones (from assumptions
and arithmetic).

- **Mechanism:** trace amplification (retries, polling, fan-out, context
  reloads, delegation chains) → rank by estimated total impact → propose
  mitigations with stated trade-offs.
- **Expected advantage:** surfaces the few drivers that actually move the bill,
  and blocks the common failure of optimizing the visible cheap metric (token
  count) while total cost or success rate degrades.
- **Status:** behaviorally tested (see `tests/behavioral/cost-guard.md`).
  Comparative advantage over baseline agents remains a hypothesis.

## Activation

**Fire** when the request involves a cost-generating process and one of:

- "why is this so expensive" / "why is the bill so high"
- "reduce the cost of this workflow" / "cut my API spend"
- "audit my API spend" / "find cost waste"
- "this agent loop is burning tokens"
- a proposed change whose total-cost effect is uncertain

**Do not fire** when:

- budgeting or finance questions with **no cost-generating process** involved
- "make it faster" with **no cost concern** (that is a latency task)
- vendor pricing comparisons with **no usage data** (no usage → no cost;
  decline or ask for usage first)

## Inputs

1. A description of the cost-generating process: what runs, how often, what
   each run does, what it calls.
2. Any measurements available: token counts, API call counts, durations,
   billing dashboard figures, run logs.
3. The cost model if known (prices, plan, rate limits). If unknown, that is
   fine — use ranges or the word "unknown", never invented exact prices.

## Procedure

Follow these steps in order. Each step has a completion criterion.

### 1. Scope check

Confirm the request involves a **cost-generating process** whose cost model is
**known or estimable**. If there is no process and no usage data (e.g. "compare
these two SaaS pricing pages"), do not guess at costs: decline the cost audit
and ask for the usage data that would make it estimable.

Done when: you can state the process under audit in one sentence, or you have
declined/asked for usage.

### 2. Build the assumptions table

List every number the analysis depends on, in this format:

| # | Assumption | Value | Basis |
|---|---|---|---|
| 1 | … | … | **measured** (source) / **estimated** (basis) |

Basis is one of: **measured** (cite the source: billing export, logs, a
benchmark you ran) or **estimated** (state the basis: an assumption, a vendor
price range, an analogy). Unlabeled numbers are forbidden. A number whose basis
you cannot state is **unknown** — write "unknown", not a guess.

Done when: every number in the analysis has a measured/estimated/unknown label.

### 3. Hunt amplification traps

Walk the trap catalog below. For each candidate, apply its **detection
heuristic** against the measurements. A trap that fires is a cost driver; note
its estimated total impact (share of the total, or absolute range).

Done when: every catalog trap has been considered and marked as
present/absent with evidence.

### 4. Rank drivers by estimated impact

Order the confirmed drivers by estimated total impact, largest first. Attack
the top 1–2; treat the rest as secondary. A Pareto finding ("driver A is ~80%
of estimated cost") is itself a result.

Done when: you have a ranked driver list with estimated impacts.

### 5. Propose mitigations

For each driver worth acting on, emit a mitigation report (format below).
Mitigations must be **proportionate** to the driver's impact — do not spend
more engineering than the driver costs.

Done when: every significant driver has a report entry with trade-off and
verification.

### 6. Guard the quality/safety trade-off

Never recommend a change that silently degrades quality, safety, or success
rate. If a mitigation changes behavior, state the trade-off explicitly
(quality, latency, reliability, safety) so the human can judge it.

### 7. Guard against token-count-only optimization

Never optimize token count alone when it raises **total execution cost** or
lowers the **success rate**. The metric that matters is cost per successful
outcome:

```
cost per success = total execution cost / success rate
```

If a proposal uses cheaper tokens but needs more calls, or fails more often,
compute both sides with explicit assumptions. Reject proposals that raise
cost per success, and show the arithmetic.

Done when: every proposed saving is checked against total execution cost and
success rate, not token count alone.

## Amplification-trap catalog

Each trap: detection heuristic → typical mitigation. Verify the heuristic
against measurements before claiming the trap.

1. **Retry storms.** Heuristic: attempt count per logical operation ≫ 1, or
   retries triggered by a deterministic (non-transient) error. → Mitigate:
   bounded retries with exponential backoff and a retry budget; classify
   errors as transient vs permanent and never retry permanent ones; cache
   failure signatures so repeated identical calls fail fast.

2. **Polling loops.** Heuristic: fixed-interval checks whose hit rate (a check
   that finds work) is low, e.g. < 10%. → Mitigate: increase interval
   proportionally to idleness, add backoff on empty polls, or replace polling
   with an event trigger where available.

3. **Fan-out / fan-in.** Heuristic: one request spawns N parallel sub-requests
   and most contribute little (low marginal information, duplicated results).
   → Mitigate: cap fan-out, deduplicate overlapping sub-requests, aggregate
   results once instead of re-deriving them per branch.

4. **Context reloading.** Heuristic: the same large context (documents,
   conversation history, retrieved chunks) is re-sent on every call in a loop.
   → Mitigate: load once and reference it (caching, session reuse), summarize
   or truncate history, pass references instead of full content.

5. **Recursive delegation chains.** Heuristic: agent A calls agent B calls agent
   C, with each hop re-planning and re-loading context for the same task.
   → Mitigate: flatten the chain, pass the original task context down once,
   set a maximum delegation depth.

6. **Wasteful parallelism.** Heuristic: redundant parallel agents or workers
   racing on the same task, or parallel branches whose outputs are merged but
   largely identical. → Mitigate: one owner per task, or merge-and-dedupe
   before spawning branches.

7. **Unnecessary tool calls.** Heuristic: tool calls whose result is unused,
   repeated calls with identical inputs, or checks that never change the
   decision. → Mitigate: memoize by input, skip checks whose outcome cannot
   alter the next action, batch independent calls.

## Estimation discipline

- Exact figures only from measured billing, vendor-published prices (cite the
  source), or benchmarks you ran.
- When prices are unknown: give **ranges**, write **unknown** where nothing is
  known, and always show the arithmetic so the human can substitute real
  numbers later.
- Never claim savings without supporting evidence: a mitigation's impact is
  estimated until it is measured after deployment.

## Mitigation report format

One entry per driver:

```
Driver: <which trap / inefficiency>
Estimated impact: <share of total cost, or absolute range> — <measured|estimated>
Mitigation: <concrete change>
Trade-off: <what this costs in quality, latency, reliability, or safety — or "none identified">
Verification: <what to measure after deployment to confirm the saving>
```

## Failure handling and edge cases

- **Unknown cost model:** proceed with ranges labeled estimated; mark unknowns;
  include a measurement plan (which logs or billing exports would turn the
  estimates into measurements).
- **No measurements at all:** rank qualitatively, label the ranking
  qualitative, and propose the smallest measurement that would settle it.
- **Proposed change is a latency fix:** it belongs to a different task — say
  so and stop, unless cost is also a stated concern.
- **Conflicting goals (cost vs quality/safety):** surface the conflict with
  numbers on both sides; do not resolve it silently.

## Stopping conditions

Done when: the process is scoped, every number is labeled measured/estimated/
unknown, traps are marked present/absent with evidence, drivers are ranked,
mitigations carry trade-offs and verification steps, and no exact price or
saving is claimed without evidence.
