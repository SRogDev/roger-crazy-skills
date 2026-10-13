# Behavioral self-test: cost-guard v1

Date: 2026-10-13. Method: follow the skill's own procedure (steps 1–7) on a
positive case, a negative case, two edge cases, plus the attack-step scenarios
(polling, wasteful parallelism) required by the house methodology. Verdict per
acceptance criterion. All prices below are ranges labeled **estimated** — no
exact prices are invented anywhere in this file.

## Case 1 — Positive: retry storm with context reloading

Scenario: a customer-support agent loop. Each incident calls an internal ticket
API that fails deterministically (misconfigured credentials → HTTP 401 every
time). The agent has no retry budget and retries **50 times** per incident.
Each attempt reloads a **20k-token context** (conversation history + retrieved
docs); output per attempt ≈ 0.5k tokens. Logs show **10 such incidents/day**
(all measured). Model prices are unknown.

Walkthrough:

- **Step 1 (scope):** process = "support agent loop retrying a deterministically
  failing API call, 50× per incident, full context reload per attempt."
  Estimable: yes (tokens × attempts × price ranges). PASS
- **Step 2 (assumptions table):**

| # | Assumption | Value | Basis |
|---|---|---|---|
| 1 | Attempts per incident | 50 | **measured** (run logs) |
| 2 | Input tokens per attempt | 20,000 | **measured** (run logs) |
| 3 | Output tokens per attempt | ~500 | **measured** (run logs) |
| 4 | Input price | $0.50–$3.00 / 1M tokens | **estimated** (frontier-model range) |
| 5 | Output price | $2.00–$15.00 / 1M tokens | **estimated** (frontier-model range) |
| 6 | Incidents per day | 10 | **measured** (run logs) |

PASS — every number labeled; prices are ranges, never exact.
- **Step 3 (trap hunt):** trap 1 retry storm — **present** (50 attempts for a
  deterministic 401, a permanent error being retried); trap 4 context
  reloading — **present** (20k tokens re-sent × 50); traps 2, 3, 5, 6, 7 —
  absent (no polling, no fan-out, no delegation chain, single agent, no
  redundant tool calls). PASS
- **Step 4 (rank):** per incident: input = 50 × 20k = 1M tokens →
  $0.50–$3.00; output = 25k tokens → $0.05–$0.375. Total **$0.55–$3.38 per
  incident**; 10/day → **$5.50–$33.75/day**. One attempt alone would cost
  $0.01–$0.06 input. Retry × context-reload compounds to ~50× amplification
  and ~98% of estimated incident cost. Ranked #1. PASS — retry amplification
  identified as the top driver, arithmetic shown.
- **Step 5 (mitigations):**
  - Driver: retry storm. Mitigation: bounded retries (max 3, exponential
    backoff) + classify 401 as permanent (never retried). Estimated impact:
    ~94% reduction on these incidents (47 of 50 attempts eliminated).
    Trade-off: slower recovery if a 401 is ever transient (rare; backoff
    preserves some recovery). Verification: attempt counts per incident from
    logs over the next week.
  - Driver: context reloading. Mitigation: on first failure, cache the error
    signature and reuse the loaded context instead of reloading per attempt.
    Trade-off: none identified (minor code complexity). Verification: token
    totals per incident.
  
  PASS — mitigations are bounded retries + error caching, each with trade-off
  and verification, proportionate to the driver.
- **Steps 6–7 (guards):** no quality/safety degradation — every retried call
  failed anyway, so success rate is unchanged; the guard against token-only
  optimization is satisfied (total cost drops because attempts drop).
  PASS

**Verdict: PASS.** The skill identifies retry amplification as the top driver
and proposes bounded retries + error caching with explicit trade-offs.

## Case 2 — Negative: no cost-generating process

Request: "compare these two SaaS pricing pages."

Walkthrough:

- **Step 1 (scope):** no cost-generating process described, no usage data
  (requests/month, seats, tokens). The cost model is not estimable — any
  "cheaper" verdict would require invented usage.
- Per the procedure, the skill must decline the cost audit and ask for the
  usage data that would make it estimable (seats, API volume, expected
  traffic). It may offer a feature-level comparison, but must not present it
  as a cost conclusion.

Acceptance rubric: (a) does not invent usage numbers; (b) does not declare a
winner on cost; (c) asks for usage data or declines. **Verdict: PASS.**

## Case 3 — Edge A: prices unknown (never-invent-prices rule)

Scenario: same shape as Case 1, but the model vendor and all prices are
unknown, and no billing export exists.

Walkthrough: steps 1–2 produce an assumptions table where price rows read
"unknown — range $0.50–$3.00/1M input (frontier-model estimate)" and the
impact is computed symbolically:

```
cost per incident ≈ 50 attempts × (20k in + 0.5k out) × price
                 ≈ 1M input tokens × price_in  +  25k output tokens × price_out
```

The report states the amplification factor (50×) and the per-incident token
totals as **measured**, and the dollar impact as a **range estimate**, with an
explicit note: "exact prices unknown; substitute your real rates here."
A measurement plan is included: one billing export turns the range into a
measurement.

Acceptance rubric: (a) no exact price appears; (b) every dollar figure is a
range labeled estimated or the word "unknown"; (c) the arithmetic is shown so
real numbers can be substituted. **Verdict: PASS.**

## Case 4 — Edge B: token-count-only "optimization" must be rejected

Proposal: switch the workflow to a model with 3× cheaper tokens. The catch:
the cheaper model needs 3× more calls per task and its success rate is 60%
vs 80% on the current model.

Walkthrough (skill step 7): compute cost per successful outcome with explicit
assumptions (task = 10k tokens per call, current price = p per token):

- Baseline: 1 call × 10k × p = 10k·p; cost/success = 10k·p / 0.8 = **12.5k·p**
- Proposal: 3 calls × 10k × p/3 = 10k·p (same raw spend);
  cost/success = 10k·p / 0.6 = **16.7k·p** — ~33% **more** per successful task,
  plus extra latency and rework.

The skill must reject the proposal and show this arithmetic, recommending
instead that any model switch be judged on cost per successful outcome.

Acceptance rubric: (a) rejects the "saving"; (b) shows both sides of the
arithmetic; (c) cites cost-per-success, not token count. **Verdict: PASS.**

## Attack step — additional trap scenarios (required by methodology)

### Attack P — excessive polling

Scenario: a monitor agent polls a queue API every 10 seconds for new events;
hit rate (poll that finds work) is 2%, measured. Each poll costs one cheap
API call plus ~200 input tokens.

Walkthrough: step 3 — trap 2 polling loops **present** (98% of polls idle);
step 4 — ~8,640 polls/day, ~8,470 wasted; step 5 — mitigation: backoff on
empty polls (10s → up to 5 min) or an event trigger/webhook; trade-off: up to
5 min added latency on new events (state explicitly); verification: poll
count and idle-hit rate after one week. The skill does NOT recommend
"shorten the response tokens" — that would optimize trivia while the polling
mechanism keeps burning. **Verdict: PASS.**

### Attack W — wasteful parallelism

Scenario: 5 parallel agents race to answer the same user query; a merger
picks the best of 5 outputs, discarding the other 4.

Walkthrough: step 3 — trap 6 wasteful parallelism **present** (4 of 5 runs
discarded; outputs largely overlapping); step 4 — ~5× the cost of one agent
for marginal quality gain; step 5 — mitigation: one owner agent per query,
or a single strong pass plus a cheap verifier instead of 5 full races;
trade-off: possible small drop in best-of-5 quality (state it; suggest
measuring answer-quality win-rate before/after); verification: total tokens
per query and quality spot-checks. The skill does NOT recommend adding more
agents "to go faster". **Verdict: PASS.**

## Falsification check

The Crazy Thing would have failed if any walkthrough had: ranked a trivia
driver above an amplification driver, accepted a token-only saving that raises
total cost, emitted an exact price without a source, or recommended a
quality/safety-degrading change without stating the trade-off. None occurred.

## Verdict

All acceptance checks pass for v1: positive case ranks retry amplification
#1 with bounded-retries + error-caching mitigations; negative case declines
without usage data; edge cases enforce ranges-over-invention and reject
token-count-only optimization; attack scenarios cover polling and wasteful
parallelism. Limitation: the comparative claim (amplification-tracing beats a
baseline agent's line-item audit) remains a **hypothesis** — no head-to-head
comparison was run, and the skill text must not claim otherwise.
