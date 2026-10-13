---
name: intention-verification
description: "Verify that an implementation or deliverable fulfills the user's original intent, not just that it looks complete. Use when asked to verify work against the original request, check an implementation against requirements, audit a PR against a spec or ticket, or confirm something actually did what was asked. Recovers the original requirements and constraints, maps each one to concrete implementation evidence (files, behaviors, test results), and flags omissions, quiet substitutions, contradictions, and unsupported \"done\" claims. Separates explicit requirements (the user said it) from inferred assumptions (the agent filled the gap). A passing test suite is never treated as proof of intent fulfillment. Do NOT use for running tests, writing new tests, debugging failing tests, or style-only code review when no original requirements exist."
---

# intention-verification

Verify whether a deliverable fulfills the user's ORIGINAL intent — not whether it
merely looks complete.

This is not a code review, not a test run, and not a quality pass. Code review
asks "is this code good?" This skill asks "is this what was asked for?"

## The Crazy Thing: Missing-Intent Detector

- **Mechanism:** Build a requirement-level Intent-Evidence Matrix from the user's
  own words *before* opening the implementation. Tag every requirement EXPLICIT
  (the user said it) or INFERRED (the agent filled the gap). Treat test results
  as evidence of behavior only — never as proof of intent coverage. Test every
  "done" claim against the matrix instead of accepting it.
- **Expected advantage:** Catches the failure mode where work looks complete
  (green tests, polished summary, named-but-hollow artifacts) while the original
  intent was dropped, quietly substituted, or superficially fulfilled — without
  needing a formal spec up front.
- **Status: behaviorally tested.** Walked through adversarial cases
  (`tests/behavioral/intention-verification.md`). Comparative advantage over
  unaided review is a hypothesis, not a claim.

## When to fire

Fire when the user asks you to check work against the original ask:

- "verify this implements what I asked"
- "check the work against the requirements"
- "audit this PR against the spec"
- "did this actually do what I wanted"
- "is this done, or did we drift"

**Do NOT fire for:**

- "run the tests" / "run the test suite" — executing tests is not intent
  verification.
- Green-field test writing ("write tests for this").
- Debugging a failing test.
- General code review or style feedback when no original requirements are
  available. If there is nothing to check against, decline: do not invent
  requirements.

## Inputs

You need exactly two things:

1. **The original intent** — the user's actual request. Preferred sources, in
   order: the user's own words (message, ticket, issue), then an approved
   spec or plan, then a PR description. Never reconstruct intent from the
   implementation itself.
2. **The deliverable** — the code, document, or output being checked.

**If the original intent is unavailable or unrecoverable, stop.** Report that
verification is impossible and name what would be needed (the ticket, the spec,
the user's message). Do not invent requirements just to have something to check.

## Procedure

### Phase 1 — Recover the intent

Read the original request in the user's own context. Extract a numbered list of
requirements and constraints, keeping each close to the user's wording. Do not
paraphrase away meaning.

Tag every requirement:

- **EXPLICIT** — the user actually said it or wrote it. Point at the source.
- **INFERRED** — the agent filled a gap: an unstated assumption, a chosen
  default, an interpretation of something ambiguous. Mark these plainly; they
  are guesses, not requirements, and the report must say so.

List **constraints** separately: things that must not happen, or limits ("don't
break X", "keep it under Y", "no new dependencies").

Completion criterion: every EXPLICIT requirement points at source text, and
every INFERRED one is labeled as a guess.

### Phase 2 — Build the Intent-Evidence Matrix

One row per requirement. Three columns: requirement (source-tagged), evidence,
verdict. Leave evidence empty for now; this matrix is the report skeleton.

### Phase 3 — Gather evidence, independently

For each requirement, find concrete evidence in the deliverable: files and line
ranges, observed behaviors (run it — don't trust comments), test results.

Evidence rules:

- **Test results are evidence of behavior, never proof of intent coverage.** A
  passing suite for feature A says nothing about requirement B. If no test
  exercises a requirement, say so explicitly: the requirement is *unverified by
  tests*, not covered by them.
- **Presence is not fulfillment.** A function named `dark_mode()` that sets one
  CSS class is evidence of presence; whether it delivers "dark mode" is a
  separate judgment.
- Prefer observed behavior over claims: run the thing, hit the endpoint, open
  the output.
- Absence of evidence is a finding, not a gap in your notes: "no code
  references X" goes in the matrix.

Completion criterion: every row has evidence, or the explicit note "no evidence
found".

### Phase 4 — Classify each requirement

- **Fulfilled** — evidence shows the requirement, as stated, is met.
- **Partial** — some of the requirement is met; the rest is missing or broken.
- **Omitted** — nothing was built for it; no evidence exists.
- **Substituted** — something else was built instead of what was asked, without
  the user's approval.
- **Contradicted** — the deliverable does the opposite, or violates a stated
  constraint.
- **Unverified** — plausibly done, but you could not confirm it (needs
  credentials, production data, a device you don't have). State exactly what
  would confirm it.

Classify substitutions and contradictions even when the alternative is arguably
better. Better-without-permission is still drift.

### Phase 5 — Challenge completion claims

Take every "done", "complete", "implemented", "fixed" claim the deliverable or
its author makes and test it against the matrix. A claim with no supporting
row-verdict is an **unsupported completion claim** — flag it. The matrix, not the
summary, decides what is done.

### Phase 6 — Report

Report findings ordered by severity. Every finding carries five fields:

- **Finding** — what was required vs. what exists.
- **Severity** — see taxonomy below.
- **Evidence** — the concrete proof (files, behaviors, outputs).
- **Uncertainty** — what you could not confirm and why.
- **Next action** — the concrete step that resolves it (who does what).

Lead with the worst findings. End with the matrix summary and an overall
verdict: **intent fulfilled / partially fulfilled / not fulfilled** — naming the
unmet requirements.

## Severity taxonomy

- **Blocker** — a core explicit requirement is omitted or contradicted, or a
  completion claim is unsupported. The deliverable cannot be accepted as-is.
- **Gap** — an explicit requirement is partial, or non-core detail is missing.
- **Drift** — a substitution or scope addition made without the user's approval,
  however well-intentioned.
- **Unverified** — could not be confirmed with available evidence; needs a
  specific check.
- **Note** — an inferred assumption worth surfacing, or a minor observation.
  Never the lead finding.

## Steering

- **Read the request before the implementation.** Opening the deliverable first
  lets its framing anchor you; the user's words are the baseline.
- **Treat every requirement as guilty until proven innocent.** Optimistic
  reading is the failure mode this skill exists to prevent.
- **Distinguish three different "not done"s:** omitted (never attempted),
  partial (attempted, incomplete), unverified (attempted, can't confirm). They
  need different next actions.
- **Superficial fulfillment is substitution, not partial credit.** One CSS
  class named `dark-mode` that changes nothing visible is evidence of absence
  wearing a name tag. Judge behavior, not identifiers.
- **Keep inferred requirements out of the verdict math.** If the only findings
  are on inferred items, the verdict is "intent fulfilled (with N assumptions
  worth confirming)" — not a failure.
- **Do not fix.** This skill verifies and reports. Fixing is a separate task
  the user may request after seeing the report.

## Stopping conditions

Stop and report when: the matrix is complete with a verdict per requirement; or
the original intent is unrecoverable (decline, don't invent); or evidence
gathering is blocked on something only the user can provide (report as
unverified, with the next action).

## Common traps

- **Green tests lulling you.** Run the procedure anyway; tests assert their own
  behavior, not your requirements.
- **Reviewing quality instead of intent.** Style, elegance, architecture are out
  of scope unless the user asked for them.
- **Accepting the author's summary.** Phase 5 exists because summaries lie by
  omission.
- **Inventing intent to fill silence.** A vague request gets labeled inferred
  assumptions, not asserted requirements.

## Mini example

Request: "Add a logout button that clears the session and returns to the login
page."

Recovered: (1, EXPLICIT) a logout button exists; (2, EXPLICIT) clicking it
clears the session; (3, EXPLICIT) the user lands on the login page afterward.

Evidence: button rendered (component file); clicking clears the session cookie
(observed); the app lands on the home page, not the login page (observed).

Verdicts: 1 Fulfilled, 2 Fulfilled, 3 Partial (wrong destination). Finding:
severity gap — next action: route to `/login` after the session clear.
