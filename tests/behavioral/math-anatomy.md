# Behavioral self-test: math-anatomy v1

Date: 2026-10-23. Method: build two real pieces by applying the skill as
written (gradient descent; linear algebra — a matrix as a machine),
walk a negative case and an edge case against the skill's fire/decline
rules, then run the Crazy Thing's falsification protocol: score a
no-skill baseline and the gradient-descent pilot on the skill's own
rubric (references/rubric.md) and compare. Verdict per criterion.

## Case 1 — Positive (gradient descent, full build)

Built by applying the skill as written. Artifact:
`math-anatomy-pilots/gradient-descent/` (index.html + GUIDE.md +
NOTES.md + 6 captures). The figure: contour landscapes computed by
marching squares from a pure JS model (bowl f = x² + 3y²; double well
f = (x²−1)² + y² + 0.25x), draggable ball, η and momentum sliders,
step/run/reset, live readout + step table, prediction chips.

Walkthrough (verdict per beat, evidence from the artifact):

- **Beat 1 Touch:** opens on the live figure; first instruction is
  "arrastra la bola" (GUIDE line 123 region; beat 1 at GUIDE line 9).
  No definition anywhere near it. **PASS**
- **Beat 2 Predict:** forced-choice chips ("llega al fondo / oscila /
  sale disparado") + written step-count predictions, committed before
  running. **PASS**
- **Beat 3 Break:** both traps reached with shipped controls and
  photographed: η = 1.1 in the bowl drives f from 7.56 to ~3.97e15 in
  10 steps (diverged.png); the double-well run from (1.6, 0.5) settles
  in the shallower right well, f = 0.246 vs −0.254 in the deep well
  (localmin.png). Misconceptions named in the learner's terms.
  **PASS**
- **Beat 4 Name:** first formula (θ ← θ − η·∇f(θ)) appears at GUIDE
  lines 180–182 — after manipulation (l.123) and predictions (l.136);
  every symbol decoded against a knob or the dragged arrow. **PASS**
- **Beat 5 Vary:** live step table read with self-explanation prompts;
  momentum predicted then tested; symbols-first check whose correct
  option (one step from (1,1) at η = 0.1 → (0.8, 0.4)) was verified
  against the model. **PASS**
- **Beat 6 Defend:** friend question bans the word «gradiente»; trap
  and boundary questions require demonstrating in the figure;
  closed-book recall prompts route back to named beats. **PASS**
- **Beat 7 Transfer:** the same machine inside a training loop;
  spot-it reveal maps `loss.backward()` / `optimizer.step()` /
  `w -= lr * w.grad` onto the operated controls. **PASS**

Spot-checks (independent recomputation vs page readout): |∇f| at
(1,1) = 6.32 ✓; f = 9.880 and |∇f| = 9.30 at (2, 1.4) ✓; convergence
to f = 0.000 at (0,0) in 16 steps at η = 0.1 ✓. Captures: desktop
1440 and phone 390, console clean, no sideways scroll — read by the
builder and re-read at review.

**Gate Audit: 5/5 PASS** (full evidence in the pilot's NOTES.md).
Declared nuance: the readout's |∇f| label is instrument vocabulary
present from beat 1 and decoded in beat 4 — see the Step-8 refinement
in the attack summary.

Not verified: pointer drag exercised only via the same inverse mapping
the URL capture hook uses; no mid-animation frame captured. Recorded
in the pilot's NOTES.md.

## Case 1b — Positive (linear algebra, full build)

Built by applying the skill as written. Artifact:
`math-anatomy-pilots/linear-algebra/` (index.html + GUIDE.md +
NOTES.md + 5 captures). The figure: a grid-warping machine — draggable
images of î and ĵ (the matrix's columns), the unit square and its image
parallelogram, a probe vector with turn readout, six one-click
presets, a compose mode, and an eigen hunt mode.

Walkthrough:

- **Beats 1–2:** dragging the basis tips warps the whole grid before
  any notation (first notation block `M = [[a,b],[c,d]]` at GUIDE
  line 282; manipulation at l.183, committed predictions at l.201).
  Predictions are forced choices about area and flipping before the
  Corte and Rotación presets are applied. **PASS**
- **Beat 3 Break:** both traps are one-click presets, captured:
  Proyección collapses the grid onto a single line with the readout
  "EL ESPACIO COLAPSÓ" (área ×0.00); Reflexión flips orientation at
  det = −1. **PASS**
- **Beats 4–5:** the columns are named as "the photos of where î and ĵ
  landed"; composition is a real mode (M ← P·M with the chain shown),
  and non-commutativity is demonstrated, not asserted (det equal,
  entries different). Symbols-first check: predict the non-turning
  direction of [[2,1],[1,2]] from options, then verify with the probe.
  **PASS**
- **Beats 6–7:** defend questions hardened during the build (a printed
  hint that would have let one question be answered by copying was
  removed); transfer walks `y = W·x + b`, PCA, attention scores, and
  the spot-it `logits = x @ W.T`, including the trap transferred: a
  near-zero-determinant layer collapsing distinct inputs. **PASS**

Spot-checks (page readout vs independent Node recomputation):
identity det = 1, probe turn 0.0° ✓; rotation 30° det = 1.0000, turn
30.0° ✓; projection det = 0, probe (1.6, 0.9) turn 29.4° = atan(0.9/1.6)
✓; eigen matrix: probe ∥ (1,1) → turn 0.0°, λ = 3.00 ✓; second eigen
direction (1,−1) → λ = 1 ✓. Reviewer re-read the eigen and collapse
captures: λ = 3.00 and the collapsed grid read exactly as recorded.

**Gate Audit: 5/5 PASS** (evidence in the pilot's NOTES.md). Same
declared nuance as Case 1: the live 2×2 entry panel is the machine's
dial, decoded in beat 4.

Not verified: synthetic pointer-drag (states were set via presets and
a documented URL hook sharing the same state/render path); no
screen-reader pass.

## Case 2 — Negative (drill + lookup, must not fire)

Request A: "Resuélveme estos 20 ejercicios de derivadas para mi tarea de
mañana." Request B: "¿Cuál es la fórmula de la derivada de sin x?"

Walkthrough:

- **Fire-check A:** drill/homework is an explicit do-not-fire branch in
  the skill ("Drill or homework"). Correct behavior: decline in one
  line, offer a learning piece on the derivative concept instead, do
  not solve any of the 20. **PASS** — the refusal is structural (the
  branch is named in the skill), not a judgment call.
- **Fire-check B:** a quick lookup is the second named do-not-fire
  branch. Correct behavior: answer plainly (cos x) with no piece, no
  lecture, no upsell beyond at most one clause. **PASS**
- **Boundary sanity:** "Quiero entender de verdad qué es una derivada,
  siempre la aplico sin saber qué hago" *would* fire — leading intent
  (understand, intuition gap) matches the description's trigger branch.
  **PASS**

Rubric:

- Both refusals route somewhere useful (a concept piece / a plain
  answer) instead of dead-ending. **PASS**
- Neither refusal moralizes about homework. **PASS**

## Case 3 — Edge (a concept that resists manipulation: "what is a group?")

Request: "Quiero entender qué es un grupo en álgebra abstracta."

Walkthrough (architecture decisions, per the skill's failure handling):

- **Intake:** the request names a definition-shaped object from a
  proof-shaped field. The skill's rule: do not fake a figure; find the
  strongest honest entry and label it a doorway. One-sentence intuition
  goal chosen: "un grupo es un conjunto de movimientos que se pueden
  componer y deshacer" — stated to the learner *as the piece's goal*,
  not as its opening content.
- **Manipulation chosen:** the symmetries of a square (4 rotations ×
  reflection) that the learner composes by dragging — a real input→
  output machine ("what does this object *do*?" → it moves the
  square), so the figure is a genuine manipulable, not a decorated
  definition.
- **Trap:** "el orden no importa al componer" — compose rotate-then-
  flip vs flip-then-rotate and land on different squares:
  non-commutativity made visible in the learner's hands. Reachable with
  the shipped controls by construction.
- **Name (beat 4):** closure/identity/inverse/associativity are
  introduced as names of behaviors the learner already performed
  (composing two moves = closure; doing nothing = identity; undoing =
  inverse). The axioms arrive as a naming ceremony, per the Gate.
- **Honesty boundary kept:** the piece must end by stating it is a
  doorway — one concrete group, fully felt — not "group theory
  learned": representations, proofs, and abstract structure are named
  as sequels. Claiming more would violate the skill's scope rule.
- **Mid-piece probe:** if the learner asks for the formal axioms
  mid-piece, the skill gives them (the Gate governs the piece, not the
  learner's questions) and routes back to the figure. **PASS** per the
  failure-handling section.

Rubric:

- No fake manipulation was invented for an abstract concept; the entry
  is a true special case, labeled as such. **PASS**
- The piece's limits are stated inside the piece plan, not discovered
  by the learner later. **PASS**
- The trap is a real named misconception (assumed commutativity) with
  a reachable breaking state. **PASS**

## Attack summary (Crazy Thing falsification checks)

**Falsification test 1 — the Gate is mechanical, not vibes.** Both
pilots ran the 5-check Gate Audit: 5/5 on each, with line-number and
photographic evidence. The audit caught one real ambiguity during the
round: both builders independently flagged that instrument readouts
carry notation (|∇f|, the live matrix entries) from beat 1. Ruling:
a dial label is not a definition *if* beat 4 decodes it — both pieces
do. **Step-8 refinement applied to the skill:** Gate Audit check 1 in
SKILL.md now states this explicitly ("A dial is not a definition"), so
the next builder doesn't have to re-derive the ruling.

**Falsification test 2 — rubric comparison vs the no-skill baseline.**
Baseline: a plain-prompt explanation of gradient descent
(`math-anatomy-pilots/baseline-gradient-descent.md`), written and
scored *before* the pilot was seen; a good conventional explanation
(mountain analogy, formula, hand-worked example, learning-rate
warnings, applications). Scored per references/rubric.md:

| Dimension | Baseline | GD pilot | Deciding evidence |
|---|---|---|---|
| 1. Intuition-first order | 0 | 2 | Baseline opens with a definition; pilot's first formula is at GUIDE l.180, after manipulation (l.123) and predictions (l.136) |
| 2. Manipulability | 0 | 2 | Baseline is text; pilot's ball/sliders/step reach every state incl. divergence |
| 3. Misconception handling | 1 | 2 | Baseline *states* the lr/local-minima warnings; pilot makes both fail in the learner's hands, photographed |
| 4. Zero hand-drill | 1 | 2 | Baseline's central example is hand arithmetic (x = 3 − 0.1·(2·3)…); pilot's only symbolic task is choosing an interpretation |
| 5. Transfer to AI | 1 | 2 | Baseline lists the seat (weights/loss) in closing; pilot walks a training loop + spot-it (`w -= lr * w.grad`) |
| 6. Defensibility | 0 | 2 | Baseline has no check at all; pilot's Defend bans the word «gradiente» and routes recall by beat |
| **Total** | **3/12** | **12/12** | |

The linear-algebra pilot was scored on the same rubric for
consistency: 12/12 (Gate 5/5; traps captured; transfer includes the
spot-it and the determinant trap transferred to neural layers).

**Falsification result:** the baseline does not tie or win on any
dimension; the mechanism survives this round. The Definition Gate is
promoted in the ledger from *hypothesized* to **behaviorally tested +
comparatively evaluated** — with the scope qualifiers in the verdict,
which are part of the result, not fine print.

## Verdict

All acceptance checks pass for v1. Positive cases: two complete pieces
built by the skill as written, both Gate-clean, both numerically
spot-checked against independent recomputation, both working at
desktop and 390 px. Negative case: drill and lookup requests are
refused by named branches, with a useful route offered. Edge case: an
abstract-algebra concept gets an honest doorway piece, limits stated,
no fake manipulation.

The comparison is a clear win on the skill's own rubric (12/12 vs
3/12). **Limitations, stated plainly:** the rubric was scored by the
skill's author (mitigated, not eliminated, by writing and scoring the
baseline first and anchoring every point to a quotable artifact); the
comparison covers one concept head-to-head (the second pilot was
scored but had no baseline twin); the pilots were built by agents
following the skill, not by a naive builder seeing it cold; and no
actual learner has yet learned from a piece — learning outcomes in
real heads remain the open empirical question, exactly as the
evidence reference says. The Crazy Thing's claim stays scoped to what
was shown: pieces produced under the Gate are structurally and
rubric-measurably different from definition-first explanations, in
the direction the learning-science evidence predicts.
