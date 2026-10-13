# Tests

## Structural validation

`validate-skills.sh` checks every `skills/<name>/SKILL.md`:

1. Frontmatter parses and contains `name` + `description`.
2. `name`: 1–64 chars, `[a-z0-9-]`, no leading/trailing/consecutive hyphens, matches the directory name.
3. `description`: non-empty, ≤ 1024 chars.
4. Body non-empty; warns when > 500 lines (progressive disclosure).
5. File references are relative, safe (no `..` escapes), and resolve to existing files.
6. No accidental secrets (API keys, tokens, private keys).

```bash
./tests/validate-skills.sh [--expect N] [repo-root]
```

Exit 0 = all skills valid. CI-style usage: `./tests/validate-skills.sh --expect 7 .`

## Fixtures

- `fixtures/pass/` — a minimal valid skill; the validator must exit 0 on it.
- `fixtures/fail/` — a skill broken six ways (bad name, name/dir mismatch, empty
  description, dangling reference, absolute path, fake token); the validator must
  exit 1 and report every violation.

Run them to prove the validator itself works:

```bash
./tests/validate-skills.sh tests/fixtures/pass   # expect OK
./tests/validate-skills.sh tests/fixtures/fail   # expect 6 FAILs
```

## Behavioral tests

Structural validity is not proof of behavior. Each skill ships with scenario tests:

- one representative **positive** case (skill should fire and help),
- one **negative** case (skill must not fire, or must decline),
- one meaningful **edge case**,
- an acceptance rubric per case.

Scenario tests live next to the skill they cover or in `tests/behavioral/` once the
catalog is complete. They are run by a human or an agent following the rubric —
deterministic where possible, model-judged where behavior cannot be checked structurally.
