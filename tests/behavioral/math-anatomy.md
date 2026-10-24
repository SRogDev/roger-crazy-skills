# Behavioral self-test: math-anatomy v1

Date: 2026-10-23. Method: build two real pieces by applying the skill as
written (gradient descent; linear algebra — a matrix as a machine),
walk a negative case and an edge case against the skill's fire/decline
rules, then run the Crazy Thing's falsification protocol: score a
no-skill baseline and the gradient-descent pilot on the skill's own
rubric (references/rubric.md) and compare. Verdict per criterion.

## Case 1 — Positive (gradient descent, full build)

<!-- COMPLETED AFTER PILOT RETURN: walkthrough, Gate Audit, captures. -->

## Case 1b — Positive (linear algebra, full build)

<!-- COMPLETED AFTER PILOT RETURN: walkthrough, Gate Audit, captures. -->

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

<!-- COMPLETED AFTER SCORING: Gate Audit on both pilots, rubric
comparison baseline vs pilot, falsification verdict. -->

## Verdict

<!-- COMPLETED AFTER SCORING. -->
