# Architecture of a piece — the seven beats in depth

A piece is a controlled sequence of experiences, not a document with a
figure attached. The beats have a fixed order because the learning
mechanisms they exploit are order-sensitive: a prediction only primes
learning if it is committed *before* the reveal; formalism only anchors
if the experience it names is already in the learner's hands.

## Beat 1 — Touch

Open on the live figure. The first screen contains: the figure, one
sentence of orientation ("this is a landscape; the ball wants the
bottom"), and one instruction that makes the learner change something.
Nothing else. In particular, none of these may appear yet: a definition,
a formula, notation, a history of the concept, a list of applications.

Design the first manipulation to be *un-losable*: any drag, any knob
turn, produces a visible, interpretable change within a second. The
learner's first experience of the concept must be "I did that".

## Beat 2 — Predict

Before each significant reveal, stop and ask. A prediction prompt has
three properties:

- **Committed.** The learner states it — writes it, picks it, or at
  minimum the path makes them pause on a specific forced choice
  ("left well or right well?") with the outcome hidden behind an action
  they take only after choosing.
- **Specific.** "What happens?" is not a prediction. "Will the ball
  reach the bottom in fewer than 10 steps, or oscillate?" is.
- **Cheap to be wrong.** Say explicitly, once, early: wrong predictions
  are the mechanism, not a failure. (Pretesting research: even wrong
  committed guesses improve later retention.)

Budget: 2–4 predictions per piece, placed at the moments of highest
information — just before a reveal that would otherwise wash past.

## Beat 3 — Break

Every concept has states where the obvious mental model produces a
visibly wrong result. Find them and build the trap deliberately:

1. Name the misconception in the path, in the learner's terms ("most
   people expect the steps to keep shrinking…").
2. Give the exact figure state that triggers it (rate = 1.1; the
   projection preset; x = exactly on the ridge).
3. Let it fail *visibly* — divergence, collapse, a flip — then one or
   two sentences on what the failure reveals about the real concept.
   The failure is the lesson; do not soften it with warnings beforehand.

One trap is mandatory; two or three is the working range. A trap the
learner cannot reach with the shipped controls does not exist (Gate
Audit, check 2).

## Beat 4 — Name

Introduce the formalism as a naming ceremony, term by term, each one
pointed at the figure:

- "The arrow that pointed downhill, the one you followed — its name is
  the **gradient** (gradient), written ∇f. It is not a new object; it is
  the name of the thing you have been dragging into existence."
- Decode every symbol in the headline formula this way. A symbol that
  cannot be pointed at gets a sentence explaining what it *does* in the
  machine ("η, the (learning rate), is the knob on the right").

Formal definitions appear in their standard form — the piece teaches
recognition of the real notation, it does not invent a private one.

## Beat 5 — Vary

Two motions in this beat:

**Across examples.** One worked example, walked slowly, narrated by the
model's actual numbers, with self-explanation prompts at the decision
points ("the step just got smaller — why? what shrank?"). The learner
interprets; the model computes. Then a second example in a different
regime (the other landscape, a non-symmetric matrix), faster.

**Across representations, with fading.** Present the same fact in the
four linked forms — picture, numbers, symbols, code — adjacent to each
other. Then fade: the last variation shows the symbolic form *first*
and asks the learner to predict the picture, the numbers, the code's
output. That inversion is the completion test for the beat: reading
notation fluently means seeing the machine when you see the symbols.

## Beat 6 — Defend

Three questions, engineered so that quoting the piece cannot answer
them:

- **The friend test:** "Explain to a smart friend, in plain words, why
  ___." (the concept's central behavior)
- **The trap test:** "Your friend says [the named misconception]. What
  do you show them, in the figure, to change their mind?"
- **The boundary test:** "Give a case where ___ fails or misleads, and
  say what goes wrong."

Plus recall prompts, answered closed-book before checking: the
one-sentence intuition; what the trap was; what each symbol in the
formula names. Wrong or fuzzy answers route the learner back to the
specific beat — name the beat in the routing line.

## Beat 7 — Transfer

Show the concept inside one real AI system, concretely: not "used in
machine learning" but "in this training loop, *this line* is the
gradient step; the knob you broke is the one that makes real training
runs diverge at 3 a.m." Close with a spotting prompt: a short excerpt
(code, a formula from a paper, a config) where the learner must find
the concept and say what their intuition now tells them about it.

## Choosing the manipulation — pattern table

| Concept family | The machine | The knobs | Signature trap |
|---|---|---|---|
| Optimization (gradient descent, momentum) | A ball on a landscape | Start point, step size, momentum | Step too large → oscillation/divergence |
| Linear maps (matrices, eigenvectors) | A machine that warps the grid | The two basis images (columns) | det = 0 collapses space; det < 0 flips it; most vectors turn, eigenvectors don't |
| Derivatives / rates | A curve with a walking tangent | The point, the zoom level | Secant vs tangent: the average lies about the instant |
| Probability (Bayes, distributions) | A population of dots re-sorted by evidence | Base rate, test accuracy | Ignoring the base rate makes a "99% accurate" test mostly wrong |
| Accumulation (integrals) | Area accumulating under a curve | Slice width, the curve | Finer slices converge — the limit is a value, not a process that finishes |
| Information (entropy, cross-entropy) | A code/guessing game | The distribution | The uniform distribution is the *most* surprising, not the least |
| Fourier / signals | Spinning vectors (epicycles) summed | Which frequencies are on | A square wave is round vectors in disguise; removing highs rounds corners |

If a concept fits no row, design its machine from the concept's own
definition: ask "what does this object *do* to an input?" and make that
doing draggable.

## Misconception traps — how to find them

Reliable sources, in order: (1) the concept's standard "common errors"
in teaching literature; (2) the gap between the everyday meaning of the
concept's name and its math meaning ("imaginary", "significant",
"regression"); (3) the property learners over-generalize from the first
example (all matrices rotate a bit; gradients point at the minimum —
they point *downhill*, not at the target). State the trap from the
learner's side: the wrong sentence a reasonable person would say.

## Language and register

- The path is written in the learner's language, fully — not translated
  fragments. Math terms of art stay in English in parentheses at first
  use, then either language may carry them.
- Plain words first, formal words as names (Beat 4), never the reverse.
- Short sentences. The learner should never need to re-read a sentence
  to parse it; if they re-read, it should be to *think*.
- Respect the intelligence in the room: no "imagine a cute robot…"
  framing for adults. Directness is the respect.

## Length and scope budget

- One concept, one figure, 25–40 minutes of contact.
- If intake reveals two concepts fused in the learner's mind (gradient
  vs derivative), split: piece 1 is the derivative-as-slope machine if
  that is the true gap; say which gap you chose and why.
