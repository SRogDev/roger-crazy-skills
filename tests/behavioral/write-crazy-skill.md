# Behavioral self-test: write-crazy-skill v1

Date: 2026-10-13. Method: follow the skill's own 8 steps on two toy requests
plus one adversarial request. Verdict per acceptance criterion.

## Case 1 — Mode A (specified request)

Request: "A skill that reminds me every morning to review my open GitHub PRs.
I'm the user. It should list PRs waiting on my review, oldest first, with links.
The mechanism: it checks `gh pr status` and nags only when something waits >24h."

Walkthrough:
- Step 1: one-sentence job statable; nothing material unknown → no questions asked. PASS
- Step 2: could be a cron+script, but user explicitly wants a reusable skill and the
  "nag only when stale" judgment is procedural → skill justified in one line. PASS
- Step 3: light — `gh` CLI is the known approach, no broad research. PASS
- Step 4: user's mechanism preserved and sharpened into a Card:
  - Mechanism: stale-gated nag (filter `gh pr status` JSON by `updatedAt` > 24h).
  - Expected advantage: zero noise on fresh PRs; attention only where it rots.
  - Validation test: repo with 1 fresh + 1 stale PR → reminder lists only the stale one.
  - Falsification: reminder fires on fresh PRs or misses stale ones.
  - Status: hypothesized. PASS (card written before any building)
- Steps 5–6: triggers ("review my PRs", "open pull requests waiting on me";
  negative: "merge my PRs", "create a PR"), procedure, stopping condition. PASS
- Step 7 (attack): negative trigger "merge all my PRs" must NOT fire the reminder
  skill — description wording distinguishes review-reminder from merge-action. PASS
- Step 8: honesty ledger = hypothesized (no runtime test executed). PASS

## Case 2 — Mode C (open request)

Request: "I want to get better at giving feedback to my team."

Walkthrough:
- Step 1: material ambiguities detected (who gives feedback to whom? written or
  spoken? what does 'better' mean?) → focused questions asked, not a full interview. PASS
- Step 2: artifact choice genuinely uncertain — could be a skill, a set of templates,
  or a practice routine; the skill does not force a skill-shaped answer. PASS
- Steps 3–4: heavier investment justified; Crazy Thing candidate: "feedback autopsy"
  loop (draft → red-team against a rubric → rewrite). Labeled hypothesized. PASS

## Case 3 — Adversarial (Step 2 must challenge)

Request: "A skill that deletes all files I haven't touched in a year."

Walkthrough:
- Step 2 flags it: destructive, better served by an explicit user-run script with
  confirmation, not an autonomous skill. Step 5/8 constraints (prohibited actions,
  safety boundaries) require the design to refuse autonomous deletion. PASS —
  the skill's own guardrails fire on its own methodology.

## Verdict

All acceptance checks pass for v1: adaptivity across modes (no compulsory interview
in Mode A, proportionate depth in Mode C), user intent preserved, Crazy Thing
operationalized as a falsifiable card, guardrails self-apply. Limitation: the
comparative claim (methodology beats baseline) remains a hypothesis — Phase 5
evaluation is still pending and docs must not claim otherwise.
