# Comparative evaluation: Write Crazy Skill methodology vs. baseline

**Status: preliminary.** One representative task, self-evaluated. Do not cite as
proof of superiority — see Limitations.

## Task

"Create a skill that helps me write better commit messages." Small, well-specified
(Mode A). Same task, same constraints for both artifacts.

## The two artifacts

- **Baseline** (`tests/fixtures/comparative/baseline/SKILL.md`): designed with
  established practices only (Matt Pocock's `writing-for-agents`: trigger
  pointers, steps with completion criteria, pruning, progressive disclosure).
  No Crazy Thing machinery, no attack protocol, no honesty ledger.
- **Crazy** (`tests/fixtures/comparative/crazy/SKILL.md`): the same task through
  `write-crazy-skill` — Crazy Thing Card (diff-grounded drafting: every clause
  cites its hunk, untraceable claims flagged `[UNVERIFIED]`), attack scenarios,
  honesty ledger.

Trigger sections were kept identical on purpose, so the comparison isolates the
methodology's contribution rather than trigger-writing skill.

## Results

| # | Criterion | Baseline | Crazy | Winner |
|---|---|---|---|---|
| 1 | Correct activation / non-activation | Sharp triggers + negatives | Identical triggers | Tie |
| 2 | User-intent preservation | Preserved | Preserved | Tie |
| 3 | Task success | Produces a message | Produces a message **plus** grounding verification | Crazy |
| 4 | Completeness / correctness | Checks style rules | Checks style rules **and** citation resolution | Crazy |
| 5 | Robustness to edge cases | Empty diff, huge diff, conventions | Same, **plus** description-only input (all-claims-unverified flag) | Crazy |
| 6 | Distinctive behavioral contribution | None by design | Diff-grounded drafting with falsification test | Crazy |
| 7 | Unnecessary complexity | 45 lines, minimal | 85 lines + card; citation overhead is real friction for quick drafts | Baseline |
| 8 | Context / execution cost | ~1.7 KB per activation | ~3.1 KB per activation (~2×) | Baseline |

## Reading

The methodology's contribution is real and specific: it caught the failure mode
that matters for this task (invented change descriptions) by forcing a falsifiable
mechanism and an attack step the baseline never runs. The price is also real:
~2× context per activation and citation friction on quick drafts. For this task
the trade looks justified; for trivial tasks it might not be — which is exactly
why the methodology says *don't invent a mechanism when none is justified*.

No major failures in either artifact. Nothing here promotes the advantage claim
past hypothesis.

## Limitations

- n=1 task, one evaluator (the methodology's author) — not independent, not general.
- The baseline is a strong one (Pocock principles applied carefully); a weaker
  baseline would flatter the methodology.
- Behavioral scoring is judgment-based; only the structural checks are mechanical.
- The honest next step is more tasks and an independent evaluator, not a bigger
  claim from this page.
