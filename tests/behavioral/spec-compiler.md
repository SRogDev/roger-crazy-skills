# Behavioral self-test: spec-compiler v1

Date: 2026-10-13. Method: walk the skill's own six passes on a positive case,
a negative case, and a UI/visual edge case, then run the attack checks the
Crazy Thing demands (no dropped constraints, no merged labels). Verdict per
acceptance criterion.

## Case 1 — Positive (rambling feature notes)

Input notes:

> ok so i want to add reminders to my todo app. like, you set a due date on a
> task and the app reminds you. should probably send a notification the morning
> of? hmm, or maybe the evening before, not sure which is better. oh and
> CRITICAL: it must work offline, lots of our users are on spotty connections
> in rural areas, if the reminder only fires when online it's useless. also
> maybe a snooze button? users probably want to snooze. don't make it
> complicated though, keep it simple, one screen max. i think the reminder time
> should default to 9am. actually wait — better if it learns when the user
> usually opens the app and reminds them then? that sounds smarter. anyway.

Walkthrough:

- **Pass 1 (capture):** 8 fragments numbered S1–S8 in order; nothing marked
  `[noise]` — every fragment carries at least one commitment. PASS
- **Pass 2 (extract):** due-date → reminder (S1–S2); timing conflict morning-of
  vs evening-before (S3); offline mandate (S4); snooze (S5); one-screen
  simplicity (S6); 9am default vs learned timing (S7 vs S8). PASS
- **Passes 3–5 (compress, label, trace):** produced spec excerpt —
  - `[MUST]` A task with a due date fires a reminder. [S1–S2]
  - `[MUST]` Reminders work fully offline; nothing at fire time may depend on
    the network. [S4]
  - `[MUST]` Reminder UI is a single screen; keep it simple. [S6]
  - `[ASSUMES]` Users want a snooze button. [S5] — flagged for confirmation.
  - `[OPEN]` Reminder lead time: morning-of vs evening-before? Blocks:
    notification scheduling. [S3]
  - `[OPEN]` Default time: fixed 9am vs learned from app-open patterns?
    Blocks: whether any usage tracking is needed. [S7–S8]
  - Acceptance: `[ ]` Reminder fires with the device in airplane mode. [S4]
- **Pass 6 (loss check):** re-walked S1..S8 — the offline mandate, buried
  mid-ramble after an "oh and", survived as MUST; nothing dropped. PASS

Rubric:

- Buried critical constraint preserved with correct label and trace. **PASS**
- "users probably want to snooze" labeled ASSUMES, never MUST. **PASS**
- Both contradictions surfaced as OPEN with both sides cited; neither silently
  resolved. **PASS**
- Every statement carries exactly one label; every trace tag resolves. **PASS**
- Implementability: a second agent could build this without re-asking anything
  except the two OPEN questions (which name what they block) and the snooze
  confirmation. No avoidable ambiguity remains. **PASS**

## Case 2 — Negative (execution request, must not fire)

Request: "build the login page for my app, with email and Google sign-in."

Walkthrough:

- Fire-check: "build" = execution, not spec. The skill must not fire and must
  not start coding. Correct behavior: one sentence offering to compile the
  spec first ("I can turn that into a build-ready spec first — want me to?"),
  then stop. **PASS** — no code, no file scaffold, no partial implementation.
- Sanity check on the boundary: "turn this idea into a spec: login page with
  email and Google sign-in" *would* fire (leading trigger phrase present).
  **PASS**

## Case 3 — Edge (landing page: UI/visual work, delegated decisions)

Input notes:

> landing page for my invoicing app, aimed at freelancers. should feel calm and
> trustworthy, not startup-hypey. hero with the value prop, then how it works
> in 3 steps, then pricing. i like linear's aesthetic — clean, dark,
> restrained. no idea about colors, you pick something sensible. the main CTA
> is start free trial. oh, needs to load fast on bad connections.

Walkthrough (UI checklist from the skill):

- Purpose: convert visitors to free trials. Audience: freelancers. Desired
  experience: calm, trustworthy (2 adjectives, grounded in audience). Visual
  hierarchy: value prop → how-it-works (3 steps) → pricing → CTA. Visual
  direction: Linear-like, clean/dark/restrained; startup-hype explicitly out.
  Aesthetic constraints: palette captured as
  `[ASSUMES — user-delegated]` "restrained dark neutrals in Linear's spirit
  (proposed; user delegated the choice, confirm)" — delegation handled as a
  labeled assumption, not invented certainty and not an unanswerable OPEN.
  Expected interactions: scroll narrative, CTA → trial signup; loading state
  covered by the performance point. **PASS**
- Vague-word rule: "load fast on bad connections" did not survive as
  decoration — became `[ ]` "page interactive in ≤ 3 s on throttled slow-3G
  `[ASSUMES` — concrete reading of 'fast'; confirm`]". **PASS**
- Hard rule: the produced spec contains zero framework/CSS/component trivia —
  no "use Tailwind", no flexbox/grid, no component names. Experience specced,
  not the stylesheet. **PASS**

## Attack summary (Crazy Thing falsification checks)

- **Compression preserves critical constraints:** Case 1's offline mandate
  (buried mid-ramble) and Case 3's performance note (trailing "oh, …")
  both survived compression as labeled, traceable statements. Loss-check
  re-walks found zero dropped commitments across S1..S8 (case 1) and all
  fragments (case 3). **PASS**
- **Four labels never merged or confused:** audited every produced statement —
  each carries exactly one label; ASSUMES items (snooze, delegated palette,
  3G budget) were never dressed as MUST; MUST items all trace to explicit
  source wording; contradictions became OPEN with both sides cited rather
  than silently picked. **PASS**
- **Falsification result:** no dropped constraint, no merged label found. The
  "without loss" mechanism survives this round — it is not a gimmick on the
  evidence walked. Comparative advantage over speccing without the skill was
  not evaluated and remains a hypothesis.

## Verdict

All acceptance checks pass for v1: positive case compresses rambling notes
into a tight, fully traceable, singly-labeled spec; the negative case refuses
execution and offers to spec first; the UI edge case captures experience and
hierarchy without implementation trivia and handles delegated decisions
honestly. Limitation: the walkthroughs are self-administered, not run against
a second agent, and no comparison against an unskilled baseline was performed
— the advantage claim stays labeled as a hypothesis per the honesty ledger.
