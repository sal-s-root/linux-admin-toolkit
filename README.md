# Linux administration toolkit

Read-only shell tools for host inventory, disk alerts, memory snapshots, and uptime.
The scheduled check is packaged as a hardened systemd oneshot and timer.

```sh
bash inventory.sh
bash checks/resource-report.sh
make test
```

Exit 0 means no disk threshold alert, 1 means the threshold was exceeded, and 2
means invalid configuration. `DISK_THRESHOLD=90` changes the disk threshold.
Memory is reported as an observation and does not trigger the disk alert.

## Optional systemd installation

Review the files first, then on a Linux lab VM with systemd:

```sh
sudo install -Dm755 checks/resource-report.sh /usr/local/lib/infra-toolkit/resource-report.sh
sudo install -m644 systemd/infra-resource-check.{service,timer} /etc/systemd/system/
sudo systemctl daemon-reload
sudo systemctl enable --now infra-resource-check.timer
journalctl -u infra-resource-check.service
```

A nonzero oneshot status records an alert in the journal; this is not a paging
integration. Uninstall by disabling the timer and removing those three files.
The systemd units provide an optional VM installation exercise.

## Operations

See [disk investigation](RUNBOOK.md). Container memory and mount views can differ
from host resource limits. Uptime usually reflects the shared kernel. No script
removes files or restarts services. Tests use a controlled `df` fixture to exercise
an alert without consuming real disk space.

## Project history

See [history and scope](HISTORY.md) for the correction of earlier synthetic dates.
