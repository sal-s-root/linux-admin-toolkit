#!/usr/bin/env bash
set -euo pipefail
threshold=${DISK_THRESHOLD:-85}
if [[ ! $threshold =~ ^[0-9]{1,3}$ ]]; then
  echo 'DISK_THRESHOLD must be 1-100' >&2
  exit 2
fi
if (( 10#$threshold < 1 || 10#$threshold > 100 )); then
  echo 'DISK_THRESHOLD must be 1-100' >&2
  exit 2
fi
used=$(df -Pk / | awk 'NR==2 {gsub(/%/, "", $5); print $5}')
printf 'root_disk_used_percent=%s\n' "$used"
awk '/^MemTotal:/ {total=$2} /^MemAvailable:/ {available=$2} END {if (total>0) printf "memory_unavailable_percent=%.2f\n", 100*(total-available)/total}' /proc/meminfo
if (( used >= 10#$threshold )); then
  echo 'disk_threshold_exceeded=1'
  exit 1
fi
