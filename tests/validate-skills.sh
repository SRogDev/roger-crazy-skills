#!/usr/bin/env bash
#
# validate-skills.sh — structural validation for the roger-crazy-skills repository.
#
# Checks every skills/<name>/SKILL.md for:
#   1. presence and parseable YAML frontmatter
#   2. name/description validity per the Agent Skills spec
#      (name: 1-64 chars, [a-z0-9-], no leading/trailing/consecutive hyphens,
#       matches directory name; description: 1-1024 chars, non-empty)
#   3. body non-empty (warns when > 500 lines)
#   4. safe relative file references (no absolute paths, no `..` escapes)
#   5. referenced local files actually exist
#   6. no accidental secrets (API keys, private key markers)
#
# Usage: ./tests/validate-skills.sh [--expect N] [repo-root]
# Exit code: 0 when all skills pass, 1 otherwise.

set -euo pipefail

EXPECT=""
ROOT=""

for arg in "$@"; do
  case "$arg" in
    --expect) EXPECT="__next__" ;;
    __next__marker) ;;
    *)
      if [[ "$EXPECT" == "__next__" ]]; then EXPECT="$arg"; else ROOT="$arg"; fi
      ;;
  esac
done

if [[ -z "$ROOT" ]]; then
  ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
fi
SKILLS_DIR="$ROOT/skills"

if [[ ! -d "$SKILLS_DIR" ]]; then
  echo "FAIL: skills/ directory not found at $SKILLS_DIR"
  exit 1
fi

python3 - "$SKILLS_DIR" "$EXPECT" <<'PYEOF'
import os, re, sys

skills_dir = sys.argv[1]
expect = sys.argv[2] or None

SECRET_PATTERNS = [
    (r'\bAKIA[0-9A-Z]{16}\b', 'AWS access key'),
    (r'\bghp_[A-Za-z0-9]{20,}\b', 'GitHub personal token'),
    (r'\bgsk_[A-Za-z0-9]{20,}\b', 'API key'),
    (r'\bsk-(live|test)-[A-Za-z0-9]{10,}\b', 'Stripe-style secret key'),
    (r'-----BEGIN (?:RSA |EC |OPENSSH )?PRIVATE KEY-----', 'private key block'),
    (r'(?i)\bapi[_-]?key\s*[:=]\s*["\'][^"\']{8,}["\']', 'hardcoded api_key'),
]

NAME_RE = re.compile(r'^[a-z0-9](?:[a-z0-9-]{0,62}[a-z0-9])?$')
LINK_RE = re.compile(r'\[[^\]]*\]\(([^)\s]+)\)')
ABS_RE = re.compile(r'^(?:[a-zA-Z][a-zA-Z0-9+.-]*:|/)')

errors, warnings = [], []

def err(skill, msg): errors.append(f"[{skill}] {msg}")
def warn(skill, msg): warnings.append(f"[{skill}] {msg}")

def parse_frontmatter(text):
    if not text.startswith('---'):
        return None, None, 'missing opening --- frontmatter delimiter'
    end = text.find('\n---', 3)
    if end == -1:
        return None, None, 'missing closing --- frontmatter delimiter'
    raw = text[3:end].strip('\n')
    fm = {}
    for line in raw.splitlines():
        if not line.strip() or line.lstrip().startswith('#'):
            continue
        if ':' not in line:
            return None, None, f'malformed frontmatter line: {line!r}'
        k, v = line.split(':', 1)
        fm[k.strip()] = v.strip().strip('"').strip("'")
    return fm, raw, None

def check_skill(skill_dir):
    skill = os.path.basename(skill_dir)
    path = os.path.join(skill_dir, 'SKILL.md')
    if not os.path.isfile(path):
        err(skill, 'SKILL.md missing')
        return
    with open(path, encoding='utf-8') as f:
        text = f.read()
    fm, raw, fm_err = parse_frontmatter(text)
    if fm_err:
        err(skill, f'frontmatter: {fm_err}')
        return
    # Strict-YAML compatibility: parsers used by the skills CLI and similar
    # tooling reject an unquoted ': ' (colon+space) inside a plain scalar
    # ("nested mappings are not allowed in compact mappings"). Quote the value.
    for line in raw.splitlines():
        s = line.strip()
        if not s or s.startswith('#') or ':' not in s:
            continue
        k, v = s.split(':', 1)
        v = v.strip()
        if v and v[0] not in ('"', "'") and ': ' in v:
            err(skill, f"strict-YAML risk: unquoted ': ' in frontmatter "
                       f"{k.strip()!r} — quote the value or strict parsers "
                       f"will reject this skill")
    name = fm.get('name', '')
    desc = fm.get('description', '')
    if not name:
        err(skill, 'frontmatter: name is required')
    else:
        if len(name) > 64:
            err(skill, f'name too long ({len(name)} > 64)')
        if not NAME_RE.match(name):
            err(skill, f'name {name!r} violates [a-z0-9-] rules (no leading/trailing/consecutive hyphens)')
        if name != skill:
            err(skill, f'name {name!r} does not match directory {skill!r}')
    if not desc:
        err(skill, 'frontmatter: description is required and must be non-empty')
    elif len(desc) > 1024:
        err(skill, f'description too long ({len(desc)} > 1024)')
    body = text.split('\n---', 1)[-1] if '\n---' in text[3:] else ''
    # body = everything after the closing delimiter
    end = text.find('\n---', 3)
    body = text[end + 4:] if end != -1 else ''
    if not body.strip():
        err(skill, 'body is empty: skill has no instructions')
    nlines = body.count('\n')
    if nlines > 500:
        warn(skill, f'body is {nlines} lines (>500 recommended); consider progressive disclosure')
    # link / path safety
    for m in LINK_RE.finditer(body):
        target = m.group(1).split('#')[0].strip()
        if not target or target.startswith(('http://', 'https://', 'mailto:')):
            continue
        if target.startswith('/'):
            err(skill, f'absolute path reference: {target!r} (use relative paths)')
            continue
        if '..' in target.split('/'):
            err(skill, f'path escapes skill dir: {target!r}')
            continue
        skill_abs = os.path.abspath(skill_dir)
        full = os.path.abspath(os.path.join(skill_dir, target))
        if not (full == skill_abs or full.startswith(skill_abs + os.sep)):
            err(skill, f'reference escapes skill dir: {target!r}')
        elif not os.path.exists(full):
            err(skill, f'referenced file does not exist: {target!r}')
    # secrets scan (whole file)
    for pat, label in SECRET_PATTERNS:
        if re.search(pat, text):
            err(skill, f'possible secret committed: {label}')

skill_names = sorted(d for d in os.listdir(skills_dir)
                     if os.path.isdir(os.path.join(skills_dir, d)) and not d.startswith('.'))
if expect:
    try:
        n = int(expect)
    except ValueError:
        print('FAIL: --expect needs an integer'); sys.exit(1)
    if len(skill_names) != n:
        errors.append(f'[repo] expected {n} skills, found {len(skill_names)}: {skill_names}')

for s in skill_names:
    check_skill(os.path.join(skills_dir, s))

for w in warnings:
    print('WARN ' + w)
if errors:
    for e in errors:
        print('FAIL ' + e)
    print(f'\n{len(errors)} error(s) in {len(skill_names)} skill(s)')
    sys.exit(1)
print(f'OK: {len(skill_names)} skill(s) structurally valid' + (f' ({len(warnings)} warning(s))' if warnings else ''))
PYEOF
