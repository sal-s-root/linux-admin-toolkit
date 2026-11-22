# Disk usage investigation

1. Run `df -h /` to confirm filesystem capacity.
2. Inspect directories with `du -x -h -d 1 /var` where supported.
3. Check log rotation and deleted files still held open (`lsof +L1`, if installed).
4. Identify the owning service before removing files. Use retention policies.
5. Recheck disk space and application health after an approved cleanup.

The scripts are read-only and do not remove files or require root.
