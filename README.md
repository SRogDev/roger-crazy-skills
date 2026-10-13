# Crazy Skills

**Unreasonably clever skills. Measurably better work.**

A public collection of reusable [Agent Skills](https://agentskills.io/specification) built on one conviction: *every skill deserves one crazy idea* — a distinctive, useful mechanism that makes its results meaningfully better. No gimmicks. No complexity without payoff. Creativity earns its place through evidence.

> **Be wild in invention. Be ruthless in verification.**

## The catalog

| Skill | What it does | Crazy Thing | Status |
|---|---|---|---|
| `write-crazy-skill` | Turns a natural-language request into a complete, portable Agent Skill | Crazy Thing Card: every mechanism ships as a falsifiable hypothesis with a validation test — creativity becomes testable | ✅ ready |
| `design-thief` | Reproduces or improves a target visual design from references | Visual Delta Loop: inspect → rank discrepancies by visual impact → fix → reinspect | 🚧 in progress |
| `intention-verification` | Checks whether a deliverable fulfills the original intent, not just looks complete | Missing-Intent Detector: maps requirements to evidence, flags superficial compliance | 🚧 in progress |
| `cost-guard` | Finds and prevents unjustified costs in agent workflows and operations | Cost Amplification Traps: traces retries, fan-out, polling loops that multiply spend | 🚧 in progress |
| `spec-compiler` | Compiles natural-language intentions into precise, executable specifications | Intent Compression Without Loss: traceable, ambiguity-free specs another agent can build from | 🚧 in progress |
| `boundary-breaker` | Identifies and tests trust boundaries and assumptions in systems and integrations | Trust-Boundary Inversion: adversarial scenarios scoped, authorized, and proportionate | 🚧 in progress |
| `capability-scout` | Discovers existing capabilities before building from scratch | Unknown-Unknown Search: decomposes the goal, searches tools, libraries, APIs, MCP servers, patterns | 🚧 in progress |

Each skill is model-invoked (fires autonomously via its `description`) and portable across agents that support the Agent Skills format.

## Install

Individual skills live under `skills/<name>/` — copy the directory into your agent's skills folder, or point your tooling at this repo.

```bash
npx skills add SRogDev/roger-crazy-skills
```

> The `npx skills add` flow is the intended installation method; single-skill installs follow the same pattern when supported by your tooling. Verified install instructions will replace this note once tested against current tooling.

## The methodology

All seven skills are built with `write-crazy-skill` (in this repo): adaptive discovery for specified, partial, and open-ended requests; a falsifiable Crazy Thing Card before any building; engineering of triggers, steering, failure handling, and pruning; adversarial validation (the skill is attacked — positive/negative activation, edge cases, comparison against working without it) before it ships.

## Validation

```bash
./tests/validate-skills.sh
```

Checks frontmatter validity, naming rules, description length, body size, relative/safe paths, resolvable references, and scans for accidental secrets. See `tests/README.md` for the behavioral test suite.

## Contributing

Read `CONTRIBUTING.md`. One skill per PR, tests included, hypotheses labeled honestly.

## License

MIT — see `LICENSE`.
