#!/usr/bin/env bash
# gsd-lite: a dependency-free orchestration loop.
# Usage: ./run.sh            -> list stages
#        ./run.sh <stage>    -> print that stage's prompt
set -euo pipefail

DIR="$(cd "$(dirname "$0")" && pwd)"
STAGES=(discuss plan execute review verify)

if [ "$#" -eq 0 ]; then
  echo "Maestro gsd-lite workflow stages:"
  i=0
  for s in "${STAGES[@]}"; do
    printf "  %02d-%s\n" "$i" "$s"
    i=$((i+1))
  done
  echo "Run: ./run.sh <stage>  (e.g. ./run.sh plan)"
  exit 0
fi

stage="$1"
i=0
for s in "${STAGES[@]}"; do
  if [ "$s" = "$stage" ]; then
    file="$(printf "%s/%02d-%s.md" "$DIR" "$i" "$s")"
    cat "$file"
    exit 0
  fi
  i=$((i+1))
done

echo "Unknown stage: $stage" >&2
echo "Valid stages: ${STAGES[*]}" >&2
exit 1
