# STATUS.md — roger-crazy-skills

## Done

- 2026-10-13: Repository bootstrapped (README, LICENSE MIT, CONTRIBUTING, .gitignore,
  AGENTS.md, STATUS.md, docs/PROJECT_BRIEF.md).
- 2026-10-13: `write-crazy-skill` v1 implemented — adaptive 8-step workflow, Crazy Thing
  Card, trigger-writing rules, attack-and-compare protocol, honesty ledger.
- 2026-10-13: `tests/validate-skills.sh` implemented and verified (RED→GREEN: caught a
  relative-path bug via fixtures; pass fixture exits 0, fail fixture reports 6 violations).
- References consulted: Agent Skills spec (agentskills.io), Matt Pocock's
  `writing-for-agents` + `SKILL-MECHANICS.md` (successor of `writing-great-skills`),
  Anthropic `anthropics/skills` template.

- 2026-10-23: `math-anatomy` v1 built on local branch `feat/math-anatomy` —
  Math 2.0 learning pieces (manipulable figure + guided path) gated by the
  Definition Gate mechanism; two pilot pieces built (gradient descent,
  linear algebra) and a no-skill baseline comparison run for the
  behavioral test doc. PR pending.

## Doing

- `crazy-behavioral` integration into SkillGen (separate repo, separate PR).
- Phase 5 comparative evaluation: Write Crazy Skill methodology vs. baseline on a
  small representative subset.
- Verify the `npx skills add SRogDev/roger-crazy-skills` install flow against current tooling.

## Shipped 2026-10-13

All seven public skills built with the `write-crazy-skill` methodology and merged
as individual PRs (#1–#6 + docs):
- `write-crazy-skill` — Crazy Thing Card methodology (foundation)
- `design-thief` — Visual Delta Loop
- `intention-verification` — Missing-Intent Detector
- `cost-guard` — Cost Amplification Traps
- `spec-compiler` — Intent Compression Without Loss
- `boundary-breaker` — Trust-Boundary Inversion
- `capability-scout` — Unknown-Unknown Search
Each ships with behavioral test walkthroughs (`tests/behavioral/`) and honest
evidence labels; comparative superiority claims remain hypotheses.

## Next

- Behavioral test scenarios per skill (positive / negative / edge + rubric).
- Comparative evaluation: Write Crazy Skill methodology vs. baseline on a small subset.
- Verify the `npx skills add SRogDev/roger-crazy-skills` install flow against current tooling.
- Publish v1.0 when all seven skills pass structural + behavioral validation.

## Known limitations

- Superiority claims for the Crazy Thing mechanisms are hypotheses until the
  comparative evaluation (Phase 5 of the plan) runs — docs must not claim otherwise.
- `writing-great-skills` (referenced in the original plan) no longer exists upstream;
  `writing-for-agents` was used as its successor.
