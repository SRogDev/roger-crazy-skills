# The figure — building the manipulable

The figure is the piece's laboratory bench: the place where the concept
is a machine the learner operates. It borrows the Anatomy skill's
bench-instrument aesthetic and verification ethos, at pilot scale: one
figure, one concept, one page.

## Look and frame

- A framed card: `Fig n` top left, the concept's name as title top
  right, the interaction hint bottom left, a **live readout** bottom
  right (the numbers that matter, computed now).
- Restrained instrument styling: mono type for numbers, thin rules,
  four-tone shading if drawn objects are present, exactly one lit
  accent — the part the learner should watch (the ball, the basis
  vector, the probe).
- Words stay out of the drawing itself; labels live in the readout, the
  guided path, and small readouts inside the card frame.
- Dark theme is the default deliverable; a light theme is welcome but
  never at the cost of the dark one being verified.

## The pure model rule

Every number the page shows — positions, readouts, outcomes, the path
narrative's figures — comes from **one small pure model** (a function of
state in, numbers out; ideally a separate `<script>` block or module
section the builder can point to). Hard-coded display values are a
defect: if the learner drags a knob into an unscripted corner, the
readout must still be true. This is what makes the Break beat possible:
the trap state behaves as the real concept behaves, because it *is*
the real concept, computed.

## The knobs

- Expose the concept's 1–3 *true* parameters as direct manipulations:
  drag the object itself first (start point, basis vector, probe),
  sliders second (learning rate, slice width), presets as buttons that
  set interesting states (the trap state must be one obvious click or
  one described slider position away).
- Every control must answer within a frame; manipulation that lags
  teaches nothing.
- Include a **step** affordance wherever the concept is iterative:
  one step at a time, learner-paced, before any "run" animation.
  Watching an animation is not manipulation; stepping is.
- A reset that returns to the canonical starting state, always
  reachable.

## Prediction support

Where feasible, the figure itself enforces Beat 2: a "predict first"
gate — e.g., the outcome region starts hidden or the run button arms
only after the learner picks a prediction chip ("llega al fondo /
oscila / explota"). If a gate would fight the manipulation, put the
gate in the guided path's flow instead (a reveal element the learner
opens only after committing) — but never place a reveal where it can
be seen before the commitment.

## Scope discipline

Pilot-sized: one strong manipulable per concept. Resist second figures,
extra panels, and decorative instruments. The figure is done when the
beats' manipulations all work — not when the bench looks busy. A
figure build should be a focused single-file effort (inline SVG or
canvas + vanilla JS is the default stack; no framework, no external
assets, no network calls).

## Verification — like a critic, at pilot scale

Non-negotiable before delivery:

1. **Captures read with your own eyes:** desktop width and 390 px
   phone width, at rest and in the trap state and mid-manipulation.
   Use headless Chrome (the Anatomy skill's `capture.mjs` prints
   console errors and sideways-scroll status; any equivalent tool is
   fine).
2. **Console clean** on every capture; **no sideways scroll** at
   390 px.
3. **Model spot-check:** set the figure to two states whose correct
   readouts you can compute independently (a symmetric bowl's minimum;
   the identity matrix's determinant) and confirm the page agrees.
4. **Still test:** with motion off (or a screenshot), the figure still
   communicates its starting state and its one big idea.
5. Reduced-motion: animations resolve to a still, usable figure;
   stepping controls still work.

Record the captures and the spot-checks in the piece's notes or the
delivery report. "It rendered" is not verification; *read* the PNGs.

## Failure modes seen in practice

- **A diagram wearing sliders.** If moving the knob doesn't change the
  concept's behavior — only the picture's decoration — there is no
  machine. Rebuild around the concept's actual input→output mapping.
- **Animation as explanation.** A play button the learner watches is a
  video with extra steps. Every animation needs a learner-paced step
  mode and a drag that puts the state in their hand.
- **Readout theater.** Numbers nobody can check, or numbers hard-coded
  for the scripted path. Violates the pure model rule.
- **The trap that isn't.** A "failure state" the path describes but the
  controls can't reach (slider caps below the divergence point). Gate
  Audit check 2 exists because of this.
