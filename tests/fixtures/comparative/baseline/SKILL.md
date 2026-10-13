---
name: commit-message-coach
description: Draft and improve git commit messages from a diff. Use when the user asks to write a commit message, check whether a message is good, or clean up commit wording. Do not use for PR descriptions, changelogs, or rewriting git history.
---

# commit-message-coach (baseline)

Help the user write a clear commit message for their staged changes.

## When to use

Fire on: "write a commit message", "is this commit message good", "improve this
commit message", "help me word this commit".

Do not fire on: PR descriptions, changelog entries, `git rebase -i` history
rewrites, or commit-message requests with no diff and no description of the change.

## Procedure

### 1. Read the change

Get the diff (`git diff --cached`, or the user's description if nothing is staged).
*Done when:* you can state what changed in one sentence.

### 2. Draft the message

Write an imperative-mood subject line, ≤72 characters, then an optional body
explaining *why* (not *what* — the diff shows what).
*Done when:* a complete message exists.

### 3. Check it

Verify: subject ≤72 chars, imperative mood, no trailing period, body (if any)
explains motivation. Fix violations directly.
*Done when:* every check passes or is explicitly waived by the user.

### 4. Present

Show the message in a code block plus two shorter/longer alternatives.
*Done when:* the user picks, edits, or declines.

## Edge cases

- Empty diff and no description: ask what changed; do not invent a message.
- Huge diff touching many areas: suggest splitting the commit, then draft per part.
- Repo follows conventional commits: match its existing style (check recent log).
