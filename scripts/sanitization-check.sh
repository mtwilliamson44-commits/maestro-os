#!/usr/bin/env bash
# Fails if any private/sensitive token appears in tracked files.
# Whitelist-in safety net for the public Maestro repo.
set -euo pipefail

DENY=(
  "FoundryERP" "Foundry ERP" "TradingOS" "Trading OS" "Spill" "Celiin"
  "EventacyGovCon" "Eventacy" "Williamson" "OHD" "Oslo" "Steinar"
  "Tara" "Wendy" "AtibaOS" "/Users/mitchellatiba" "mtwilliamson44"
  "m@mitchellatiba.com"
)

fail=0
for token in "${DENY[@]}"; do
  if git grep -n -F -- "$token" -- ':!scripts/sanitization-check.sh' >/dev/null 2>&1; then
    echo "DENYLIST HIT: '$token'"
    git grep -n -F -- "$token" -- ':!scripts/sanitization-check.sh' || true
    fail=1
  fi
done

if [ "$fail" -ne 0 ]; then
  echo "Sanitization check FAILED."
  exit 1
fi
echo "Sanitization check passed."
