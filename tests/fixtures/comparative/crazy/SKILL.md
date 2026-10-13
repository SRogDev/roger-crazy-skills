---
name: commit-message-coach
description: Draft and improve git commit messages from a diff, with every claim grounded in the actual changes. Use when the user asks to write a commit message, check whether a message is good, or clean up commit wording. Do not use for PR descriptions, changelogs, or rewriting git history.
---

# commit-message-coach (crazy)

Help the user write a clear commit message whose every claim is grounded in the
actual diff.

## Crazy Thing Card

- **Mechanism:** DIFF-GROUNDED DRAFTING — every clause of the message must cite
  the diff hunk it describes (`[hunk 2]`); any content not traceable to a hunk
  is flagged `[UNVERIFIED]` instead of being written as fact.
- **Expected advantage:** eliminates invented change descriptions — the most
  common failure of commit-message assistants.
- **Validation test:** a diff touching only `auth.py` must never produce a
  message mentioning `billing.py`; run the negative-trigger and empty-diff cases.
- **Falsification:** if a generated message contains a claim no hunk supports
  and it is not flagged, the mechanism failed — say so.
- **Status:** behaviorally tested (walkthroughs below); comparative advantage
  over the baseline is hypothesized.

## When to use

Fire on: "write a commit message", "is this commit message good", "improve this
commit message", "help me word this commit".

Do not fire on: PR descriptions, changelog entries, `git rebase -i` history
rewrites, or commit-message requests with no diff and no description of the change.

## Procedure

### 1. Read the change

Get the diff (`git diff --cached`, or the user's description if nothing is staged).
Number the hunks: `[hunk 1]`, `[hunk 2]`, …
*Done when:* you can state what changed in one sentence and each hunk is numbered.

### 2. Draft with grounding

Write an imperative-mood subject ≤72 chars, then an optional *why* body. Append
a hunk citation to every factual clause. Anything you want to say that no hunk
supports gets `[UNVERIFIED]` instead of being stated as fact.
*Done when:* a complete message exists and every factual clause cites a hunk or
is flagged.

### 3. Check it

Verify: subject ≤72 chars, imperative, no trailing period, body explains
motivation — **and** every citation resolves to a real hunk. Fix violations;
drop or flag unverifiable claims.
*Done when:* all checks pass or the user waives them explicitly.

### 4. Present

Show the message in a code block plus two alternatives (shorter/longer).
*Done when:* the user picks, edits, or declines.

## Edge cases

- Empty diff and no description: ask what changed; do not invent a message.
- Huge diff, many areas: suggest splitting the commit, draft per part.
- Repo follows conventional commits: match existing style (check recent log).
- Description-only input (no diff): every clause is `[UNVERIFIED]` by construction —
  say so up front.

## Honesty ledger

- Grounding mechanism: behaviorally tested (walkthroughs: cross-file invention
  blocked, empty diff declined, description-only flagged).
- Advantage over unaided/baseline drafting: hypothesized — not measured.
