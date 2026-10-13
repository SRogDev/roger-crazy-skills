# Behavioral self-test: design-thief v1

Date: 2026-10-13. Method: walk the skill's own Visual Delta Loop (Steps 1–7)
through a positive, a negative, and two edge cases, scoring every check against a
rubric. Verdicts come from the walkthrough, not from intent.

## Case 1 — Positive: mockup + broken implementation

Setup: user says "match this design" and attaches a landing-page mockup. The
implementation's hero is stacked vertically; the mockup is two-column (text left,
visual right). Three more gaps: headline type scale, card-grid spacing, button radius.

Walkthrough (actually stepped through while writing):

- **Fire check:** visual goal ("match this design") ✓; reference exists (mockup) ✓.
  Skill fires. PASS
- **Step 1:** references = the mockup (authoritative); "matching" = fidelity to the
  mockup; compare at 1440px and 390px, default state; conventions = the project's
  token/component set. One-sentence "matching" statable. PASS
- **Step 2:** screenshot tooling assumed available → baseline captured at 1440px
  under the same conditions as the mockup. PASS
- **Step 3 — delta list (all seven axes examined):**
  - D1: hero stacked vertically vs. two-column reference — composition/hierarchy.
  - D2: headline 28px system font vs. 48px display serif — typography.
  - D3: card-grid gap 8px vs. 24px — spacing.
  - D4: button radius 4px vs. pill — cosmetic detail.
  - Axes responsiveness / component behavior / design intent examined, no deltas.
  PASS (list written, no axis skipped silently)
- **Step 4 — ranking (impact × relevance, 1–3 each):**
  - D1: 3 × 3 = **9** (structural, core of the requested design)
  - D2: 2 × 3 = **6**
  - D3: 2 × 2 = **4**
  - D4: 1 × 2 = **2**
  - Order: D1 > D2 > D3 > D4. The structural gap (hero layout) outranks the
    cosmetic one (button radius) 9 to 2, as the hard rule requires. PASS
- **Step 5:** smallest fix for D1 only (two-column hero via the project's grid
  components; no token bypass, no trendy substitution). Build stays green. PASS
- **Step 6:** re-captured under Step-2 conditions; hero delta visibly shrank;
  spot-check of the other axes shows no new delta. Recorded as render-verified. PASS
- **Step 7:** loop continues — iteration 1 of the declared 5-iteration budget. PASS

## Case 2 — Negative: "make it prettier", no reference

Setup: user says "make this dashboard prettier." No image, no mockup, no direction.

Walkthrough:

- **Fire check:** "prettier" is not a matchable visual goal; no reference exists.
  Two negative triggers hit ("make it prettier" with no reference or direction).
  Skill must NOT fire the loop. PASS
- **Correct response:** decline the Visual Delta Loop and ask for a reference or a
  concrete direction — e.g. "Share a mockup or screenshot to match, or tell me
  what 'prettier' means here (denser? more whitespace? a reference site?)."
- **Failure mode checked:** the agent invents a trendy aesthetic (glassmorphism
  dashboard, dark mode nobody asked for) and starts "fixing" things. The skill's
  prohibited-actions section exists precisely to block this. Verdict: no invented
  aesthetic, no loop started. PASS

## Case 3 — Edge: no screenshot / browser tooling

Setup: user says "close the visual gap with the reference" + attaches a mockup,
but the agent runs in a text-only environment with no screenshot or browser tools.

Walkthrough:

- **Fire check:** visual goal ✓, reference ✓ → skill fires, degraded mode. PASS
- **Step 2:** declares up front: "no capture tooling; static review only."
  No comparable render pair exists. PASS (declared, not hidden)
- **Steps 3–4:** deltas listed and ranked from code inspection (same 9/6/4/2
  arithmetic as Case 1 is reproducible statically). PASS
- **Step 5–6:** fix applied to code; verification recorded as **static review**.
  The agent states explicitly: "cannot verify rendered fidelity without a
  screenshot." It does NOT claim the render improved. PASS — claims bounded to
  the verification level.
- **Step 7:** loop stops or continues as static review; a "no-improvement" claim
  can never be render-verified here, so the report must say so. PASS

## Case 3b — Edge: reference contradicts the user's stated aesthetic

Setup: user says "match this layout, but keep my minimalist monochrome brand"
and attaches a neon-gradient reference.

Walkthrough:

- **Step 1:** contradiction detected between reference (neon) and stated aesthetic
  (minimalist monochrome). The skill's input rule fires: decompose — borrow
  layout/hierarchy/spacing, keep brand color tokens — and confirm the split with
  the user before looping. It does NOT copy the reference's neon palette wholesale
  (that would be the prohibited "generic trendy substitution" in reverse: a
  *specific* wrong substitution). PASS — asked and decomposed instead of
  substituting.

## Attack — hierarchy vs. polish

Adversarial check required by the house methodology: the skill must prioritize a
meaningful discrepancy over random polish.

Scenario: D1 (broken hero hierarchy, score 9) vs. D4 (slightly-off border radius,
score 2) from Case 1. A gimmick version of this skill would fix D4 first because
it is the cheapest one-line change. The Visual Delta Loop's Step-4 hard rule
(structural > cosmetic; sort by impact × relevance, ties to the smaller fix)
forces D1 first — the tie-break toward smaller fixes only applies *within* equal
scores, so it cannot promote D4. Walked: order is D1 > D2 > D3 > D4. PASS.

Falsification probe: if a future run fixed D4 before D1, or shipped cosmetic
polish while D1 stayed open, that run would falsify the mechanism per the Crazy
Thing Card — the loop would be decorative, and the card says so explicitly.

## Verdict

All acceptance checks pass for v1: positive case fires and converges through a
ranked, verified cycle; negative case declines instead of inventing an aesthetic;
edge cases bound their claims (static review) and resolve contradictions by asking.
The ranking attack confirms structural gaps outrank cosmetic polish.

Limitations (honesty ledger): the walkthroughs are worked exercises on toy cases —
the mechanism is **behaviorally tested** at that level. Whether each iteration
measurably improves fidelity on real projects remains **hypothesized**, and no
comparison against the same agent working without the skill has been run.
