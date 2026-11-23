#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")/.."
bash -n inventory.sh disk-check.sh uptime-report.sh checks/resource-report.sh
bash inventory.sh >/dev/null
bash uptime-report.sh | grep -q '^Uptime:'
set +e
DISK_THRESHOLD=invalid bash checks/resource-report.sh >/dev/null 2>&1
status=$?
set -e
[[ $status -eq 2 ]]
# A df fixture exercises an alert without filling a filesystem.
fixture=$(mktemp -d)
trap 'rm -rf "$fixture"' EXIT
cat >"$fixture/df" <<'EOF'
#!/bin/sh
printf 'Filesystem 1024-blocks Used Available Capacity Mounted on\nfixture 100 95 5 95%% /\n'
EOF
chmod +x "$fixture/df"
set +e
PATH="$fixture:$PATH" DISK_THRESHOLD=85 bash checks/resource-report.sh >"$fixture/result"
status=$?
set -e
[[ $status -eq 1 ]]
grep -q 'disk_threshold_exceeded=1' "$fixture/result"
echo 'Linux checks passed: syntax, execution, invalid configuration, disk alert.'
