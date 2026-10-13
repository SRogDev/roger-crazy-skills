---
name: design-thief
description: Match a target visual design: reproduce or improve a UI from supplied references (screenshots, mockups, descriptions) using a budgeted inspect → fix → re-inspect Visual Delta Loop. Use when the task says "match this design", "reproduce this UI from the mockup", "improve this page to look like X", or "close the visual gap with the reference". Do not use for pure code refactors, design-system authoring from scratch, or "make it prettier" with no reference or direction.
---

# design-thief

Steal the *intent* of a target visual design — the layout logic, the hierarchy, the
decisions the reference makes — and close the gap between it and the implementation
in ranked, verified cycles. Never substitute a generic trendy design for the specified one.

## Crazy Thing Card

- **Mechanism:** VISUAL DELTA LOOP — inspect reference vs. implementation, list every
  visual discrepancy across seven axes, rank the deltas by expected visual impact ×
  relevance to the requested design, fix the smallest change addressing the top delta,
  re-inspect under identical conditions, and repeat within explicit iteration / time /
  tool budgets. A cycle that shows no improvement stops the loop, not a new fix.
- **Expected advantage:** convergence instead of drift: each change is justified by a
  ranked delta rather than a hunch, so the big structural gaps (layout, hierarchy)
  get fixed before anyone polishes border radii.
- **Validation test:** worked walkthroughs in the repo's behavioral test file
  (`tests/behavioral/design-thief.md`, repo-root-relative) — positive, negative,
  and edge cases — plus a ranking attack: broken layout hierarchy vs.
  slightly-off border radius — hierarchy must rank #1.
- **Falsification:** if ranked deltas are ignored and cosmetic polish ships first, or
  if cycles accumulate changes no re-inspection verifies, the mechanism is dead and
  this is a gimmick. Say so.
- **Status:** behaviorally tested (worked walkthroughs on toy cases — see the test
  file). Whether each iteration measurably improves fidelity on real projects is
  still **hypothesized**; comparison against a no-skill baseline is untested.

## Tool requirements

- Works best with image inspection plus screenshot / browser tooling to capture the
  implementation under the same conditions as the reference.
- Degrades gracefully to static code review when that tooling is missing — but then
  rendered-fidelity claims are off-limits (see "Honesty about verification").

## When this skill fires

Fire when ALL are true:

1. There is a visual goal: "match this design", "reproduce this UI from the mockup",
   "improve this page to look like X", "close the visual gap with the reference".
2. At least one reference exists: an image, screenshot, mockup, or a concrete written
   description of the target look.

Do NOT fire when:

- It is a pure code refactor with no visual goal.
- It is brand or design-system authoring from scratch with no reference to match.
- The request is "make it prettier" (or equivalent) with no reference and no
  direction — ask for a reference or a concrete direction instead of inventing an
  aesthetic. Inventing one is the failure mode this skill exists to prevent.

## Inputs and prerequisites

- **References:** the images / screenshots / mockups / descriptions to match. Attach
  or point at each one; note which is authoritative if several disagree.
- **Implementation:** the code or page to change, and how to view it (dev server URL,
  route, build command).
- **Conventions:** the project's design tokens, component library, spacing and type
  scales. Fixes reuse these; they are never bypassed for one-off styles.
- **Budgets:** declare up front — max loop iterations, max wall-clock time, max
  screenshot / tool calls. Defaults if the user says nothing: 5 iterations, the rest
  bounded by what the session can afford. Write the numbers down before starting.

Do not start the loop until you can state in one sentence what "matching" means here
(fidelity to the reference, improvement beyond it, or a named mix of both). If the
reference contradicts the user's stated aesthetic ("keep my brutalist brand, but use
their layout"), ask which parts to borrow and which to keep — decompose, don't guess.

## The Visual Delta Loop

### Step 1 — Ground the target

Record: (a) each reference artifact and which is authoritative; (b) the one-sentence
definition of "matching"; (c) the viewports and states to compare (e.g. 1440px and
390px, hover / empty / error states, real content where possible); (d) the project
conventions from above.

*Done when:* you can name the exact screens, states, and conventions you will hold
constant across every cycle.

### Step 2 — Baseline capture

Capture the implementation under the **same conditions** as the reference: same
viewport, same state, same content. Use screenshot / browser tooling when available.
When it is not, say so now — "no capture tooling; static review only" — and bound
every later claim accordingly (see Honesty).

*Done when:* you have a comparable reference-vs-current pair, or a declared,
bounded substitute for one.

### Step 3 — List the deltas

Enumerate visual discrepancies across **all seven axes** — hierarchy, spacing,
typography, composition, component behavior, responsiveness, design intent — not just
colors and pixels. One delta per line: *where* (screen/section), *what differs*,
*which axis*. Skip an axis only by naming it and why it does not apply.

*Done when:* every axis has been examined or explicitly excluded, and the list is
written down.

### Step 4 — Rank the deltas

Score each delta: **impact × relevance**, each 1–3.

- Impact: 1 = visible only side-by-side; 2 = noticeable at a glance; 3 = changes what
  the page *is* (layout, hierarchy, composition, behavior).
- Relevance: 1 = tangential to the request; 2 = part of the requested look;
  3 = the core of the requested design intent.

Sort by score, descending. Hard rules:

- Structural gaps (layout, hierarchy, composition, component behavior) outrank
  cosmetic ones (colors, border-radius, shadows, gradients) — unless the user's
  stated intent makes a cosmetic detail the point.
- Ties break toward the smaller fix.

*Done when:* you have an ordered list with a named #1 delta.

### Step 5 — Fix the top delta

Make the smallest change that addresses the top one or two deltas. Reuse the
project's tokens and components. Never substitute a generic trendy pattern for the
reference's choice. Keep the build green and the linters quiet.

*Done when:* the change is applied and the project still builds.

### Step 6 — Verify the cycle

Re-capture under the **same conditions as Step 2**. Confirm the targeted delta
shrank and spot-check the other axes for regressions. Record: delta fixed, how it
was verified, any new issues. If the delta did not shrink, revert or revise the
change — never accumulate unverified fixes.

*Done when:* the comparison shows a real improvement, or a documented
non-improvement that triggers Step 7's stop rule.

### Step 7 — Loop or stop

Repeat Steps 3–6 until one of these is true, then stop:

- The declared iteration, time, or tool-call budget is exhausted.
- A full cycle produces no improvement (Step 6 documents it).
- Fidelity is acceptable — confirmed by the user or by a clean delta list.
- Verification tooling is unavailable — downgrade to a bounded static review and
  say so plainly; do not keep "looping" on unverified claims.

## Honesty about verification

State the verification level in every report; never imply a stronger one:

- **Render-verified:** before/after captures taken under identical conditions.
- **Static review:** no screenshot / browser tooling. Claims are bounded to what
  code inspection can show. Say explicitly: "cannot verify rendered fidelity
  without a screenshot."
- **Reference gap:** the reference is description-only. Name which deltas cannot be
  judged from prose and do not invent precision the reference never gave.

## What this skill will not do

- It will not invent an aesthetic when none is supplied ("make it prettier" with no
  reference gets a question, not a redesign).
- It will not substitute a generic trendy design for the specified one.
- It will not claim pixel-level fidelity from a prose-only reference.
- It will not keep iterating past a no-improvement cycle or an exhausted budget.
- It will not bypass the project's design tokens, components, or conventions for
  one-off styles.

## Final report

When the loop ends, report:

1. Deltas fixed, each with how it was verified.
2. Residual deltas, ranked, with why they were left (budget, diminishing returns,
   needs user decision).
3. Verification level (render-verified / static review / reference gap).
4. Budgets declared vs. consumed.
5. Anything the loop could not verify — stated plainly.
