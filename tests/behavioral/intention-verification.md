# Behavioral self-test: intention-verification v1

Date: 2026-10-13. Method: walk the skill's own procedure (Phases 1–6) through
toy fixtures built for the purpose, then score each case against its rubric.
The two adversarial scenarios required by the house methodology are walked here
as Attack 1 and Attack 2; the positive/negative/edge cases derive from them.

## Attack 1 — Incomplete implementation with a misleading "done" claim

Original request (the user's own words):
"Add user login with email+password, rate limiting of 100 requests/min per IP,
and a /health endpoint for the load balancer."

Deliverable: `app.py` with a working `/login` route (email/password check), a
`/health` route returning an empty body with HTTP 200, and **no rate-limiting
code anywhere** (verified by grep). Test suite: 3 tests, all passing (they only
assert the routes exist). Author's claim: "All done: login, rate limiting,
health check."

Walkthrough of the skill's procedure:
- Phase 1 recovers 3 EXPLICIT requirements: (1) email+password login,
  (2) rate limit 100 req/min per IP, (3) /health for the load balancer. No
  inferred items needed — the request is concrete.
- Phase 3 evidence: req 1 — `/login` route with credential check in `app.py`;
  req 2 — grep finds zero rate-limit code: "no evidence found"; req 3 —
  `/health` returns HTTP 200 with empty body. On req 3 the procedure forces a
  judgment against behavior: a 200 satisfies what a load balancer checks, so
  the empty body is not a failure — recorded as fulfilled with a note.
- Phase 4 verdicts: (1) Fulfilled, (2) Omitted, (3) Fulfilled. The green test
  suite is explicitly recorded as covering none of the requirements beyond
  route existence — it cannot rescue req 2.
- Phase 5: the author's "rate limiting: done" claim has no supporting
  row-verdict → **unsupported completion claim**, severity **blocker**.
- Phase 6 overall verdict: partially fulfilled; one core explicit requirement
  omitted; deliverable cannot be accepted as-is.

Result: the skill flags the omitted requirement AND the misleading "done"
claim as separate findings, with file-level evidence. A generic review might
note "no rate limiting"; the procedure additionally kills the false summary.

## Attack 2 — Superficial implementation ("dark mode" as one CSS class)

Original request: "Add dark mode to the app."

Deliverable: `style.css` containing a single rule
(`.dark-mode { background: #111; }`) applied to `<body>`; the heading keeps
`color: black` inline, body text is unstyled, there is no toggle control and no
persistence.

Walkthrough:
- Phase 1 recovers 1 EXPLICIT requirement: the app has dark mode. "Dark mode"
  is vague, so the procedure requires labeling guesses: INFERRED assumptions
  (a toggle exists, the UI actually renders dark, the preference persists) are
  marked as guesses, not requirements.
- Phase 3 evidence: the class exists (presence), but the rendered behavior is a
  dark background with default/black text and no way to switch — judged on
  behavior, not identifiers.
- Phase 4 verdict: **Substituted** — per the steering rule, a named-but-hollow
  token is evidence of absence wearing a name tag, not partial credit.
  Severity **blocker** (the single core requirement is not meaningfully met).
  The inferred toggle/persistence items become Notes, kept out of the verdict
  math — the report does not assert a toggle was required.
- Phase 6 overall verdict: not fulfilled.

Result: the skill distinguishes "the class exists" (presence) from "dark mode
works" (behavior), refuses partial credit for a token artifact, and avoids
inventing requirements from the vagueness of the request.

## Case 1 — Positive: omission + quiet substitution

Spec: (a) CSV export of the user list, (b) date-range filter on the export,
(c) export includes inactive users. Deliverable: export works, the date filter
works, inactive users are silently excluded, and the developer added a PDF
export nobody asked for, claiming "export feature complete".

Rubric:
- Must recover all 3 EXPLICIT requirements plus the unasked PDF as candidate
  drift. PASS — Phase 1 lists (a)–(c) explicit; the PDF has no source text, so
  it cannot be a requirement.
- Must classify (c) as Omitted or Substituted with evidence (no filtering code
  path includes inactive users). PASS — "no evidence found" after searching the
  export query; silent exclusion without approval is a substitution.
- Must flag the PDF export as Drift (unapproved scope addition), not as a
  fulfilled requirement. PASS — Phase 4/6: better-without-permission is drift.
- Must flag "export feature complete" as an unsupported completion claim
  (blocker), not accept the summary. PASS — Phase 5 tests the claim against
  the matrix.

**Case verdict: PASS.**

## Case 2 — Negative: non-trigger requests

(a) User says "run the test suite." (b) User says "review this code for style."

Rubric:
- The skill must NOT fire for (a): executing tests is listed as a negative
  trigger, and the skill's inputs require an original intent to verify
  against. PASS — trigger matching declines; nothing to check against.
- For (b) with no original requirements available, the skill must decline
  rather than invent requirements to review against. PASS — the Inputs section
  mandates stopping and naming what would be needed.

**Case verdict: PASS.**

## Case 3 — Edge: green tests, missing core requirement + vague request

(a) All 12 tests pass; the core requirement (rate limiting, from Attack 1) was
never implemented. Rubric: the skill must NOT treat the green suite as proof;
the requirement must be classified Omitted with "unverified by tests" noted,
and the verdict must not be "fulfilled". PASS — Phase 3's evidence rule
forces this; Attack 1's walk confirms it.

(b) Original request is vague: "make the dashboard nicer." Rubric: the skill
must not assert concrete requirements (it must not invent "add charts" as
EXPLICIT); any recovered items must be labeled INFERRED, surfaced as Notes,
and kept out of the verdict math — overall verdict "intent fulfilled (with N
assumptions worth confirming)" at best, never a failure on invented grounds.
PASS — Phase 1 tagging + steering rule enforce this; Attack 2's walk
demonstrates the labeling.

**Case verdict: PASS.**

## Verdict

All acceptance checks pass for v1. The Missing-Intent Detector survived both
mandated adversarial scenarios: it is distinguishable from a generic code
review (requirement-level evidence matrix, EXPLICIT/INFERRED split changing
verdicts, completion claims tested against the matrix rather than accepted).
Honesty ledger: behaviorally tested. Limitation: comparative advantage over
unaided review remains a hypothesis — no A/B comparison was run, and the skill
does not claim one.
