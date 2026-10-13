# AGENTS.md — roger-crazy-skills

Working agreement for AI agents contributing to this repository.

## What this repo is

A public collection of reusable Agent Skills following the [Agent Skills specification](https://agentskills.io/specification).
Philosophy: **be wild in invention, ruthless in verification.** Every skill has one
Crazy Thing — a distinctive, useful, falsifiable mechanism. Hypotheses are labeled
honestly; nothing unproven is presented as an established improvement.

## How to work here

- The methodology skill is `skills/write-crazy-skill/SKILL.md`. Use it to design any
  new skill for this repo — it is the house standard, not a suggestion.
- One skill = one directory under `skills/`, named exactly like the skill.
- One pull request = one logical change (one skill, or repo-wide tooling/docs).
  Squash-merge; never push directly to `main`.
- README rule: every significant change ships a README touch-up in the same PR.
  READMEs stay in English and current.
- Run `./tests/validate-skills.sh` before every PR. It must pass.
- New skills need behavioral tests (positive, negative, edge case + rubric) — see
  `tests/README.md`.
- Keep `SKILL.md` bodies under ~500 lines; push detail into `references/`,
  code into `scripts/`, static data into `assets/`. Relative paths, one level deep.
- No secrets, no workstation-specific paths, no personal workflows in this repo.
- License: MIT. Check attribution before including third-party material.

## Validation workflow (gentle-ai discipline)

- Small script or doc edits: work inline, then verify by running the check.
- New skill: draft → validate structurally → behavioral scenarios → prune → rerun.
- Report honestly: what changed, verification evidence (commands + results),
  what remains TODO. Never present a stub as working.
