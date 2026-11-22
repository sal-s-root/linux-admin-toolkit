#!/usr/bin/env bash
set -euo pipefail
threshold="${1:-85}"
if [[ ! "$threshold" =~ ^[0-9]{1,3}$ ]] || (( 10#$threshold < 1 || 10#$threshold > 100 )); then
  echo 'Usage: bash disk-check.sh [threshold: 1-100]' >&2
  exit 2
fi
used=$(df -Pk / | awk 'NR==2 {gsub(/%/, "", $5); print $5}')
printf 'Root disk usage: %s%% (threshold %s%%)\n' "$used" "$threshold"
if (( used >= 10#$threshold )); then
  echo 'WARNING: investigate disk usage before deleting anything' >&2
  exit 1
fi
