# Linux administration toolkit

## Purpose

Practice shell quoting, process exit codes, and Linux resource inspection.

## Run locally

```sh
bash inventory.sh
bash disk-check.sh 85
```

## Scope and limitations

Linux and Bash required. Reports only the root filesystem. A container sees its own filesystem and kernel view.

## Engineering notes

See [LEARNING.md](LEARNING.md) for the design decisions, verification evidence,
and next steps. Never commit credentials, private hostnames, or real incident data.
