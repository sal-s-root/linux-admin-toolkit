#!/usr/bin/env bash
set -euo pipefail
printf 'Host: %s\n' "$(hostname)"
printf 'Kernel: %s\n' "$(uname -sr)"
printf '\nRoot filesystem\n'
df -Pk /
printf '\nMemory (Linux /proc)\n'
if [[ -r /proc/meminfo ]]; then
  awk '/^(MemTotal|MemAvailable):/ {print}' /proc/meminfo
else
  printf 'Memory statistics unavailable\n'
fi
