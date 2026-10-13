# PROJECT BRIEF — roger-crazy-skills

Full context for handoff to another AI. Keep current.

## What

Public repository `SRogDev/roger-crazy-skills` (MIT): seven reusable Agent Skills built
with a shared methodology — "Unreasonably clever skills. Measurably better work."

## Why

Reusable skills are usually generic checklists. This repo's bet: every skill deserves
one Crazy Thing — a distinctive, useful mechanism that plausibly improves results —
and every mechanism must survive adversarial validation before shipping.

## The seven skills

1. **write-crazy-skill** (foundation): natural-language request → complete portable
   skill. Adaptive 8-step workflow (modes for specified / partial / open requests),
   Crazy Thing Card (falsifiable mechanism + validation test + honesty status),
   attack-and-compare protocol, honesty ledger.
2. **design-thief**: reproduce/improve a visual design from references. Crazy Thing:
   Visual Delta Loop (inspect → rank discrepancies by impact → fix → reinspect).
3. **intention-verification**: verify a deliverable fulfills original intent.
   Crazy Thing: Missing-Intent Detector.
4. **cost-guard**: find/prevent unjustified costs in agent workflows. Crazy Thing:
   Cost Amplification Traps.
5. **spec-compiler**: natural language → precise executable specs. Crazy Thing:
   Intent Compression Without Loss.
6. **boundary-breaker**: identify/test trust boundaries. Crazy Thing:
   Trust-Boundary Inversion (scoped, authorized adversarial scenarios).
7. **capability-scout**: discover existing capabilities before building. Crazy Thing:
   Unknown-Unknown Search.

## Related but separate

**crazy-behavioral**: a SkillGen-oriented skill that designs the behavioral contract of
a skill for a weaker LM and stops before authoring final files. Lives in the SkillGen
repo (`SRogDev/skillgen`), NOT in this repo's seven-skill catalog. Must not change
SkillGen's dataset, splits, training setup, or eval baseline.

## Technical anchors

- Format: [Agent Skills spec](https://agentskills.io/specification) — frontmatter
  `name`/`description`, body < ~500 lines, progressive disclosure
  (`references/` > `scripts/` > `assets/`), relative paths one level deep.
- Writing discipline: Matt Pocock's `writing-for-agents` (trigger pointers,
  context vs. cognitive load, information hierarchy, completion criteria per step,
  pruning) and `SKILL-MECHANICS.md` (model-invoked vs. user-invoked).
- Validation: `tests/validate-skills.sh` (structural) + behavioral scenarios per skill.

## Conventions

- PR workflow: every change as a PR against `main`, one logical change per PR,
  squash-merge, maintainer merges own PRs. Never push to `main` directly.
- README rule: significant changes ship a README touch-up in the same PR (English).
- Gentle-ai discipline for code: small inline + verify; report commands + results.

## Current state

See STATUS.md. Foundation (repo + write-crazy-skill + validator) done 2026-10-13.
Six skills + crazy-behavioral integration in progress.
