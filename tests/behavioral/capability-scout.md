# Behavioral self-test: capability-scout v1

Date: 2026-10-13. Method: walk the skill's own procedure on one positive, one
negative, and three edge cases. Each case is scored against its acceptance
rubric. All walkthroughs are desk-based (the skill was followed step by step
as an agent would); no live agent runs were executed.

Environment assumed for the walks: a coding agent with file/shell access, a
set of installed skills (including `gmail`, connected), a scheduling tool, and
a fetch tool. No scraping skill installed.

## Case 1 — Positive (self-trigger: scheduled web scraping)

Request: "I need scheduled web scraping — check a competitor's price page daily
and alert me on changes."

Walkthrough:

- **Trigger:** no explicit discovery request, but all three self-trigger
  conditions hold: (1) goal is clear enough to decompose; (2) no reliable
  implementation path is known; (3) writing a scraper from scratch looks
  premature — the canonical "about to build" signal. FIRES. PASS
- **Step 1 (decompose):** R1 fetch page daily at a fixed time; R2 extract named
  price fields; R3 diff against the previous run; R4 notify on change;
  constraint: polite rate, no CAPTCHA-solving hacks; budget: near-zero cost.
  Done — each requirement is testable. PASS
- **Step 2 (sweep, in order):** (1) installed skills/tools — no scraping skill;
  fetch tool and scheduling tool confirmed present via their actual tool
  listings; (2) project — nothing relevant (grep for "scrap" finds nothing);
  (3–7) libraries (HTML parsers, schedulers), managed scraping APIs, polite-
  crawling techniques. Done — every category checked or skipped with a reason.
  PASS
- **Step 3 (evaluate):** candidates A) fetch tool + scheduler + small diff
  script; B) managed scraping API; C) full scraping framework. Rubric applied:
  A fits all four requirements, ~1h integration effort, free; B adds account
  setup + per-call cost for no needed gain; C is overkill for one page. PASS
- **Step 4 (evidence levels):** A is TESTED for R1/R4 (tools observed in this
  environment); A's R2 parsing is DOCUMENTED until the PoC. Labels applied,
  not blurred. PASS
- **Step 5 (PoC):** one read-only fetch of the target page, inspect HTML
  structure — converts R2 from DOCUMENTED to TESTED at near-zero cost. PASS
- **Step 6 (report):** recommends A with trade-offs (fragile to page redesigns;
  B more robust if the page turns out JS-heavy) and an integration plan.
  Includes honest uncertainty (page structure verified once, may drift). PASS
- **Step 7 (stopping):** A meets all hard filters and must-haves with evidence
  after the first sweep + PoC → stop. No endless rounds. PASS

Rubric: fires on self-trigger ✓ · environment swept before web ✓ ·
recommends existing composition instead of a from-scratch scraper ✓ ·
trade-offs stated ✓ · stopping rule terminates the search ✓.
**Verdict: PASS.**

## Case 2 — Negative (implementation already decided)

Request: "We've decided on Postgres + Prisma. Implement the order schema now."

Walkthrough:

- **Trigger check:** matches a negative trigger verbatim — implementation
  chosen, "implement it" instruction. Skill must NOT fire; the agent proceeds
  to implement the schema with the decided stack. No sweep, no report. PASS

Rubric: no discovery sweep fired ✓ · no recommendation report produced ✓ ·
the decided stack is not second-guessed ✓.
**Verdict: PASS.**

## Case 3a — Edge: best answer is an existing installed skill

Request: "I need a weekly summary of my Gmail inbox."

Walkthrough:

- **Trigger:** self-trigger conditions hold → FIRES.
- **Step 2, category 1:** the installed `gmail` skill is found; its SKILL.md is
  read and confirms search + read + label capabilities covering R1–R3. No
  external category needs searching.
- **Step 4/5:** a read-only probe (list recent labels / one search) converts
  the fit claim to TESTED.
- **Step 6:** recommends invoking the installed skill weekly via the existing
  scheduler; trade-offs minimal; integration plan = one scheduled prompt.
- **Step 7:** stops after category 1 — the sweep found a fit before any web
  search.

Rubric: environment-first order observed ✓ · zero external searching performed
✓ · recommendation names the installed skill with evidence ✓ ·
documented-vs-tested honored ✓.
**Verdict: PASS.**
Attack note: an unstructured "search the web for email summarizers" agent
would likely have recommended a third-party SaaS — the environment-first sweep
changed the outcome. This case, not Case 1, is the evidence that carries the
Unknown-Unknown Search.

## Case 3b — Edge: best answer is a combination

Request: "Watch a directory and ping me in chat when new files arrive."

Walkthrough:

- **Trigger:** FIRES (clear goal, no known path, building a daemon premature).
- **Step 2:** category 1 finds a scheduling tool but no directory-watcher;
  category 6 finds the OS's native file-watch CLI; the agent's own chat is the
  notification channel. Neither alone suffices.
- **Step 3:** combination evaluated as a first-class option (per the skill's
  combination rule): watch CLI + existing scheduler/poll loop + chat ping.
  Combined effort smaller than a bespoke daemon; failure surface understood.
- **Step 6:** recommends the combination with the wiring steps; trade-offs
  (polling interval vs. event latency) stated.

Rubric: combination treated as a real option, not a fallback ✓ · no invented
watcher tool — the CLI's existence verified via its help text ✓ · trade-offs
stated ✓.
**Verdict: PASS.**

## Case 3c — Edge: nothing good exists (honest build recommendation)

Request: "I need a CRDT-based real-time collaborative editor embedded in my
product, offline-first, with data residency in the EU."

Walkthrough:

- **Trigger:** FIRES.
- **Step 2:** full sweep. Candidates found: open-source CRDT libraries
  (integration effort measured in weeks, maintenance risk on key ones),
  hosted collaboration SaaS (violates the EU data-residency hard filter —
  rejected, not ranked low).
- **Step 7:** two search rounds in new sources add no new serious candidates
  → STOP, per the stopping rule's second condition.
- **Step 6:** says plainly that no existing capability clears the bar;
  recommends building, and hands the Step 1 requirements decomposition over as
  the build brief. No tool is invented; no "there's a library for that"
  fabrication.

Rubric: "nothing fits" stated explicitly ✓ · hard filter applied as a
rejection, not a ranking penalty ✓ · zero invented tools or integrations ✓ ·
build recommendation grounded in the decomposed requirements ✓.
**Verdict: PASS.**

## Attack findings

1. **No invented tools.** Every case obeyed the skill's verification demand:
   candidates were checked against actual tool listings, SKILL.md contents, or
   official docs. The safety boundary ("names are not capabilities") held under
   pressure in 3c, where inventing a library would have been the easy way out.
2. **Documented-vs-tested applied.** Cases 1 and 3a carried explicit labels;
   the PoC step demonstrably converts one claim from DOCUMENTED to TESTED.
3. **Stopping rule terminates.** Fired on first-round success (1, 3a, 3b) and
   on the two-empty-rounds condition (3c). Known weakness: round-counting is
   self-reported by the agent — an agent gaming its own count could still
   wander. Accepted for v1; the rule at least makes the wander explicit.
4. **Crazy Thing falsification attempt.** Case 1 alone does NOT prove the
   environment-first sweep adds value: a plain web search could have reached
   the same recommendation (scraping APIs + cron are web-discoverable). Case
   3a DOES: the installed skill is invisible to web search, and the sweep
   found it. Mechanism status stays **hypothesized** — supported by 3a's logic,
   not yet comparatively evaluated.
5. **Over-firing risk.** The self-trigger's condition 2 ("no reliable
   implementation path known") blocks trivial goals — "reverse this string" or
   "sort this list" never reach the sweep because the path is obvious. The
   three-condition gate is doing real work, not decoration.

## Verdict

All five cases pass their rubrics. The skill fires where it should, stays
silent where it must not, handles the installed-skill, combination, and
nothing-exists edges honestly, and its stopping rule terminates the search.
Limitation: these are desk walkthroughs, not live agent runs, and the
comparative claim (scout beats an unskilled agent) is untested — the Crazy
Thing ships as a hypothesis with its falsification test written down.
