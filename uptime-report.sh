#!/usr/bin/env bash
set -euo pipefail
if [[ ! -r /proc/uptime ]]; then
  echo 'Linux /proc/uptime is unavailable' >&2
  exit 2
fi
awk '{seconds=int($1); printf "Uptime: %d days %02d:%02d:%02d\n", int(seconds/86400), int(seconds/3600)%24, int(seconds/60)%60, seconds%60}' /proc/uptime
