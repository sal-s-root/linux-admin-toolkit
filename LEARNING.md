# Engineering notes: Linux fundamentals

## Objective

Understand how an operating system reports capacity before automating changes.

## Design decisions

- Use `df -P` for a predictable filesystem table and quote shell variables.
- Separate normal output from errors; exit 1 indicates a threshold alert and exit 2 invalid input.
- Keep inspection read-only so a diagnostic script cannot accidentally delete data.

## Verification performed

| Check | Observed result |
|---|---|
| `bash -n inventory.sh disk-check.sh` | Passed; exit 0 as expected |
| `bash inventory.sh` | Passed; exit 0 as expected |
| `bash disk-check.sh 100` | Passed; exit 0 as expected |
| `bash disk-check.sh invalid` | Passed; exit 2 as expected |

## What the evidence establishes

The script checks only the root filesystem. Container observations do not describe all host mounts or application health.

## Next exercise

Add an explicitly selected filesystem and test alert behavior with controlled command fixtures. Then schedule checks and define log retention.
