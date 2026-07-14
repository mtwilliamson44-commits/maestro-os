#!/usr/bin/env bash
# Fails if any private/sensitive token appears in tracked files.
# Whitelist-in safety net for the public Maestro repo.
#
# The denylist itself is sensitive (it names the very things we hide), so it
# lives in .sanitization/denylist.txt, which is gitignored and never published.
# Locally (where commits happen) the file is present and the gate runs. On a
# fresh public checkout / CI the file is absent, so the gate skips cleanly.
set -euo pipefail

DENYLIST_FILE=".sanitization/denylist.txt"

if [ ! -f "$DENYLIST_FILE" ]; then
  echo "No local denylist ($DENYLIST_FILE) present — skipping sanitization gate."
  exit 0
fi

fail=0
while IFS= read -r token; do
  [ -z "$token" ] && continue
  case "$token" in \#*) continue ;; esac
  if git grep -n -F -- "$token" -- ':!scripts/sanitization-check.sh' ':!.sanitization/*' >/dev/null 2>&1; then
    echo "DENYLIST HIT: '$token'"
    git grep -n -F -- "$token" -- ':!scripts/sanitization-check.sh' ':!.sanitization/*' || true
    fail=1
  fi
done < "$DENYLIST_FILE"

if [ "$fail" -ne 0 ]; then
  echo "Sanitization check FAILED."
  exit 1
fi
echo "Sanitization check passed."
