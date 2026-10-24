---
name: math-anatomy
description: "Turn a math concept into an intuition-first learning piece — one manipulable interactive figure plus a guided path — built for understanding instead of hand computation (Math 2.0). Use when someone wants to learn, understand, or get a real intuitive grasp of a math concept (linear algebra, gradient descent, eigenvalues, derivatives, probability, Fourier, entropy), especially self-taught builders and AI learners. Not for homework, problem sets, exam drills, or quick formula lookups."
---

# math-anatomy

Take a math concept apart the way the Anatomy figures take apart a machine:
the learner first **moves** the concept with their hands, breaks it on
purpose, and only then learns its formal name. The output is a *learning
piece*: one interactive figure plus a guided path that walks the learner
through it.

**The doctrine — Math 2.0.** Nobody here is training to compute by hand;
software computes. What a human must own is intuition: what the concept
*does*, when it fails, what its moving parts mean. Every design decision in
this skill serves that. A piece that ends with the learner able to execute
a procedure by hand but unable to say what the concept does has failed,
however correct its math is.

**The audience.** Smart adults who are not math specialists — builders,
programmers, people heading toward serious AI work who feel the gap when a
concept shows up inside a system they use. Assume intelligence, assume no
fluency: every symbol gets decoded against something the learner has
already touched. Never condescend, never hand-wave. The standard for
success is the learner's own verdict: *I could explain this to a smart
friend and defend it under questions.*

## The Crazy Thing

**The Definition Gate.** A math-anatomy piece is seven beats in a fixed
order — Touch, Predict, Break, Name, Vary, Defend, Transfer — and the
formal definition or formula is structurally forbidden until beat 4
(Name). The formalism must land on an experience the learner already had,
never on a blank mind. This is enforced, not hoped for: before delivery
the producing agent runs the Gate Audit (see Verification) — mechanical
checks on the artifact itself. A piece that fails the audit is rebuilt,
not shipped.

```markdown
## Crazy Thing Card
- **Mechanism:** The Definition Gate: a fixed seven-beat order
  (Touch → Predict → Break → Name → Vary → Defend → Transfer) with a
  mechanical pre-delivery audit. No definition, formula, or formal
  notation may appear before beat 4; every piece must contain a reachable
  break-it trap and a defend-it check that cannot be passed by quoting.
- **Expected advantage:** Manipulation-first ordering (productive failure)
  plus committed predictions (pretesting effect) produce conceptual
  understanding and transfer that definition-first explanations
  measurably under-deliver — scored on the rubric in
  references/rubric.md against a no-skill baseline.
- **Validation test:** Behavioral comparison: same agent, same concept
  (gradient descent), with and without the skill, scored on the
  six-dimension rubric; plus the Gate Audit passing on every piece.
- **Falsification:** The baseline scores equal or better on the rubric,
  or a piece passes the Gate Audit yet a fresh reader still cannot
  explain the concept back in plain words. Either result kills the
  mechanism as decoration.
- **Status:** hypothesized (see tests/behavioral/math-anatomy.md for the
  current ledger)
```

## When this fires — and when it must not

Fire when the request is to **understand**: "explain X so I really get
it", "I want to learn linear algebra", "what *is* a gradient, intuitively",
"help me build intuition for probability". The concept may be named
directly or implied by a goal ("I keep hitting eigenvectors in papers").

Do **not** fire — decline in one line and offer the right route — when the
request is:

- **Drill or homework:** "solve these 20 integrals", "do my problem set".
  Hand execution is the opposite of this skill's purpose. Offer a piece
  on the underlying concept instead.
- **A quick lookup:** "what's the formula for the derivative of sin x?"
  Answer it plainly; no piece is needed.
- **Exam cramming with a deadline:** intuition pieces take ~30 minutes of
  honest contact. Say so; offer the piece for after, not a fake shortcut.

If the concept is too large for one piece ("linear algebra"), do not
compress it into mush: propose the load-bearing sub-concepts as a short
series (a matrix as a machine → determinant → eigenvectors → SVD), build
the first piece, and name the rest as sequels.

## The product

One piece = one concept = two artifacts, delivered together:

1. **The figure** — a single self-contained interactive HTML file in the
   Anatomy bench-instrument aesthetic (framed card, title, hint, live
   readout; every number computed by one pure model, never hard-coded).
   Pilot-sized: one strong manipulable, not an epic. Must work at desktop
   width and at 390 px, console clean, and still read as a still image.
   Build guidance: [the figure guide](references/figure-guide.md).
2. **The guided path** — the seven beats as a short written walkthrough
   (inside the page and/or an accompanying markdown file) that sends the
   learner to the figure with something to *do* at each beat. Written
   entirely in the learner's language; standard math terms stay in
   English in parentheses on first use — (eigenvector), (learning rate) —
   because that is the vocabulary of the field they are entering.

Calibrate length: a piece is 25–40 minutes of honest contact. Shorter is
usually shallower, not kinder.

## The seven beats

Full design detail: [the architecture](references/architecture.md). Each
beat has a completion test; a beat you cannot test is a beat you skipped.

1. **Touch.** The piece opens on the figure, live. The learner's first
   act is a manipulation with an visible effect (drag the start point;
   pull a basis vector). No definition, no formula, no "X is defined as…"
   anywhere in this beat. *Done when:* the learner has changed the
   concept's state with their own hand at least twice.
2. **Predict.** Before each reveal, the learner commits to a prediction
   ("where will the ball stop?", "will this matrix flip the square?").
   Wrong is welcome — a committed wrong prediction is the fuel. *Done
   when:* at least two predictions are explicitly committed before their
   outcomes are shown.
3. **Break.** A designed trap state, reachable in the figure, where naive
   intuition visibly fails (learning rate too large → divergence;
   determinant zero → space collapses to a line). Name the misconception
   it kills. *Done when:* the learner can reach the failure, see it, and
   the path says what wrong idea it buries.
4. **Name.** Only now: the formal definition and notation, introduced as
   *the name of what the learner just did and felt*. Every symbol is
   decoded against the figure ("this arrow you dragged *is* the gradient;
   ∇f is just its name"). *Done when:* each symbol in the headline formula
   points at something the learner has manipulated.
5. **Vary.** Concrete → abstract fading. A worked example walked with
   self-explanation prompts ("why did the step shrink here?"), then the
   same idea across linked representations — visual ↔ numeric ↔ symbolic
   ↔ code — with figure support progressively removed until the learner
   reads the bare symbolic form fluently. *Done when:* the final example
   is presented symbolically first and the learner is asked to predict
   the picture before seeing it.
6. **Defend.** The Feynman check. Three questions that cannot be answered
   by quoting the piece ("explain to a smart friend why a big learning
   rate explodes, without the word 'gradient'"), plus closed-book recall
   prompts: the one-sentence intuition, the trap, what the formula's
   pieces mean. *Done when:* the questions exist, are specific to this
   concept's traps, and would expose memorized-but-not-understood
   answers.
7. **Transfer.** The concept at work inside a real AI system — gradient
   descent inside a training loop, linear maps as the layers of a neural
   network, eigen-structure inside PCA. End with one "spot it in the
   wild" prompt the learner can use the next time the concept appears in
   code or a paper. *Done when:* the transfer names a concrete system,
   the exact place the concept sits inside it, and what the intuition
   buys there.

## Procedure

1. **Intake.** Fix: the concept (or the sub-concept, if the ask was a
   whole field), the learner's language, and what they will meet the
   concept inside (their AI context). State the piece's one-sentence
   intuition goal: "after this, the learner can say: a matrix is ___".
2. **Choose the manipulation.** The concept must become a machine with
   1–3 true knobs. Pick from the pattern table in
   [the architecture](references/architecture.md); if no honest
   manipulation exists, see Failure handling — never fake one with a
   static diagram wearing sliders.
3. **Write the traps first.** List the 1–3 named misconceptions this
   concept reliably produces and the figure state that breaks each. If
   you cannot name a misconception, you do not understand the teaching
   problem yet — research before building.
4. **Build the figure from a pure model.** One small model computes every
   number the page shows (positions, readouts, outcomes). Verify it like
   an Anatomy figure: captures at desktop and 390 px, console clean,
   every screenshot read. See [the figure guide](references/figure-guide.md).
5. **Write the guided path** in beat order, in the learner's language.
   Predictions before reveals; every beat's instruction is an action
   ("drag…", "set the rate to…", "now check:") — never "notice that…"
   about something the learner hasn't done.
6. **Run the Gate Audit and score the piece** with
   [the rubric](references/rubric.md). Any failed gate or rubric zero
   sends the piece back, not out.
7. **Deliver** the figure + path together, with one line telling the
   learner what they will be able to say at the end — and the sequel
   concepts, if this was one of a series.

## Steering

- **Symbols are the machine's output, not the lesson.** Show notation as
  "what the software computes for you": the learner must read it fluently
  and never perform it by hand under time pressure. Worked examples show
  numbers the *model* produced; the learner interprets, never calculates.
- **One representation is a rumor; two linked ones are understanding.**
  Whenever the path states something symbolically, the figure or a
  numeric trace must show the same fact in another form, adjacently.
- **Protect the wrong prediction.** Never reveal an outcome on the same
  screen region, scroll step, or click that asks the question. A reveal
  the learner can peek at before committing destroys the pretesting
  effect the piece is built on.
- **Difficulty is a dial, not a cliff.** Start at the state where the
  concept behaves most simply (a symmetric bowl before a ravine; the
  identity matrix before a shear). Complexity arrives as a knob the
  learner turns, each turn announced.
- **When torn between completeness and the one big idea, choose the one
  big idea.** A piece that leaves the learner with one concept they can
  defend beats a tour of five they can only repeat.

## Verification — the Gate Audit

Run all five against the finished artifacts; record results in the
delivery note:

1. **Order:** the first definition/formula/notation block appears after
   at least one manipulation instruction and one committed prediction.
2. **Reachability:** every named trap corresponds to a figure state the
   learner can actually reach with the shipped controls.
3. **Zero drill:** no instruction asks the learner to compute anything by
   hand (reading a model-produced number aloud is fine; deriving one is
   not).
4. **Defend integrity:** the Defend questions cannot be answered by
   copying any single sentence from the piece.
5. **Truth:** every number in the path and readout traces to the figure's
   model; every claim about the concept is standard, checkable math.

Then score the piece on [the rubric](references/rubric.md): six
dimensions, 0–2 each. Ship at ≥ 9/12 with no zero.

## Failure handling

- **The concept resists manipulation** (purely proof-shaped or extremely
  abstract): say so plainly, and offer the strongest honest entry that
  exists — usually a concrete special case the learner *can* move (a
  group as the symmetries of a square they compose by hand) — labeled as
  a doorway, not the whole house. If even that is fake, decline to build
  the piece rather than ship a decorated definition.
- **No HTML environment available:** produce the guided path with a
  precise figure specification a builder could implement, and label the
  piece *unbuilt figure — path only*. Never describe interactions the
  learner cannot actually perform.
- **The learner asks for the formula mid-piece:** give it — the Gate
  governs what the *piece* does, not what the learner may ask. Then
  route back: "now that you've seen the name, go back and watch it
  happen."

## What this skill will not do

- It will not open with a definition, ever, in any piece it produces.
- It will not assign hand computation, drills, or problem sets.
- It will not claim learning outcomes the rubric comparison hasn't
  supported; the Crazy Thing stays a labeled hypothesis until the
  evidence in the test docs says otherwise.
- It will not shrink a whole field into one piece and call it learned.
