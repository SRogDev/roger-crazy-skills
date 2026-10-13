# Inversion checklist

Use with Phase 2 of `boundary-breaker`. For each boundary type present in the
system, apply the inversion prompts. Treat every line as a question, not a
claim — a "yes" becomes a tiered finding, a "no" needs evidence, an "unknown"
stays UNTESTED.

## Network edge (internet → your system)

- If the TLS terminator (CDN, load balancer, edge proxy) is compromised, what
  attacker-controlled values reach your app (headers, IPs, geo, TLS client
  identity)?
- Which security decisions consume those values (rate limiting, geo-gating,
  IP allow-lists, "internal" flags)? What happens when they lie?
- Is anything treated as "internal traffic" that actually traverses shared
  infrastructure?

## Webhooks and callbacks (third party → your system)

- How is the sender authenticated — shared secret, signature, IP allow-list,
  nothing? Verify the actual code path, not the docs.
- Can an event be replayed? Is there idempotency, timestamp freshness, nonce?
- What is the blast radius of one forged event (refunds, provisioning,
  privilege changes)?

## Authentication and sessions

- Where are tokens minted, stored, and validated — and by whom? If any one of
  those parties is compromised, what follows?
- Intended vs actual scope: does a "read" token technically permit writes?
  Does a "user" token reach admin paths via missing checks?
- Token lifetime and revocation: if a token leaks, how long is it useful and
  can you actually kill it?

## Service-to-service (your service → your service)

- Is "internal" treated as "trusted"? What authentication exists on internal
  calls — mTLS, tokens, network policy, or vibes?
- If one service is compromised, which others accept its requests without
  question? Draw the lateral-movement graph.
- Do internal APIs validate input, or only the public edge does?

## Data stores (app → database / queue / object store)

- Can the app reach data beyond its tenant (missing tenant filter, overly
  broad IAM role, shared credentials)?
- Who else holds credentials to the store (backups, analytics jobs, vendors)?
  Invert each one.
- Are signed URLs / presigned tokens scoped to least privilege and short
  lifetimes?

## CI/CD and supply chain

- If a dependency is malicious (or a maintainer account is taken over), what
  does it execute with — build machines, deploy keys, production secrets?
- Who can push to the pipeline: branch protections, required reviews, signed
  commits — verified in settings, not assumed?
- Do build artifacts get verified before deploy (checksums, signatures,
  provenance), or is "latest from CI" trusted blindly?

## Human approval steps

- What does the approver actually verify vs rubber-stamp? If the request is
  crafted to look routine, does the check still catch it?
- Can the requester also approve (self-approval, shared accounts)?
- Is the approval bound to the exact action (amount, target, parameters), or
  to a vague description an attacker can satisfy?

## AI / agent boundaries (model output → decisions and actions)

- Is model or tool output parsed as structured data without schema validation?
  Invert: the output is attacker-shaped (prompt injection, poisoned tool
  result) — what decision or action follows?
- Does the agent hold credentials broader than its task needs? Invert the
  task: a confused or hijacked agent with those credentials does what?
- Are tool results attributed correctly — can output from an untrusted tool
  be mistaken for output from a trusted one?

## Clients you ship (browser, mobile, desktop)

- What does the client enforce that the server re-checks? Anything enforced
  only client-side is a suggestion, not a control.
- If the client binary/config is tampered with, what server-side assumptions
  break (request shape, rate, ordering, "impossible" states)?

## Vendors and SaaS (you → third party)

- What data do they hold, and what happens if *they* are breached — not if
  you are?
- Can you revoke their access quickly (API keys, OAuth grants, webhooks)?
  Have you ever tested revocation?
- Does their status page / security posture get monitored, or is the
  integration trusted forever after setup?
