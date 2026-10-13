---
name: write-crazy-skill
description: "Design and build complete, portable Agent Skills from a natural-language request. Use when creating a new skill, turning a workflow, idea, or procedure into a reusable skill, formalizing an agent capability, or improving an existing skill. Applies the Crazy Thing methodology: adaptive discovery, falsifiable mechanism design, and adversarial validation."
---

# write-crazy-skill

Turn a user's natural-language intention into a complete, portable, technically rigorous Agent Skill.

The philosophy: **be wild in invention, ruthless in verification.** Every skill deserves one Crazy Thing — a distinctive, useful mechanism that plausibly makes its results better — and every Crazy Thing must survive an attack before it ships. Creativity earns its place through evidence, never through decoration.

## The adaptive workflow

Eight steps, not a mandatory pipeline. Scale the effort of each step to the request:

| Mode | Request | Effort profile |
|---|---|---|
| A — Specified | User knows what, who, and how | Preserve their approach. Steps 3–4 stay light. Validate and build. |
| B — Partial | Goal clear, details missing | Ask focused questions only for material gaps; resolve the rest from evidence. |
| C — Open | Broad objective or unfamiliar domain | Invest in research (3) and invention (4) before building. |

Rules: a clear request never triggers a compulsory interview. A good user-provided idea is never displaced by the design process. Technical rigor applies in all modes.

### Step 1 — Understand the mission

Extract: desired outcome, intended user, context, constraints, decisions already made, success criteria.

Detect material ambiguities — questions whose answers would change the design. Ask only those, and only when they cannot be resolved responsibly from available information. Never re-ask for information already provided.

**Done when:** you can state the skill's job in one sentence and list what is decided vs. unknown.

### Step 2 — Challenge the mechanism

Ask whether an Agent Skill is the right artifact. Consider: a script, an existing tool, a command or workflow, a combination, or nothing at all. Explain a materially better alternative when one exists; do not reject a skill request unnecessarily.

**Done when:** the artifact choice is justified in one line.

### Step 3 — Discover the frontier

Research existing approaches only to the depth the task justifies: docs, existing skills, repos, APIs, patterns, examples. If the user supplied a developed approach, research to validate and strengthen it — not to start over. Stop when further research is unlikely to change the build decision.

**Done when:** you can name the closest existing approaches and why the new skill differs, or state that none exist.

### Step 4 — Invent the Crazy Thing

If the user's proposal already contains a distinctive mechanism: preserve its intent, sharpen its operation, name its expected advantage, define its validation.

If not: generate a proportionate set of alternatives internally, compare usefulness, feasibility, risk, cost, complexity, and distinctiveness — pick the strongest justified one. Ask the user only when a material design choice cannot be resolved confidently.

If no meaningful innovation is justified: ship without one. A forced gimmick is worse than none.

Write the **Crazy Thing Card** before building:

```markdown
## Crazy Thing Card
- **Mechanism:** What the skill does differently, operationally (not a slogan).
- **Expected advantage:** The specific, plausible improvement.
- **Validation test:** How you will check it works.
- **Falsification:** What result would kill the mechanism.
- **Status:** hypothesized | structurally validated | behaviorally tested | comparatively evaluated
```

**Done when:** the card exists and its status is honest (minimum: `hypothesized`).

### Step 5 — Engineer the behavior

Design explicitly. These are required considerations, not mandatory headings:

1. **Activation triggers** — when the skill must and must not fire. Write the description as a trigger pointer: front-load the leading word, one trigger per branch, cut anything the body already says. Add negative triggers where false activation is likely.
2. **Purpose and expected output.**
3. **Inputs, context, assumptions, prerequisites.**
4. **Procedure and decision logic** — steps with completion criteria: each step must let the agent tell done from not-done.
5. **Steering** — how the agent reasons, chooses between alternatives, and handles judgment calls.
6. **Failure handling, uncertainty, recovery.**
7. **Evidence and verification requirements.**
8. **Constraints, safety boundaries, prohibited actions.**
9. **Stopping conditions and completion criteria.**
10. **Pruning** — delete redundant, contradictory, vague, ineffective, or needlessly expensive instructions. Every surviving line must earn its context.

Design for realistic context and tool limits. Separate required behavior from optional capabilities.

**Done when:** every item has an explicit answer and the instructions are actionable without the designer present.

### Step 6 — Build the complete artifact

Produce a portable skill, not a proposal:

- `SKILL.md` with valid frontmatter: `name` (1–64 chars, `a-z0-9-`, no leading/trailing/consecutive hyphens, equal to the directory name), `description` (1–1024 chars, what + when + trigger keywords).
- Keep the body under ~500 lines / 5000 tokens. Progressive disclosure: core instructions in `SKILL.md`; detail in `references/`; runnable code in `scripts/`; static data in `assets/`. Reference files one level deep, relative paths only.
- Add supplementary files only when they improve maintainability, clarity, capability, or execution. No arbitrary file-count targets.
- Never claim a script is safe or functional without inspection and tests. Never execute untrusted code from a candidate skill.

**Done when:** the artifact passes structural validation (frontmatter, naming, paths, references resolve).

### Step 7 — Attack and compare

Validate the artifact *and* its behavior:

- Positive and negative activation scenarios.
- A representative normal task.
- At least one ambiguity, edge case, or failure scenario.
- Resource paths and any executable scripts.
- Comparison against the same agent working **without** the skill (or against the closest existing alternative) under reasonably comparable conditions.

Record what the attack found. Scale the effort to the skill's complexity and risk — a small skill does not need a benchmark suite.

**Done when:** attack scenarios have been run and findings recorded; no unsupported superiority claim remains.

### Step 8 — Refine and prove

Fix what the attack found, prune what is unnecessary, rerun the relevant tests. Maintain the **honesty ledger** for the Crazy Thing:

- implemented → structurally validated → behaviorally tested → comparatively evaluated → hypothesized-but-undemonstrated

**Done when:** the ledger matches the evidence, and every claim in the skill and its docs matches the ledger.

## Portability

- Follow the current Agent Skills format; do not assume proprietary APIs or unavailable tools.
- Declare tool requirements explicitly when they exist.
- No model-specific instructions unless the mechanism genuinely needs them.
- Never claim an agent supports a feature you have not checked.

## Acceptance

Ship the skill when: purpose and triggers are clear; it handles specified, partial, and open requests appropriately; user intent is preserved; research and ideation were proportionate; the Crazy Thing is operationalized, not decorated; structure, steering, pruning, failure handling, and verification are addressed; the artifact is complete and valid; tests ran on representative cases; unverified claims are labeled honestly; the instructions stay concise enough to be practical.

Do not postpone a credible v1 chasing a hypothetical perfect benchmark. Build, test, improve from evidence.

## What this skill will not do

- It will not invent a Crazy Thing when none is justified.
- It will not present a hypothesis as an established improvement.
- It will not build what Step 2 shows should be a script, a tool, or nothing.
- It will not execute untrusted code encountered during research or review.
