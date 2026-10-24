# Evidence base — what the design bets on, and how sure we are

Every load-bearing design decision in this skill maps to a named
learning-science result. This file keeps the mapping explicit so the
bets stay honest: moderate, replicated effects used as *design
heuristics*, not magic. Effect sizes below are as published; the
populations are mostly school/university students, so transfer to
self-taught adults is plausible and consistent with the mechanisms —
but it is an extrapolation, and the skill's own rubric comparison is
the local evidence that matters most.

## The bets

**1. Attempt before instruction (beats 1–3 before 4) — Productive
Failure / PS-I.**
Sinha & Kapur (2021), meta-analysis of 53 studies / 166 comparisons:
problem-solving before instruction beats instruction-first for
conceptual understanding and transfer, Hedges' g ≈ 0.36, rising to
≈ 0.58 when implemented with high fidelity to productive-failure
principles. Kapur (2014), two RCTs in mathematics specifically:
problem-solving-first produced significantly greater conceptual
understanding and transfer with *no* loss of procedural knowledge.
→ Design: the learner manipulates and fails at designed traps before
any definition appears (the Definition Gate).

**2. Committed predictions (beat 2) — the pretesting effect.**
Attempting to answer before being taught improves later retention of
the taught material, even when the attempt is wrong (Richland, Kornell
& Kao 2009; reviewed in multiple meta-analyses since). The effect
*grows* with retention interval — roughly doubling at a week in
Kliegl, Bartl & Bäuml (2024) — and it survives, indeed was demonstrated
with, AI-assisted study (Akgun & Toker 2024: pretesting before using
ChatGPT improved subsequent test performance).
→ Design: predictions are forced choices, committed before the reveal,
and the reveal is never peekable from the asking position.

**3. Concrete first, symbols faded in (beats 1–5) — concreteness
fading.**
Fyfe, McNeil, Son & Goldstone (2014): learning that begins with
concrete instantiations and progressively fades to abstract notation
outperforms both all-concrete and all-abstract instruction for
transfer.
→ Design: the figure is the concrete instantiation; beat 5 ends with
symbols-first exercises so the endpoint is genuine abstract fluency,
not dependence on the picture.

**4. Self-explanation prompts (beat 5) — the self-explanation effect.**
Chi et al. (1989, 1994): students who explain worked examples to
themselves learn substantially more; prompting self-explanation in
materials captures much of the benefit.
→ Design: worked examples pause at decision points with "why did
that happen?" prompts instead of narrating past them.

**5. Worked examples over problem-solving for novices (beat 5) —
worked-example effect / cognitive load.**
Sweller & Cooper (1985) and Renkl's fading research: for novices,
studying worked examples produces better learning per unit time than
solving equivalent problems; support is then faded.
→ Design: examples are *walked*, numbers supplied by the model; the
learner interprets. Consistent with the Math 2.0 doctrine — no
hand-drill — but note the honest tension: this literature also shows
procedural fluency needs practice. The skill's answer is deliberate:
its goal is conceptual ownership for people whose *software* computes;
it does not claim to produce hand-computation fluency and says so.

**6. Explain-back and recall (beat 6) — retrieval practice + Feynman
technique.**
Roediger & Karpicke (2006): retrieval practice beats re-study for
delayed retention. The Feynman technique (explain in plain words,
find the gaps) is the folk operationalization; beat 6's questions are
built so retrieval must be generative (new phrasing, a counterexample,
a rebuttal), not recognition.
→ Design: defend questions ban the piece's own phrasing; recall
prompts are closed-book.

**7. Multiple linked representations (beats 4–5) — DeFT.**
Ainsworth (2006): multiple representations help when learners are
supported in translating *between* them; unlinked multiplicity adds
load without benefit.
→ Design: representations are always adjacent and explicitly mapped
("this arrow *is* this symbol *is* this line of code"), never merely
co-present.

## Closest existing approaches — and the difference

- **3Blue1Brown (Essence of Linear Algebra et al.):** intuition-first
  geometry, superb exposition — but passive video: no manipulation,
  no committed predictions, no designed failure, no defend check.
  math-anatomy pieces are things you *do*, with gates.
- **Brilliant / interactive courses:** interactive problem-first
  learning at scale — but organized around solving problems and
  streaks, with definitions introduced conventionally early, and no
  transfer-to-your-own-systems beat. The Definition Gate's strict
  no-formalism-before-touch ordering and the Defend/Transfer beats are
  the deltas.
- **Khan Academy / standard textbooks:** definition → example →
  exercise, the exact ordering this skill exists to invert.
- **Anki/spaced repetition:** retrieval machinery without the
  conceptual encounter; complementary, not competing.

## Honesty ledger for the evidence

- The meta-analytic effects are **moderate** (g ≈ 0.36–0.58), not
  transformations. The skill claims a *noticeable* difference in
  understanding-per-hour for its specific audience, not miracles.
- Most studies measure days-to-weeks retention in classroom settings.
  Long-term, in-the-wild outcomes for self-taught adults are **not**
  directly established.
- The skill's Crazy Thing (the Gate as an enforceable structure) is a
  design hypothesis built *on* this evidence, not itself an evaluated
  intervention. Its status lives in the Crazy Thing Card and the
  behavioral test doc, and must stay labeled until comparative
  evaluation says more.
