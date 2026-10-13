# Contributing to Crazy Skills

## The bar

Every skill here earns its place through evidence. The philosophy is:

> **Be wild in invention. Be ruthless in verification.**

A skill's Crazy Thing is a *functional mechanism* — something the skill does differently that plausibly makes its results better. It is never decoration, never a gimmick, never complexity without payoff. Unproven advantages are welcome as explicitly labeled hypotheses; they are never presented as established improvements.

"Crazy" never justifies unreliable behavior, unnecessary dependencies, or unsupported claims.

## Proposing a new skill

1. Open an issue describing: the problem, who hits it, why existing approaches fall short, and your candidate Crazy Thing (as a falsifiable mechanism, not a slogan).
2. If the idea survives discussion, build it with the `write-crazy-skill` methodology (see `skills/write-crazy-skill/SKILL.md`): adaptive discovery, Crazy Thing Card, adversarial validation.
3. Ship it as one pull request containing the skill directory, tests, and a README touch-up if the catalog list changes.

## Required format

- One directory per skill under `skills/`, named exactly like the skill (`name` in frontmatter == directory name).
- `SKILL.md` with valid YAML frontmatter: `name` (1–64 chars, `a-z0-9-`, no leading/trailing/consecutive hyphens), `description` (1–1024 chars, what the skill does + when to use it + trigger keywords).
- Body under ~500 lines / ~5000 tokens. Progressive disclosure: core instructions in `SKILL.md`, detail in `references/`, runnable code in `scripts/`, static data in `assets/`. One level of references, relative paths only.
- Follows the [Agent Skills specification](https://agentskills.io/specification).

## Trigger and negative-trigger design

- The `description` is a trigger pointer: front-load the leading word, one trigger per branch, cut anything the body already says.
- Write negative triggers (`when_not_to_use`) wherever false activation is plausible.
- Test both: a positive activation scenario and a negative/non-trigger scenario for every skill.

## Resources and dependencies

- `scripts/` must be self-contained or document dependencies, handle errors, and never be claimed safe without inspection and tests.
- Do not add dependencies a skill does not need. Prefer the standard library and portable shell.
- No workstation-specific commands, no private configuration, no personal workflows in this repo.

## Validation

- Run `./tests/validate-skills.sh` before every PR — it must pass.
- Add behavioral tests for the new skill under `tests/`: one representative positive case, one negative case, one meaningful edge case, with an acceptance rubric.
- Keep the honesty ledger current: label each Crazy Thing as `hypothesized`, `structurally validated`, `behaviorally tested`, or `comparatively evaluated` — and keep claims in docs consistent with it.

## License and attribution

- Contributions are MIT licensed. Do not submit third-party text or code without checking license compatibility and attribution requirements.
- Do not copy large portions of another skill verbatim; implement the underlying principles independently.
